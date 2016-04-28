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

extension UIButton {
  
  @objc var normalTitle: String? {
    return titleForState(.Normal)
  }
  
  @objc var selectedTitle: String? {
    return titleForState(.Normal)
  }
  
  @objc var highlightedTitle: String? {
    return titleForState(.Normal)
  }
  
  @objc var disabledTitle: String? {
    return titleForState(.Normal)
  }
  
  
  @objc var normalTitleColor: UIColor? {
    return titleColorForState(.Normal)
  }
  
  @objc var selectedTitleColor: UIColor? {
    return titleColorForState(.Selected)
  }
  
  @objc var highlightedTitleColor: UIColor? {
    return titleColorForState(.Highlighted)
  }
  
  @objc var disabledTitleColor: UIColor? {
    return titleColorForState(.Disabled)
  }
  
  /**
   Configures Peek's properties for this object
   
   - parameter context: The context to apply these properties to
   */
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Components") { (config) in
      config.addProperties([ "imageView", "titleLabel" ])
    }
    
    context.configure(.Attributes, "General") { (config) in
      config.addProperty("buttonType", displayName: nil, cellConfiguration: { (cell, object, value) in
        let type = UIButtonType(rawValue: value as! Int)!
        cell.detailTextLabel?.text = type.description
      })
    }
    
    context.configure(.Layout, "Button") { (config) in
      config.addProperties([ "contentEdgeInsets", "titleEdgeInsets", "imageEdgeInsets" ])
    }
    
    context.configure(.Attributes, "State") { (config) in
      config.addProperties([ "selected", "highlighted" ])
    }
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "showsTouchWhenHighlighted", "adjustsImageWhenDisabled", "adjustsImageWhenHighlighted" ])
    }
    
    context.configure(.Attributes, "Title") { (config) in
      config.addProperty("normalTitle", displayName: "Normal", cellConfiguration: nil)
      config.addProperty("selectedTitle", displayName: "Selected", cellConfiguration: nil)
      config.addProperty("highlightedTitle", displayName: "Highlighted", cellConfiguration: nil)
      config.addProperty("disabledTitle", displayName: "Disabled", cellConfiguration: nil)
    }
    
    context.configure(.Attributes, "Title Colors") { (config) in
      config.addProperty("normalTitleColor", displayName: "Normal", cellConfiguration: nil)
      config.addProperty("selectedTitleColor", displayName: "Selected", cellConfiguration: nil)
      config.addProperty("highlightedTitleColor", displayName: "Highlighted", cellConfiguration: nil)
      config.addProperty("disabledTitleColor", displayName: "Disabled", cellConfiguration: nil)
    }
  }
  
}