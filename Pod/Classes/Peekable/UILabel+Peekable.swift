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

extension UILabel {
  
  /**
   Configures Peek's properties for this object
   
   - parameter context: The context to apply these properties to
   */
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Text") { (config) in
      config.addProperties([ "text" ])
      
      config.addProperty("textAlignment", displayName: "Alignment", cellConfiguration: { (cell, object, value) in
        let alignment = NSTextAlignment(rawValue: value as! Int)!
        cell.detailTextLabel?.text = alignment.description
      })
    }
    
    context.configure(.Attributes, "Color") { (config) in
      config.addProperties([ "textColor", "highlightedTextColor" ])
    }
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperty("lineBreakMode", displayName: nil, cellConfiguration: { (cell, object, value) in
        let mode = NSLineBreakMode(rawValue: value as! Int)!
        cell.detailTextLabel?.text = mode.description
      })
      
      config.addProperties([ "numberOfLines" ])
    }
    
    context.configure(.Attributes, "Font") { (config) in
      config.addProperties([ "font", "font.pointSize", "adjustsFontSizeToFitWidth", "minimumScaleFactor" ])
    }
    
    context.configure(.Attributes, "State") { (config) in
      config.addProperties([ "enabled", "highlighted" ])
    }
    
    context.configure(.Attributes, "Shadow") { (config) in
      config.addProperties([ "shadowColor", "shadowOffset" ])
    }
    
    context.configure(.Layout, "Label") { (config) in
      config.addProperties([ "preferredMaxLayoutWidth" ])
    }
  }
  
}