//
//  File.swift
//  Peek-Example
//
//  Created by Shaps Benkau on 21/02/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit
import GraphicsRenderer

internal final class InspectorViewController: UIViewController {
    
    internal let tableView: UITableView
    
    private let dataSource: ContextDataSource
    private let model: Model
    private let context: Context
    private unowned let peek: Peek
    
    private var selectedAttributes: [String] = []
    
    internal init(peek: Peek, model: Model, context: Context) {
        self.peek = peek
        self.context = context
        self.model = model
        
        self.tableView = UITableView(frame: .zero, style: .plain)
        self.dataSource = ContextDataSource(context: context, inspector: .attributes)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareNavigationItems(animated: false)
        prepareNavigationBar()
    
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)
        }
    }
    
    private func prepareNavigationBar() {
        if #available(iOS 11.0, *) {
            guard navigationController?.viewControllers.count == 1 else {
                navigationItem.largeTitleDisplayMode = .never
                return
            }
            
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.largeTitleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return peek.supportedOrientations
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return peek.previousStatusBarStyle
    }
    
}

extension InspectorViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: false)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard !tableView.isEditing, let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        
        let property = dataSource.property(at: indexPath)
        
        if let value = property.value(forModel: model) as? Model {
            let context = PeekContext()
            
            if let value = property.value(forModel: model) as? Peekable {
                value.preparePeek(context)
            }
            
            let controller = InspectorViewController(peek: peek, model: value, context: context)
            return controller
        } else {
            return nil
        }
    }
    
}

// MARK: - Reporting
extension InspectorViewController {
    
    private func prepareNavigationItems(animated: Bool) {
        selectedAttributes.removeAll()
        
        if tableView.isEditing {
            let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(endReport))
            navigationItem.setLeftBarButton(cancel, animated: animated)
            
            let send = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendReport))
            send.isEnabled = false
            navigationItem.setRightBarButton(send, animated: animated)
            
            UIView.animate(withDuration: animated ? 0.25 : 0) {
                self.navigationController?.navigationBar.backgroundColor = .editingTint
                self.navigationController?.navigationBar.tintColor = .white
                self.navigationItem.titleView = nil
            }
            
            tableView.tintColor = .editingTint
        } else {
//            let settings = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showSettings))
//            navigationItem.setLeftBarButton(settings, animated: animated)
            navigationItem.setLeftBarButton(nil, animated: animated)
            
            let report = UIBarButtonItem(title: "Report", style: .plain, target: self, action: #selector(beginReport))
            navigationItem.setRightBarButton(report, animated: animated)
            
            let image = ImageRenderer(size: CGSize(width: 44, height: 20)).image { context in
                var rect = context.format.bounds
                rect.origin.y = 4
                rect.size.height = 4
                let path = UIBezierPath(roundedRect: rect, cornerRadius: 2)
                
                UIColor(white: 1, alpha: 0.7).setFill()
                path.fill()
            }
            
            let button = UIButton(type: .system)
            button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
            button.setImage(image, for: .normal)
            button.tintColor = .neutral
            
            UIView.animate(withDuration: animated ? 0.25 : 0) {
                self.navigationController?.navigationBar.backgroundColor = .inspectorBackground
                self.navigationController?.navigationBar.tintColor = .primaryTint
                self.navigationItem.titleView = button
            }
            
            tableView.tintColor = .primaryTint
        }
    }
    
    @objc private func beginReport() {
        tableView.setEditing(true, animated: true)
        prepareNavigationItems(animated: true)
    }
    
    @objc private func sendReport() {
        let sheet = UIActivityViewController(activityItems: selectedAttributes, applicationActivities: nil)
        
        sheet.completionWithItemsHandler = { [weak self] type, success, activities, error in
            if success {
                self?.endReport()
            }
        }
        
        present(sheet, animated: true, completion: nil)
    }
    
    @objc private func endReport() {
        tableView.setEditing(false, animated: true)
        prepareNavigationItems(animated: true)
    }
    
    @objc private func showSettings() {
        print("Show settings no implemented")
    }
    
}

// MARK: - Table View Prep
extension InspectorViewController {
    
    private func prepareTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.sectionFooterHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.estimatedSectionHeaderHeight = 44
        tableView.estimatedSectionFooterHeight = 0
        tableView.keyboardDismissMode = .interactive
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .inspectorBackground
        tableView.separatorColor = .separator
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        tableView.register(InspectorCell.self, forCellReuseIdentifier: "InspectorCell")
        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "InspectorHeader")
        
        view.addSubview(tableView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor),
            equal(\.bottomAnchor), equal(\.topAnchor)
        ])
    }
    
}

extension InspectorViewController: SectionHeaderViewDelegate {
    
    func sectionHeader(_ view: SectionHeaderView, shouldToggleAt index: Int) {
        dataSource.toggleVisibility(forSection: index)
        let expanded = dataSource.sections[index].isExpanded
        
        view.setExpanded(expanded) { [weak self] in
            let section = IndexSet(integer: index)
            self?.tableView.reloadSections(section, with: .automatic)
        }
    }
    
}

extension InspectorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "InspectorHeader") as? SectionHeaderView else { fatalError() }
        header.label.text = dataSource.sections[section].title
        header.label.font = UIFont.systemFont(ofSize: 15, weight: .black)
        header.label.textColor = .textLight
        header.prepareHeader(for: section, delegate: self)
        header.setExpanded(dataSource.sections[section].isExpanded)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource.sections[indexPath.section].isExpanded ? UITableViewAutomaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            let controller = UIAlertController(title: "Report Issue", message: "Select the reason for reporting this issue", preferredStyle: .actionSheet)
            
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                tableView.deselectRow(at: indexPath, animated: true)
            }))
            
            controller.addAction(UIAlertAction(title: "Invalid Value", style: .destructive, handler: { [weak self] _ -> Void in
                self?.selectedAttributes.append("Invalid Value")
                self?.invalidateSendButton()
            }))
            
            controller.addAction(UIAlertAction(title: "Write a note", style: .default, handler: { [weak self] _ -> Void in
                self?.selectedAttributes.append("Note")
                self?.invalidateSendButton()
            }))
            
            present(controller, animated: true, completion: nil)
        } else {
            let property = dataSource.property(at: indexPath)
            let context = PeekContext()
            
            if let value = property.value(forModel: model) as? Peekable {
                value.preparePeek(context)
            }
            
            if let value = property.value(forModel: model) as? Model {
                let controller = InspectorViewController(peek: peek, model: value, context: context)
                navigationController?.pushViewController(controller, animated: true)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = selectedAttributes.index(of: "\(indexPath)") {
            selectedAttributes.remove(at: index)
        }
        
        invalidateSendButton()
    }
    
    private func invalidateSendButton() {
        navigationItem.rightBarButtonItem?.isEnabled = selectedAttributes.count > 0
    }
    
}

extension InspectorViewController: UITableViewDataSource {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sections.count
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.sections[section].items.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InspectorCell", for: indexPath) as? InspectorCell else { fatalError() }
        let property = dataSource.property(at: indexPath)
        
        cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        cell.detailTextLabel?.textColor = .textLight
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        cell.textLabel?.textColor = .neutral
        cell.textLabel?.text = property.displayName
        
        cell.accessoryView = nil
        cell.accessoryType = .none
        cell.editingAccessoryView = nil
        cell.editingAccessoryType = .none
        
        if let value = property.value(forModel: model) as? NSObjectProtocol {
            var text: String?
            var accessoryView: UIView?
            var editingAccessoryView: UIView?
            
            switch value {
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
            
            if tableView.isEditing || !property.isGroup {
                cell.accessoryType = .disclosureIndicator
            } else {
                cell.accessoryType = .none
            }

//            if let value = property.value(forModel: model) as? Model {
//                cell.accessoryType = tableView.isEditing ? .none : .disclosureIndicator
//            }
            
            cell.accessoryView = accessoryView
            cell.editingAccessoryView = accessoryView
            cell.detailTextLabel?.text = text
            
            property.configurationBlock?(cell, model, value)
        } else {
            cell.detailTextLabel?.text = "NIL"
        }
        
        return cell
    }
    
}
