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

final class InspectorCell: UITableViewCell {
  
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
    return action == "copy:" || action == "slack:" || action == "email:"
  }
  
  override func copy(sender: AnyObject?) {
    if let message = stringValue() {
      UIPasteboard.generalPasteboard().string = message
    }
  }
  
  func email(sender: AnyObject?) {
    if let message = stringValue(), peek = self.peek {
      Email.shared.post(message, peek: peek)
    }
  }
  
  func slack(sender: AnyObject?) {
    if let message = stringValue(), peek = self.peek {
      Slack.shared.post(message, peek: peek)
    }
  }
  
  private func stringValue() -> String? {
    guard let model = self.model, property = self.property else {
      return nil
    }
    
    if let value = detailTextLabel?.text {
      return "\(property.keyPath) = \(value)"
    }
    
    return "\(property.keyPath) = NIL"
  }
  
}
