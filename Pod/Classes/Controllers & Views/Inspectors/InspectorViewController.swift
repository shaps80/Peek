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
final class InspectorViewController: UITableViewController {

  private unowned let peek: Peek
  private let model: Model
  private let dataSource: ContextDataSource
  private var prototype = InspectorCell()
  
  init(peek: Peek, model: Model, dataSource: ContextDataSource) {
    self.peek = peek
    self.model = model
    self.dataSource = dataSource
    super.init(style: .Grouped)
    
    // we do this here to ensure the tabItems are populated immediately
    title = "\(dataSource.inspectorType)"
    
    tabBarItem.image = dataSource.inspectorType.image
    tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
    tabBarItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 12)! ], forState: .Normal)
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    navigationItem.backBarButtonItem?.title = ""
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.registerClass(InspectorCell.self, forCellReuseIdentifier: "KeyValueCell")
    tableView.indicatorStyle = .White
    tableView.backgroundColor = UIColor(white: 0.1, alpha: 1)
    tableView.separatorColor = UIColor(white: 1, alpha: 0.15)
    tableView.keyboardDismissMode = .Interactive
    
    if dataSource.numberOfCategories() == 0 {
      let label = UILabel()
      label.font = UIFont(name: "Avenir-Book", size: 16)
      label.textColor = UIColor(white: 1, alpha: 0.5)
      label.text = "No Attributes"
      
      view.addSubview(label)
      label.align(.Vertical, toView: view, offset: -64)
      label.alignHorizontally(view)
    }
    
    if let image = model as? UIImage {
      let header = InspectorHeader(image: image, showBorder: true)
      tableView.contentInset.top = 10
      tableView.tableHeaderView = header
      header.alignHorizontally(tableView)
    }
    
    if let value = model as? UIColor {
      let image = Image.circle(radius: 20, attributes: { (attributes) in
        attributes.fillColor = value
        attributes.strokeColor = UIColor(white: 1, alpha: 0.15)
        attributes.lineWidth = 1
      }).imageWithRenderingMode(.AlwaysOriginal)
      
      let imageView = InspectorHeader(image: image, showBorder: false)
      tableView.tableHeaderView = imageView
      
      imageView.pin(.Top, toEdge: .Top, toView: tableView, margin: 20)
      imageView.alignHorizontally(tableView)
    }
  }
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    coordinator.animateAlongsideTransition({ (context) in
      self.tableView.reloadData()
    }, completion: nil)
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("KeyValueCell", forIndexPath: indexPath) as! InspectorCell
    configureCell(cell, forIndexPath: indexPath)
    return cell
  }
  
  private func configureCell(cell: InspectorCell, forIndexPath indexPath: NSIndexPath) {
    let property = dataSource.propertyForIndexPath(indexPath)
    cell.textLabel?.text = property.displayName
    cell.accessoryView = nil
    cell.accessoryType = .None
    
    if let value = property.value(forModel: model) {
      var text: String?
      var accessoryView: UIView?
      
      switch value {
      case is [AnyObject]:
        if let value = value as? [AnyObject] {
          text = "\(value.count)"
        }
      case is UIFont:
        if let value = value as? UIFont {
          text = value.fontName
        }
      case is UIImageView, is UILabel, is UIBarButtonItem, is Segment, is UIImage:
        text = nil
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
      case is AnyClass: text = (value as? NSObject)?.ObjClassName()
      default: text = "\(value)"
      }
      
      if CFGetTypeID(value) == CGColorGetTypeID() {
        text = ColorTransformer().transformedValue(value) as? String
        accessoryView = ColorAccessoryView(value: UIColor(CGColor: value as! CGColor))
      }
      
      if let value = property.value(forModel: model) as? PeekSubPropertiesSupporting where value.hasProperties {
        cell.accessoryType = .DisclosureIndicator
      }
      
      cell.accessoryView = accessoryView
      cell.detailTextLabel?.text = text
      property.configurationBlock?(cell: cell, object: model, value: value)
    } else {
      cell.detailTextLabel?.text = "NIL"
    }
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return dataSource.numberOfCategories() ?? 0
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.numberOfProperties(inCategory: section) ?? 0
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return dataSource.titleForCategory(section)
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let cellHeight = dataSource.propertyForIndexPath(indexPath).cellHeight
    
    if cellHeight != 0 {
      return cellHeight
    }
    
    return PeekPropertyDefaultCellHeight
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let property = dataSource.propertyForIndexPath(indexPath)
    
    guard let value = property.value(forModel: model) as? PeekSubPropertiesSupporting where value.hasProperties else {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      return
    }
    
    let context = PeekContext()
    
    // FIXME: handling an array of elements isn't the best code, needs refactoring -- but currently an array of items is different to a single model
    if let array = value as? [AnyObject] {
      context.configure(.Attributes, "", configuration: { (config) in
        for item in array {
          config.addProperty(value: item, displayName: "\(item)", cellConfiguration: { (cell, object, value) in
            cell.detailTextLabel?.text = nil
            cell.textLabel?.textColor = UIColor.whiteColor()
            
            if value is NSLayoutConstraint {
              cell.textLabel?.font = UIFont(name: "Menlo", size: cell.textLabel?.font.pointSize ?? 15)
            }
          })
        }
      })
    } else {
      if let value = value as? Peekable {
        value.preparePeek(context)
      }
    }
    
    guard let model = value as? Model else { return } // FIXME: This could be handled better -- perhaps better structure in terms of protocol conformance
    let controller = InspectorViewController(peek: peek, model	: model, dataSource: ContextDataSource(context: context, inspector: .Attributes))
    controller.title = property.displayName
    navigationController?.pushViewController(controller, animated: true)
  }
  
  override func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    let property = dataSource.propertyForIndexPath(indexPath)
    
    if let value = property.value(forModel: model) as? Model where value is PeekSubPropertiesSupporting {
      return false
    }
    
    return property.value(forModel: model) != nil
  }
  
  override func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return action == #selector(NSObject.copy(_:))
  }
  
  override func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    let property = dataSource.propertyForIndexPath(indexPath)
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    
    if let value = property.value(forModel: model) {
      var string = "\(property.keyPath) = \(value)"
      
      if let text = cell?.detailTextLabel?.text where !text.isEmpty {
        string += " -- \(text)"
      }
      
      UIPasteboard.generalPasteboard().string = string
    }
  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return peek.supportedOrientations
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return peek.previousStatusBarHidden
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return peek.previousStatusBarStyle
  }
  
}