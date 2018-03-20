//
//  File.swift
//  Peek-Example
//
//  Created by Shaps Benkau on 21/02/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit
import GraphicsRenderer

internal final class PeekInspectorViewController: PeekSectionedViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(observer)
    }
    
    internal lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.dimsBackgroundDuringPresentation = false
//        controller.obscuresBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        controller.searchBar.barTintColor = navigationController?.navigationBar.barTintColor
        controller.searchBar.tintColor = navigationController?.navigationBar.tintColor
        controller.searchBar.autocorrectionType = .yes
        controller.searchBar.autocapitalizationType = .none
        controller.searchBar.enablesReturnKeyAutomatically = true
        controller.searchResultsUpdater = self
        return controller
    }()
    
    private lazy var reportButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 24)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .counter
        button.layer.cornerRadius = button.bounds.height / 2
        button.layer.masksToBounds = true
        return button
    }()
    
    private let model: Model & Peekable
    private let coordinator: PeekCoordinator
    private let dataSource: ContextDataSource
    private var reportingIndexPaths: [IndexPath: Report.Item] = [:] {
        didSet {
            let count = reportingIndexPaths.count
            let title = "\(count) issue\(count == 1 ? "" : "s")"
            reportButton.setTitle(title, for: .normal)
        }
    }
    
    private var observer: Any?
    private var feedbackGenerator: Any?
    
    @available(iOS 10.0, *)
    private func haptic() -> UISelectionFeedbackGenerator? {
        return feedbackGenerator as? UISelectionFeedbackGenerator
    }
    
    internal init(peek: Peek, model: Model & Peekable) {
        self.model = model
        self.coordinator = PeekCoordinator(model: model)
        model.preparePeek(with: coordinator)
        
        self.dataSource = ContextDataSource(coordinator: coordinator)
        
        super.init(peek: peek)
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        if title == nil {
            title = "Peek"
        }
        
        if navigationController?.viewControllers.count == 1 {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        prepareNavigationItems(animated: false)
    
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)
        }
        
        observer = NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: .main) { [weak self] _ in
            // we have to add a delay to allow the app to finish updating its layout.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.tableView.reloadData()
            }
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
        guard let header = super.tableView(tableView, viewForHeaderInSection: section) as? CollapsibleSectionHeaderView else { fatalError() }
        header.prepareHeader(for: section, delegate: self)
        return header
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        guard tableView.isEditing else { return !(dataSource.attribute(at: indexPath) is PreviewAttribute) }
        return self.tableView(tableView, canEditRowAt: indexPath)
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
            cell.contentView.backgroundColor = peek.options.theme.backgroundColor
            cell.backgroundColor = peek.options.theme.backgroundColor
            return cell
        }
        
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? InspectorCell else { fatalError() }
        cell.contentView.backgroundColor = peek.options.theme.backgroundColor
        cell.backgroundColor = peek.options.theme.backgroundColor
        
        // TODO: Bit of repitition here for showing hierarchy, but its temporary for this release.
        if let modelAsView = model as? UIView,
            let attributeAsView = attribute.value as? UIView,
            dataSource.sections[indexPath.section].group.group == .views {
            
            if attributeAsView == modelAsView {
                cell.indentationLevel = 1
                cell.textLabel?.text = "⊙ \(attribute.title)"
            } else if attributeAsView.superview == modelAsView {
                cell.indentationLevel = 2
                cell.textLabel?.text = "▹ \(attribute.title)"
            } else {
                cell.indentationLevel = 0
                cell.textLabel?.text = "▿ \(attribute.title)"
            }
        } else if let modelAsController = model as? UIViewController,
            let attributeAsController = attribute.value as? UIViewController,
            dataSource.sections[indexPath.section].group.group == .controllers {
            
            if attributeAsController == modelAsController {
                cell.indentationLevel = modelAsController.parent == nil ? 0 : 1
                cell.textLabel?.text = "⊙ \(attribute.title)"
            } else if attributeAsController.parent == modelAsController {
                cell.indentationLevel = 2
                cell.textLabel?.text = "▹ \(attribute.title)"
            } else {
                cell.indentationLevel = 0
                cell.textLabel?.text = "▿ \(attribute.title)"
            }
        } else {
            cell.indentationLevel = 0
            cell.textLabel?.text = attribute.title
        }
        
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
            
            if let value = value as? PeekInspectorNestable {
                cell.accessoryType = tableView.isEditing ? .none : .disclosureIndicator
            }
            
            if value === model {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryView = accessoryView
                cell.editingAccessoryView = accessoryView
            }
            
            cell.detailTextLabel?.text = attribute.detail ?? text
        } else {
            cell.detailTextLabel?.text = "none"
        }
        
        return cell
    }
    
}

extension PeekInspectorViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: false)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard !tableView.isEditing, let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        
        let attribute = dataSource.attribute(at: indexPath)
        
        if !(attribute is PreviewAttribute), let value = attribute.value as? PeekInspectorNestable {
            let controller = PeekInspectorViewController(peek: peek, model: value)
            controller.title = attribute.title
            return controller
        } else {
            return nil
        }
    }
    
}

// MARK: - Reporting
extension PeekInspectorViewController {
    
    private func prepareNavigationItems(animated: Bool) {
        reportingIndexPaths.removeAll()
        
        if tableView.isEditing {
            let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelReport(_:)))
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
            navigationItem.titleView = reportButton
        } else {
            let size = CGSize(width: 22, height: 12)
            let disclosure = Images.disclosure(size: size, thickness: 2)
            let close = UIBarButtonItem(image: disclosure, style: .plain, target: self, action: #selector(dismissController))
            navigationItem.setRightBarButton(close, animated: animated)
            
            if !(model is UIDevice || model is UIScreen) {
                let report = UIBarButtonItem(image: Images.report, style: .plain, target: self, action: #selector(beginReport))
                navigationItem.setLeftBarButton(report, animated: animated)
            }
            
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
                self.navigationController?.navigationBar.backgroundColor = self.peek.options.theme.backgroundColor
                self.navigationController?.navigationBar.tintColor = .primaryTint
            }
            
            tableView.tintColor = .primaryTint
            navigationItem.titleView = nil
        }
    }
    
    @objc private func beginReport() {
        tableView.setEditing(true, animated: true)
        prepareNavigationItems(animated: true)
        
        if #available(iOS 10.0, *) {
            feedbackGenerator = UISelectionFeedbackGenerator()
        }
    }
    
    @objc private func showReport() {
        let sectionIndexes = Set(reportingIndexPaths.map { $0.key.section }).sorted()
        
        let sections: [Report.Section] = sectionIndexes.map { index in
            let title = dataSource.sections[index].group.title
            let items = reportingIndexPaths.filter { $0.key.section == index }.flatMap { $0.value }
            return Report.Section(title: title, items: items)
        }
        
        let report = Report(title: model.titleForPeekReport(), sections: sections, metadata: peek.options.metadata)
        let controller = ReportViewController(peek: peek, report: report)
        
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func cancelReport(_ sender: Any?) {
        endReport(cancelled: true, animated: true)
    }
    
    private func endReport(cancelled: Bool, animated: Bool) {
        func end(animated: Bool) {
            tableView.setEditing(false, animated: animated)
            prepareNavigationItems(animated: animated)
            
            if let controller = presentedViewController {
                controller.dismiss(animated: animated, completion: nil)
            }
        }
        
        if cancelled, reportingIndexPaths.count > 0 {
            let alert = UIAlertController(title: "Cancel Report", message: "Are you sure you want to cancel this report?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes, Cancel", style: .destructive) { _ in
                end(animated: true)
            })
            present(alert, animated: true, completion: nil)
        } else {
            end(animated: true)
        }
        
        feedbackGenerator = nil
    }
    
    @objc private func showSettings() {
        print("Show settings no implemented")
    }
    
}

extension PeekInspectorViewController: ReportViewControllerDelegate {
    
    func reportController(_ controller: ReportViewController, didSend report: Report) {
        endReport(cancelled: false, animated: false)
        navigationController?.popViewController(animated: true)
    }
    
    func reportControllerDidCancel(_ controller: ReportViewController) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension PeekInspectorViewController: CollapsibleSectionHeaderViewDelegate {
    
    func sectionHeader(_ view: CollapsibleSectionHeaderView, shouldToggleAt index: Int) {
        dataSource.toggleVisibility(forSection: index)
        let expanded = dataSource.sections[index].isExpanded
        
        if #available(iOS 10.0, *) {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        
        view.setExpanded(expanded) { [weak self] in
            let section = IndexSet(integer: index)
            self?.tableView.reloadSections(section, with: .automatic)
            
            self?.reportingIndexPaths
                .filter { $0.key.section == index }
                .forEach { self?.tableView.selectRow(at: $0.key, animated: true, scrollPosition: .none) }
        }
    }
    
}

extension PeekInspectorViewController {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if model is UIDevice || model is UIScreen {
            return false
        }
        
        switch dataSource.sections[indexPath.section].group.group {
        case .more, .views, .classes, .preview: return false
        default:
            return !(dataSource.attribute(at: indexPath).value is Constraints)
                && !(dataSource.attribute(at: indexPath) is PreviewAttribute)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing && !self.tableView(tableView, canEditRowAt: indexPath) { return }
        
        let attribute = self.dataSource.attribute(at: indexPath)
        let cell = tableView.cellForRow(at: indexPath)
        
        if !tableView.isEditing, let value = attribute.value as? PeekInspectorNestable, value !== model {
            let controller = PeekInspectorViewController(peek: peek, model: value)
            controller.title = attribute.title
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
                    let item = Report.Item(keyPath: attribute.keyPath, displayTitle: attribute.title, displayValue: cell?.detailTextLabel?.text ?? "", reportersNote: note)
                    self?.reportingIndexPaths[indexPath] = item
                    self?.invalidateSendButton()
                    self?.indicateSection(for: indexPath)
                }))
            } else if attribute.value == nil {
                controller.addAction(UIAlertAction(title: "Missing Value", style: .destructive, handler: { [weak self] _ -> Void in
                    let item = Report.Item(keyPath: attribute.keyPath, displayTitle: attribute.title, displayValue: cell?.detailTextLabel?.text ?? "", reportersNote: "Missing Value")
                    self?.reportingIndexPaths[indexPath] = item
                    self?.invalidateSendButton()
                    self?.indicateSection(for: indexPath)
                }))
            } else {
                controller.addAction(UIAlertAction(title: "Incorrect Value", style: .destructive, handler: { [weak self] _ -> Void in
                    let item = Report.Item(keyPath: attribute.keyPath, displayTitle: attribute.title, displayValue: cell?.detailTextLabel?.text ?? "", reportersNote: "Incorrect Value")
                    self?.reportingIndexPaths[indexPath] = item
                    self?.invalidateSendButton()
                    self?.indicateSection(for: indexPath)
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
                        field.spellCheckingType = .yes
                        field.autocorrectionType = .yes
                        field.autocapitalizationType = .sentences
                    }
                    
                    field.keyboardAppearance = .dark
                }
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    tableView.deselectRow(at: indexPath, animated: true)
                })
                
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    let note = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                    let item = Report.Item(keyPath: attribute.keyPath, displayTitle: attribute.title, displayValue: cell?.detailTextLabel?.text ?? "", reportersNote: note ?? "")
                    self?.reportingIndexPaths[indexPath] = item
                    self?.invalidateSendButton()
                    self?.indicateSection(for: indexPath)
                })
                
                self?.present(alert, animated: true, completion: nil)
            }))
            
            if #available(iOS 10.0, *) {
                haptic()?.selectionChanged()
            }
            
            present(controller, animated: true, completion: nil)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing && !self.tableView(tableView, canEditRowAt: indexPath) { return }
        
        reportingIndexPaths[indexPath] = nil
        invalidateSendButton()
        
        if #available(iOS 10.0, *) {
            haptic()?.selectionChanged()
        }
    }
    
    private func invalidateSendButton() {
        navigationItem.rightBarButtonItem?.isEnabled = reportingIndexPaths.count > 0
    }
    
    private func indicateSection(for indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath),
            let render = cell.snapshotView(afterScreenUpdates: true) {
            render.frame = cell.frameInPeek(view)
            view.addSubview(render)
            
            UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseIn, .allowUserInteraction], animations: {
                render.transform = CGAffineTransform(translationX: 0, y: -render.frame.minY)
                    .concatenating(CGAffineTransform(scaleX: 0.9, y: 0.9))
                render.alpha = 0
            }, completion: { _ in
                render.removeFromSuperview()
            })
        }
    }
    
}
