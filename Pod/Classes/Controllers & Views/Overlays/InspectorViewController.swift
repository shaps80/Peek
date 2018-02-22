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
    
    internal let tableView: TableView
    private var navigationBarEffectsView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private var tabBarEffectsView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private let dataSource: ContextDataSource
    private let model: Model
    
    private var selectedAttributes: [String] = []
    
    internal init(model: Model, context: Context) {
        self.tableView = TableView(frame: .zero, style: .grouped)
        self.dataSource = ContextDataSource(context: context, inspector: .attributes)
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareTabBar()
        prepareNavigationBar()
        prepareNavigationItems(animated: false)
    }
    
    // MARK: Unused
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                self.navigationBarEffectsView.backgroundColor = .editingTint
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
                self.navigationBarEffectsView.backgroundColor = nil
                self.navigationController?.navigationBar.tintColor = .secondaryTint
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

// MARK: - Bars
extension InspectorViewController {
    
    private func prepareNavigationBar() {
        view.addSubview(navigationBarEffectsView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor), equal(\.topAnchor)
        ])
        
        topLayoutGuide.bottomAnchor.constraint(equalTo: navigationBarEffectsView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func prepareTabBar() {
        view.addSubview(tabBarEffectsView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor), equal(\.bottomAnchor)
        ])
        
        bottomLayoutGuide.topAnchor.constraint(equalTo: tabBarEffectsView.topAnchor, constant: 0).isActive = true
    }
    
    @objc private func dismissController() {
        dismiss(animated: true, completion: nil)
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
        
        tableView.backgroundColor = .inspectorBackground
        tableView.separatorColor = UIColor(white: 1, alpha: 0.1)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        tableView.register(InspectorCell.self, forCellReuseIdentifier: "InspectorCell")
        
        view.addSubview(tableView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor),
            equal(\.bottomAnchor), equal(\.topAnchor)
        ])
    }
    
}

extension InspectorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAttributes.append("\(indexPath)")
        invalidateSendButton()
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
        return dataSource.numberOfCategories()
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfProperties(inCategory: section)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InspectorCell", for: indexPath) as? InspectorCell else { fatalError() }
        let property = dataSource.propertyForIndexPath(indexPath)
        
        let selectedView = UIView()
        
        selectedView.backgroundColor = UIColor(white: 1, alpha: 0.1)
        cell.selectedBackgroundView = selectedView
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        cell.detailTextLabel?.textColor = .textLight
        cell.textLabel?.textColor = .neutral
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        
        cell.textLabel?.setContentHuggingPriority(.required, for: .vertical)
        cell.textLabel?.setContentCompressionResistancePriority(.required, for: .vertical)
        cell.detailTextLabel?.setContentHuggingPriority(.required, for: .vertical)
        cell.detailTextLabel?.setContentCompressionResistancePriority(.required, for: .vertical)
        
        cell.textLabel?.text = property.displayName
        cell.accessoryView = nil
        cell.accessoryType = .none
        
        if let value = property.value(forModel: model) as? NSObjectProtocol {
            var text: String?
            var accessoryView: UIView?
            
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
                    accessoryView = ColorAccessoryView(value: value)
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
                accessoryView = ColorAccessoryView(value: UIColor(cgColor: value as! CGColor))
            }
            
            if let value = property.value(forModel: model) as? PeekSubPropertiesSupporting, value.hasProperties {
                cell.accessoryType = .disclosureIndicator
            }
            
            cell.accessoryView = accessoryView
            cell.detailTextLabel?.text = text
            property.configurationBlock?(cell, model, value)
        } else {
            cell.detailTextLabel?.text = "NIL"
        }
        
        return cell
    }
    
}

public final class TableView: UITableView {
    
    public override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        beginUpdates()
        endUpdates()
    }
    
}
