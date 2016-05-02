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
import MessageUI

/// Defines an inspector's cell used to represent a Peek property
final class InspectorCell: UITableViewCell, MFMailComposeViewControllerDelegate {
  
  weak var peek: Peek?
  weak var property: Property?
  weak var model: Model?
  
  override var accessoryView: UIView? {
    didSet {
      setNeedsUpdateConstraints()
    }
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
    
    selectedBackgroundView = UIView()
    selectedBackgroundView?.backgroundColor = UIColor(white: 1, alpha: 0.07)
    
    backgroundColor = UIColor(white: 1, alpha: 0.03)
    textLabel?.textColor = UIColor(white: 1, alpha: 0.6)
    detailTextLabel?.textColor = UIColor.whiteColor()
    detailTextLabel?.font = UIFont(name: "Avenir-Book", size: 16)
    textLabel?.font = UIFont(name: "Avenir-Book", size: 14)
    
    textLabel?.minimumScaleFactor = 0.8
    textLabel?.adjustsFontSizeToFitWidth = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if var rect = textLabel?.frame {
      rect.origin.y = 9
      textLabel?.frame = rect
    }
    
    if let label = textLabel {
      var rect = label.frame
      rect.origin.y = 9
      textLabel?.frame = rect
    }
    
    if let label = detailTextLabel where accessoryView != nil {
      var rect = label.frame
      rect.origin.x -= 15
      detailTextLabel?.frame = rect
    }
  }
  
  override func setHighlighted(highlighted: Bool, animated: Bool) {
    let color = accessoryView?.backgroundColor
    super.setHighlighted(highlighted, animated: animated)
    accessoryView?.backgroundColor = color
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    let color = accessoryView?.backgroundColor
    super.setSelected(selected, animated: animated)
    accessoryView?.backgroundColor = color
  }
  
  override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
    return action == #selector(copy(_:)) ||
      action == #selector(slack(_:)) ||
      action == #selector(email(_:))
  }
  
  override func copy(sender: AnyObject?) {
    if let message = stringValue() {
      UIPasteboard.generalPasteboard().string = message
    }
  }
  
  func email(sender: AnyObject?) {
    guard let peek = self.peek else {
      fatalError("Peek should never be nil!")
    }
    
    Email().post(peek.screenshot, metaData: metaData(), peek: peek, delegate: self)
  }
  
  func slack(sender: AnyObject?) {    
    guard let peek = self.peek else {
      fatalError("Peek should never be nil!")
    }
    
    let controller = SlackViewController(peek: peek, metaData: metaData())
    let navController = UINavigationController(rootViewController: controller)
    navController.modalPresentationStyle = .FormSheet
    peek.window?.rootViewController?.topViewController().presentViewController(navController, animated: true, completion: nil)
  }
  
  private func metaData() -> MetaData {
    guard let model = model else {
      fatalError("Model should never be nil!")
    }
    
    var metaData = MetaData()
    
    let object = MetaDataItem(key: "Object", value: "\(model.ObjClassName())")
    let title = MetaDataItem(key: "Display Name", value: property?.displayName)
    let keyPath = MetaDataItem(key: "Key Path", value: property?.keyPath)
    let value = MetaDataItem(key: "Value", value: stringValue())
    
    metaData.property.items = [ object, title, keyPath, value ]
    
    if let meta = peek?.options.reportMetaData {
      for (key, value) in meta {
        let item = MetaDataItem(key: key, value: value)
        metaData.metaData.items.append(item)
      }
    }
    
    return metaData
  }
  
  private func stringValue() -> String? {
    guard let model = self.model, property = self.property else {
      return nil
    }
    
    if let value = detailTextLabel?.text {
      return "\(value)"
    }
    
    if let value = property.value(forModel: model) {
      return "\(value)"
    }

    return nil
  }
  
  // FIXME: This is obviouslt the wrong place for this
  
  func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    controller.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
  
}
