//
//  ReportViewController.swift
//  Peek
//
//  Created by Shaps Mohsenin on 30/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit
import SwiftLayout

private enum ReportStatus {
  case Default
  case Sending
  case Success
}

final class SlackViewController: UITableViewController {
  
  private unowned let peek: Peek
  private var metaData: MetaData
  private weak var messageView: UITextView?
  private var indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .White)
  
  init(peek: Peek, metaData: MetaData) {
    self.peek = peek
    self.metaData = metaData
    
    super.init(style: .Grouped)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Slack Report"
    
    tableView.backgroundColor = UIColor(white: 0.1, alpha: 1)
    tableView.separatorColor = UIColor(white: 1, alpha: 0.15)
    tableView.keyboardDismissMode = .Interactive
    view.tintColor = UIColor.whiteColor()
    
    let navTitleAttributes = [ NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.5),
                               NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)! ]
    
    navigationController?.navigationBar.barStyle = .Black
    navigationController?.navigationBar.titleTextAttributes = navTitleAttributes
    navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    
    configureBarButtonItems()
  }
  
  private func configureBarButtonItems() {
    let itemAttributes = [ NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 16)! ]
    
    let leftItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancel))
    leftItem.setTitleTextAttributes(itemAttributes, forState: .Normal)
    
    let rightItem = UIBarButtonItem(title: "Send", style: .Plain, target: self, action: #selector(post))
    rightItem.setTitleTextAttributes(itemAttributes, forState: .Normal)
    
    navigationItem.leftBarButtonItem = leftItem
    navigationItem.rightBarButtonItem = rightItem
  }
  
  private func setStatus(status: ReportStatus) {
    switch status {
    case .Sending:
      tableView.userInteractionEnabled = false
      navigationItem.leftBarButtonItem = nil
      navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicatorView)
      indicatorView.startAnimating()
    case .Success:
      presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    default:
      tableView.userInteractionEnabled = true
      configureBarButtonItems()
    }
  }
  
  @objc private func post() {
    if let message = messageView?.text where !message.isEmpty {
      metaData.message = message
    } else {
      metaData.message = ""
    }
    
    setStatus(.Sending)
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
      Slack().post(self.metaData, peek: self.peek, controller: self) { [weak self] (success) in
        dispatch_async(dispatch_get_main_queue(), {
          self?.setStatus(success ? .Success : .Default)
        })
      }
    }
  }
  
  @objc private func cancel() {
    presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return metaData.metaData.items.count > 0 ? 3 : 2
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0: return metaData.property.items.count
    case 1: return metaData.metaData.items.count > 0 ? metaData.metaData.items.count : 1
    default: return 1
    }
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let section = metaDataForSection(section) {
      return section.title
    }
    
    return "Message"
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    guard let section = metaDataForSection(indexPath.section) else {
      let cell = EditableTextViewCell()
      messageView = cell.textView
      return cell
    }
    
    let item = section.items[indexPath.item]
    let cell = InspectorCell(style: .Value1, reuseIdentifier: "Cell")
    
    cell.selectionStyle = .None
    cell.textLabel?.text = item.key
    cell.detailTextLabel?.text = item.value
    
    return cell
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return indexPath.section == 1
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    switch indexPath.section {
    case 0: return PeekPropertyDefaultCellHeight
    case 1: return metaData.metaData.items.count > 0 ? PeekPropertyDefaultCellHeight : 150
    default: return 150
    }
  }
  
  private func metaDataForSection(section: Int) -> MetaDataSection? {
    switch section {
    case 0: return metaData.property
    case 1: return metaData.metaData.items.count > 0 ? metaData.metaData : nil
    default: return nil
    }
  }
  
}

final class EditableTextViewCell: UITableViewCell {
  
  private var textView: UITextView
  
  init() {
    textView = UITextView()
    
    super.init(style: .Default, reuseIdentifier: "TextViewCell")
    
    selectionStyle = .None
    backgroundColor = UIColor(white: 1, alpha: 0.03)
    contentView.addSubview(textView)
    
    textView.textColor = UIColor.whiteColor()
    textView.font = UIFont(name: "Avenir-Book", size: 15)
    textView.backgroundColor = UIColor.clearColor()
    textView.keyboardAppearance = .Dark
    
    textView.pin([ .All ], toView: contentView, margins: EdgeMargins(top: 0, left: 15, bottom: 0, right: -15))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
