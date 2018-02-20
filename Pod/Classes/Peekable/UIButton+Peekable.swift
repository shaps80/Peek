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
        return title(for: UIControlState())
    }
    
    @objc var selectedTitle: String? {
        return title(for: .selected)
    }
    
    @objc var highlightedTitle: String? {
        return title(for: .highlighted)
    }
    
    @objc var disabledTitle: String? {
        return title(for: .disabled)
    }
    
    
    @objc var normalAttributedTitle: NSAttributedString? {
        return attributedTitle(for: UIControlState())
    }
    
    @objc var selectedAttributedTitle: NSAttributedString? {
        return attributedTitle(for: .selected)
    }
    
    @objc var highlightedAttributedTitle: NSAttributedString? {
        return attributedTitle(for: .highlighted)
    }
    
    @objc var disabledAttributedTitle: NSAttributedString? {
        return attributedTitle(for: .disabled)
    }
    
    
    @objc var normalTitleColor: UIColor? {
        return titleColor(for: UIControlState())
    }
    
    @objc var selectedTitleColor: UIColor? {
        return titleColor(for: .selected)
    }
    
    @objc var highlightedTitleColor: UIColor? {
        return titleColor(for: .highlighted)
    }
    
    @objc var disabledTitleColor: UIColor? {
        return titleColor(for: .disabled)
    }
    
    /**
     Configures Peek's properties for this object
     
     - parameter context: The context to apply these properties to
     */
    public override func preparePeek(_ context: Context) {
        super.preparePeek(context)
        
        context.configure(.attributes, "Components") { (config) in
            config.addProperties([ "imageView", "titleLabel" ])
        }
        
        context.configure(.attributes, "General") { (config) in
            config.addProperty("buttonType", displayName: nil, cellConfiguration: { (cell, object, value) in
                let type = UIButtonType(rawValue: value as! Int)!
                cell.detailTextLabel?.text = type.description
            })
        }
        
        context.configure(.layout, "Button") { (config) in
            config.addProperties([ "contentEdgeInsets", "titleEdgeInsets", "imageEdgeInsets" ])
        }
        
        context.configure(.attributes, "State") { (config) in
            config.addProperties([ "selected", "highlighted" ])
        }
        
        context.configure(.attributes, "Behaviour") { (config) in
            config.addProperties([ "showsTouchWhenHighlighted", "adjustsImageWhenDisabled", "adjustsImageWhenHighlighted" ])
        }
        
        context.configure(.attributes, "Title") { (config) in
            config.addProperty("normalTitle", displayName: "Normal", cellConfiguration: nil)
            config.addProperty("selectedTitle", displayName: "Selected", cellConfiguration: nil)
            config.addProperty("highlightedTitle", displayName: "Highlighted", cellConfiguration: nil)
            config.addProperty("disabledTitle", displayName: "Disabled", cellConfiguration: nil)
        }
        
        context.configure(.attributes, "Attributed Title") { (config) in
            config.addProperty("normalAttributedTitle", displayName: "Normal", cellConfiguration: nil)
            config.addProperty("selectedAttributedTitle", displayName: "Selected", cellConfiguration: nil)
            config.addProperty("highlightedAttributedTitle", displayName: "Highlighted", cellConfiguration: nil)
            config.addProperty("disabledAttributedTitle", displayName: "Disabled", cellConfiguration: nil)
        }
        
        context.configure(.attributes, "Title Colors") { (config) in
            config.addProperty("normalTitleColor", displayName: "Normal", cellConfiguration: nil)
            config.addProperty("selectedTitleColor", displayName: "Selected", cellConfiguration: nil)
            config.addProperty("highlightedTitleColor", displayName: "Highlighted", cellConfiguration: nil)
            config.addProperty("disabledTitleColor", displayName: "Disabled", cellConfiguration: nil)
        }
    }
    
}
