//
//  File.swift
//  Peek-Example
//
//  Created by Shaps Benkau on 21/02/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit
import GraphicsRenderer

internal final class InspectorViewController: PeekSectionedViewController {
    
    private let model: Model
    private let coordinator: PeekCoordinator
    private let dataSource: ContextDataSource
    private var reportingIndexPaths: [IndexPath: Report.Item] = [:]
    
    internal init(peek: Peek, model: Model & Peekable) {
        self.model = model
        
        self.coordinator = PeekCoordinator(model: model)
        model.preparePeek(with: coordinator)
        
        self.dataSource = ContextDataSource(coordinator: coordinator)
        
        super.init(peek: peek)
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        if navigationController?.viewControllers.count == 1 {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        }
        
        prepareNavigationItems(animated: false)
    
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !tableView.isEditing, let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: Unused
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = super.tableView(tableView, viewForHeaderInSection: section) as? SectionHeaderView else { fatalError() }
        header.prepareHeader(for: section, delegate: self)
        return header
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let attribute = dataSource.attribute(at: indexPath)
        return !(attribute is PreviewAttribute)
    }
    
    override func sectionTitle(for section: Int) -> String {
        return dataSource.sections[section].group.title
    }
    
    override func sectionIsExpanded(for section: Int) -> Bool {
        return dataSource.sections[section].isExpanded
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sections.count
    }
    
    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.sections[section].items.count
    }
    
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attribute = dataSource.attribute(at: indexPath)
        
        if let preview = attribute as? PreviewAttribute,
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as? PreviewCell {
            cell.previewImageView.image = preview.image
            return cell
        }
        
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? InspectorCell else { fatalError() }
        cell.textLabel?.text = attribute.title
        
        let value = attribute.valueTransformer?(attribute.value) ?? attribute.value
        if let value = value as? NSObjectProtocol {
            var text: String?
            var accessoryView: UIView?
            var editingAccessoryView: UIView?
            
            switch value {
            case is UIViewController:
                if let value = value as? UIViewController {
                    text = String(describing: value.classForCoder)
                }
            case is [AnyObject]:
                if let value = value as? [AnyObject] {
                    text = "\(value.count)"
                }
            case is UIFont:
                if let value = value as? UIFont {
                    text = "\(value.fontName), \(value.pointSize)"
                }
            case is UIImageView, is UILabel, is UIBarButtonItem, /*is Segment,*/ is UIImage:
                text = nil
            case is NSAttributedString:
                if let value = value as? NSAttributedString {
                    text = value.string
                }
            case is NSNumber:
                if let value = value as? NSNumber {
                    text = NumberTransformer().transformedValue(value) as? String
                    accessoryView = value.isBool() ? BoolAccessoryView(value: value.boolValue) : nil
                }
            case is UIColor:
                if let value = value as? UIColor {
                    text = ColorTransformer().transformedValue(value) as? String
                    accessoryView = ColorAccessoryView(color: value)
                }
            case is NSValue:
                if let value = value as? NSValue {
                    text = ValueTransformer().transformedValue(value) as? String
                }
            default: text = "\(value)"
            }
            
            if CFGetTypeID(value) == CGColor.typeID {
                text = ColorTransformer().transformedValue(value) as? String
                //swiftlint:disable force_cast
                accessoryView = ColorAccessoryView(color: UIColor(cgColor: value as! CGColor))
            }
            
            if let value = value as? PeekableContainer {
                cell.accessoryType = tableView.isEditing ? .none : .disclosureIndicator
            }
            
            cell.accessoryView = accessoryView
            cell.editingAccessoryView = accessoryView
            cell.detailTextLabel?.text = attribute.detail ?? text
        } else {
            cell.detailTextLabel?.text = "none"
        }
        
        return cell
    }
    
}

extension InspectorViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: false)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard !tableView.isEditing, let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        
        let attribute = dataSource.attribute(at: indexPath)
        
        if let value = attribute.value as? Model & PeekableContainer {
            return InspectorViewController(peek: peek, model: value)
        } else {
            return nil
        }
    }
    
}

// MARK: - Reporting
extension InspectorViewController {
    
    private func prepareNavigationItems(animated: Bool) {
        reportingIndexPaths.removeAll()
        
        if tableView.isEditing {
            let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(endReport))
            navigationItem.setLeftBarButton(cancel, animated: animated)
            navigationItem.setHidesBackButton(true, animated: animated)
            
            let send = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(showReport))
            send.isEnabled = false
            navigationItem.setRightBarButton(send, animated: animated)
            
            UIView.animate(withDuration: animated ? 0.25 : 0) {
                self.navigationController?.navigationBar.backgroundColor = .editingTint
                self.navigationController?.navigationBar.tintColor = .white
            }
            
            tableView.tintColor = .editingTint
        } else {
            let size = CGSize(width: 22, height: 12)
            let disclosure = Images.disclosure(size: size, thickness: 2)
            let close = UIBarButtonItem(image: disclosure, style: .plain, target: self, action: #selector(dismissController))
            navigationItem.setRightBarButton(close, animated: animated)
            
            let report = UIBarButtonItem(image: Images.report, style: .plain, target: self, action: #selector(beginReport))
            navigationItem.setLeftBarButton(report, animated: animated)
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.setHidesBackButton(false, animated: animated)
            
            let image = ImageRenderer(size: CGSize(width: 44, height: 20)).image { context in
                var rect = context.format.bounds
                rect.origin.y = 4
                rect.size.height = 4
                let path = UIBezierPath(roundedRect: rect, cornerRadius: 2)
                
                UIColor(white: 1, alpha: 0.7).setFill()
                path.fill()
            }
            
            UIView.animate(withDuration: animated ? 0.25 : 0) {
                self.navigationController?.navigationBar.backgroundColor = .inspectorBackground
                self.navigationController?.navigationBar.tintColor = .primaryTint
            }
            
            tableView.tintColor = .primaryTint
        }
    }
    
    @objc private func beginReport() {
        tableView.setEditing(true, animated: true)
        prepareNavigationItems(animated: true)
    }
    
    @objc private func showReport() {
        let sectionIndexes = Set(reportingIndexPaths.map { $0.key.section }).sorted()
        let sections: [Report.Section] = sectionIndexes.map { index in
            let title = dataSource.sections[index].group.title
            let items = reportingIndexPaths.filter { $0.key.section == index }.flatMap { $0.value }
            return Report.Section(title: title, items: items)
        }
        
        let report = Report(sections: sections)
        let controller = ReportViewController(peek: peek, report: report)
        
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func endReport(animated: Bool) {
        func end(animated: Bool) {
            tableView.setEditing(false, animated: animated)
            prepareNavigationItems(animated: animated)
            
            if let controller = presentedViewController {
                controller.dismiss(animated: animated, completion: nil)
            }
        }
        
        if reportingIndexPaths.count > 0 {
            let alert = UIAlertController(title: "Cancel Report", message: "Are you sure you want to cancel this report?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes, Cancel", style: .destructive) { _ in
                end(animated: true)
            })
            present(alert, animated: true, completion: nil)
        } else {
            end(animated: true)
        }
    }
    
    @objc private func showSettings() {
        print("Show settings no implemented")
    }
    
}

extension InspectorViewController: ReportViewControllerDelegate {
    
    func reportController(_ controller: ReportViewController, didSend report: Report) {
        endReport(animated: false)
        navigationController?.popViewController(animated: true)
    }
    
    func reportControllerDidCancel(_ controller: ReportViewController) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension InspectorViewController: SectionHeaderViewDelegate {
    
    func sectionHeader(_ view: SectionHeaderView, shouldToggleAt index: Int) {
        dataSource.toggleVisibility(forSection: index)
        let expanded = dataSource.sections[index].isExpanded
        
        view.setExpanded(expanded) { [weak self] in
            let section = IndexSet(integer: index)
            self?.tableView.reloadSections(section, with: .automatic)
            
            self?.reportingIndexPaths
                .filter { $0.key.section == index }
                .forEach { self?.tableView.selectRow(at: $0.key, animated: true, scrollPosition: .none) }
        }
    }
    
}

extension InspectorViewController {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let attribute = dataSource.attribute(at: indexPath)
        if attribute.value is UIColor { return true }
        return !(attribute is PreviewAttribute)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let attribute = self.dataSource.attribute(at: indexPath)
        let cell = tableView.cellForRow(at: indexPath)
        
        if !tableView.isEditing, let value = attribute.value as? Model & PeekableContainer {
            let controller = InspectorViewController(peek: peek, model: value)
            navigationController?.pushViewController(controller, animated: true)
            
            return
        }
        
        if tableView.isEditing {
            let controller = UIAlertController(title: "Report Issue", message: "Select the reason for reporting this issue", preferredStyle: .actionSheet)
            controller.popoverPresentationController?.sourceView = cell
            controller.popoverPresentationController?.sourceRect = cell?.bounds ?? .zero
            
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                tableView.deselectRow(at: indexPath, animated: true)
            }))
            
            if let value = attribute.value as? NSNumber, value.isBool() {
                let note = "Expected \(value.boolValue ? "false" : "true")"
                controller.addAction(UIAlertAction(title: note, style: .destructive, handler: { [weak self] _ -> Void in
                    let item = Report.Item(model: self?.model, keyPath: attribute.keyPath, displayTitle: attribute.title, displayValue: cell?.detailTextLabel?.text ?? "", reportersNote: note)
                    self?.reportingIndexPaths[indexPath] = item
                    self?.invalidateSendButton()
                }))
            } else if attribute.value == nil {
                controller.addAction(UIAlertAction(title: "Missing Value", style: .destructive, handler: { [weak self] _ -> Void in
                    let item = Report.Item(model: self?.model, keyPath: attribute.keyPath, displayTitle: attribute.title, displayValue: cell?.detailTextLabel?.text ?? "", reportersNote: "Missing Value")
                    self?.reportingIndexPaths[indexPath] = item
                    self?.invalidateSendButton()
                }))
            } else {
                controller.addAction(UIAlertAction(title: "Wrong Value", style: .destructive, handler: { [weak self] _ -> Void in
                    let item = Report.Item(model: self?.model, keyPath: attribute.keyPath, displayTitle: attribute.title, displayValue: cell?.detailTextLabel?.text ?? "", reportersNote: "Wrong Value")
                    self?.reportingIndexPaths[indexPath] = item
                    self?.invalidateSendButton()
                }))
            }
            
            controller.addAction(UIAlertAction(title: "Suggest Alternative", style: .default, handler: { [weak self] _ -> Void in
                let alert = UIAlertController(title: "\(attribute.title)", message: "What is the expected value?", preferredStyle: .alert)
                
                alert.addTextField { field in
                    if attribute.valueTransformer == nil,
                        let value = attribute.value as? NSNumber,
                        !value.isBool() {
                        field.keyboardType = .decimalPad
                    } else {
                        field.autocapitalizationType = .sentences
                    }
                    
                    field.keyboardAppearance = .dark
                }
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    tableView.deselectRow(at: indexPath, animated: true)
                })
                
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    let note = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                    let item = Report.Item(model: self?.model, keyPath: attribute.keyPath, displayTitle: attribute.title, displayValue: cell?.detailTextLabel?.text ?? "", reportersNote: note ?? "")
                    self?.reportingIndexPaths[indexPath] = item
                    self?.invalidateSendButton()
                })
                
                self?.present(alert, animated: true, completion: nil)
            }))
            
            present(controller, animated: true, completion: nil)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        reportingIndexPaths[indexPath] = nil
        invalidateSendButton()
    }
    
    private func invalidateSendButton() {
        navigationItem.rightBarButtonItem?.isEnabled = reportingIndexPaths.count > 0
    }
    
}
