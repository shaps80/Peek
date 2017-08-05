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
  case `default`
  case sending
  case success
}

final class SlackViewController: UITableViewController {
  
  fileprivate unowned let peek: Peek
  fileprivate var metaData: MetaData
  fileprivate weak var messageView: UITextView?
  fileprivate var indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)
  
  init(peek: Peek, metaData: MetaData) {
    self.peek = peek
    self.metaData = metaData
    
    super.init(style: .grouped)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Slack Report"
    
    tableView.backgroundColor = UIColor(white: 0.1, alpha: 1)
    tableView.separatorColor = UIColor(white: 1, alpha: 0.15)
    tableView.keyboardDismissMode = .interactive
    view.tintColor = UIColor.white
    
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.tintColor = UIColor.white
    navigationController?.navigationBar.titleTextAttributes = [
        .foregroundColor: UIColor(white: 1, alpha: 0.5),
        .font: UIFont(name: "Avenir-Book", size: 16)!
    ]
    
    configureBarButtonItems()
  }
  
  fileprivate func configureBarButtonItems() {
    let leftItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    leftItem.setTitleTextAttributes([ .font: UIFont(name: "Avenir-Medium", size: 16)! ], for: .normal)
    
    let rightItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(post))
    rightItem.setTitleTextAttributes([ .font: UIFont(name: "Avenir-Medium", size: 16)! ], for: .normal)
    
    navigationItem.leftBarButtonItem = leftItem
    navigationItem.rightBarButtonItem = rightItem
  }
  
  fileprivate func setStatus(_ status: ReportStatus) {
    switch status {
    case .sending:
      tableView.isUserInteractionEnabled = false
      navigationItem.leftBarButtonItem = nil
      navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicatorView)
      indicatorView.startAnimating()
    case .success:
      presentingViewController?.dismiss(animated: true, completion: nil)
    default:
      tableView.isUserInteractionEnabled = true
      configureBarButtonItems()
    }
  }
  
  @objc fileprivate func post() {
    if let message = messageView?.text, !message.isEmpty {
      metaData.message = message
    } else {
      metaData.message = ""
    }
    
    setStatus(.sending)
    
    DispatchQueue.global(qos: .background).async {
      Slack().post(self.metaData, peek: self.peek, controller: self) { [weak self] (success) in
        DispatchQueue.main.async(execute: {
          self?.setStatus(success ? .success : .default)
        })
      }
    }
  }
  
  @objc fileprivate func cancel() {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return metaData.metaData.items.count > 0 ? 3 : 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0: return metaData.property.items.count
    case 1: return metaData.metaData.items.count > 0 ? metaData.metaData.items.count : 1
    default: return 1
    }
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let section = metaDataForSection(section) {
      return section.title
    }
    
    return "Message"
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let section = metaDataForSection(indexPath.section) else {
      let cell = EditableTextViewCell()
      messageView = cell.textView
      return cell
    }
    
    let item = section.items[indexPath.item]
    let cell = InspectorCell(style: .value1, reuseIdentifier: "Cell")
    
    cell.selectionStyle = .none
    cell.textLabel?.text = item.key
    cell.detailTextLabel?.text = item.value
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return indexPath.section == 1
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0: return PeekPropertyDefaultCellHeight
    case 1: return metaData.metaData.items.count > 0 ? PeekPropertyDefaultCellHeight : 150
    default: return 150
    }
  }
  
  fileprivate func metaDataForSection(_ section: Int) -> MetaDataSection? {
    switch section {
    case 0: return metaData.property
    case 1: return metaData.metaData.items.count > 0 ? metaData.metaData : nil
    default: return nil
    }
  }
  
}

final class EditableTextViewCell: UITableViewCell {
  
  fileprivate var textView: UITextView
  
  init() {
    textView = UITextView()
    
    super.init(style: .default, reuseIdentifier: "TextViewCell")
    
    selectionStyle = .none
    backgroundColor = UIColor(white: 1, alpha: 0.03)
    contentView.addSubview(textView)
    
    textView.textColor = UIColor.white
    textView.font = UIFont(name: "Avenir-Book", size: 15)
    textView.backgroundColor = UIColor.clear
    textView.keyboardAppearance = .dark
    
    textView.pin(edges: [ .all ], of: contentView, margins: EdgeMargins(top: 0, left: 15, bottom: 0, right: -15))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
