/*
 Copyright © 23/04/2016 Shaps
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit
import InkKit

// FIXME: Generally speaking, this controller is too big -- Headers, Cell Configurations, etc.. could definitely be extracted
final class OldInspectorViewController: UITableViewController {
    
    fileprivate unowned let peek: Peek
    fileprivate let model: Model
    fileprivate let dataSource: ContextDataSource
    
    init(peek: Peek, model: Model, dataSource: ContextDataSource) {
        self.peek = peek
        self.model = model
        self.dataSource = dataSource
        
        super.init(style: .grouped)
        
        // we do this here to ensure the tabItems are populated immediately
//        title = "\(dataSource.inspectorType)"
        
//        tabBarItem.image = dataSource.inspectorType.image
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        tabBarItem.setTitleTextAttributes([ .font: UIFont(name: "Avenir-Medium", size: 12)! ], for: UIControlState())
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.title = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(InspectorCell.self, forCellReuseIdentifier: "KeyValueCell")
        tableView.indicatorStyle = .white
        tableView.backgroundColor = UIColor(white: 0.1, alpha: 1)
        tableView.separatorColor = UIColor(white: 1, alpha: 0.15)
        tableView.keyboardDismissMode = .interactive
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.estimatedSectionHeaderHeight = 44
        
        if dataSource.sections.count == 0 {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.numberOfLines = 0
            label.textColor = UIColor(white: 1, alpha: 0.5)
            label.text = "No Attributes"
            
            view.addSubview(label)
            label.align(axis: .vertical, to: view, offset: -64)
            label.align(axis: .horizontal, to: view)
        }
        
        if let image = model as? UIImage {
            let header = InspectorHeader(image: image, showBorder: true)
            tableView.contentInset.top = 10
            tableView.tableHeaderView = header
            header.align(axis: .horizontal, to: tableView)
        }
        
        if let value = model as? UIColor {
            let image = Image.circle(radius: 20, attributes: { (attributes) in
                attributes.fillColor = Color(color: value)
                attributes.strokeColor = Color(white: 1, alpha: 0.15)
                attributes.lineWidth = 1
            }).withRenderingMode(.alwaysOriginal)
            
            let imageView = InspectorHeader(image: image, showBorder: false)
            tableView.tableHeaderView = imageView
            
            imageView.pin(edge: .top, to: .top, of: tableView, margin: 20)
            imageView.align(axis: .horizontal, to: tableView)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.tableView.reloadData()
        }, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KeyValueCell", for: indexPath) as? InspectorCell else { fatalError() }
        configureCell(cell, forIndexPath: indexPath)
        cell.contentView.layoutIfNeeded()
        return cell
    }
    
    fileprivate func configureCell(_ cell: InspectorCell, forIndexPath indexPath: IndexPath) {
        let property = dataSource.property(at: indexPath)
        
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
            
            if let value = property.value(forModel: model) as? PeekSubPropertiesSupporting, value.hasProperties {
                cell.accessoryType = .disclosureIndicator
            }
            
            cell.accessoryView = accessoryView
            cell.detailTextLabel?.text = text
            property.configurationBlock?(cell, model, value)
        } else {
            cell.detailTextLabel?.text = "NIL"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = dataSource.property(at: indexPath).cellHeight

        if cellHeight != 0 {
            return cellHeight
        }

        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let property = dataSource.property(at: indexPath)
        
        guard let value = property.value(forModel: model) as? PeekSubPropertiesSupporting, value.hasProperties else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        let context = PeekContext()
        
        // FIXME: handling an array of elements isn't the best code, needs refactoring -- but currently an array of items is different to a single model
        if let array = value as? [AnyObject] {
            context.configure(.attributes, "") { (config) in
                for item in array {
                    config.addProperty(value: item, displayName: "\(item)", cellConfiguration: { (cell, _, value) in
                        cell.detailTextLabel?.text = nil
                        cell.textLabel?.textColor = UIColor.white
                        
                        if value is NSLayoutConstraint {
                            cell.textLabel?.font = UIFont(name: "Menlo", size: cell.textLabel?.font.pointSize ?? 15)
                        }
                    })
                }
            }
        } else {
            if let value = value as? Peekable {
                value.preparePeek(context)
            }
        }
        
        guard let model = value as? Model else { return } // FIXME: This could be handled better -- perhaps better structure in terms of protocol conformance
        let controller = OldInspectorViewController(peek: peek, model: model, dataSource: ContextDataSource(context: context, inspector: .attributes))
        controller.title = property.displayName
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return peek.supportedOrientations
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return peek.previousStatusBarStyle
    }
    
}
