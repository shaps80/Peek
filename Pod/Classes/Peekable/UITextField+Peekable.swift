/*
  Copyright © 23/04/2016 Snippex

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

extension UITextField {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Appearance") { (config) in
      config.addProperty("borderStyle", displayName: nil, cellConfiguration: { (cell, object, value) in
        let style = UITextBorderStyle(rawValue: value as! Int)!
        cell.detailTextLabel?.text = style.description
      })
    }
    
    context.configure(.Attributes, "Text") { (config) in
      config.addProperties([ "text", "textColor", "font" ])
      
      config.addProperty("textAlignment", displayName: "Alignment", cellConfiguration: { (cell, object, value) in
        let alignment = NSTextAlignment(rawValue: value as! Int)!
        cell.detailTextLabel?.text = alignment.description
      })
    }
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "adjustsFontSizeToFitWidth", "allowsEditingTextAttributes", "clearsOnBeginEditing", "clearsOnInsertion" ])
      
      config.addProperty("clearButtonMode", displayName: nil, cellConfiguration: { (cell, object, value) in
        let mode = UITextFieldViewMode(rawValue: value as! Int)!
        cell.detailTextLabel?.text = mode.description
      })
      
      config.addProperty("leftViewMode", displayName: nil, cellConfiguration: { (cell, object, value) in
        let mode = UITextFieldViewMode(rawValue: value as! Int)!
        cell.detailTextLabel?.text = mode.description
      })
      
      config.addProperty("rightViewMode", displayName: nil, cellConfiguration: { (cell, object, value) in
        let mode = UITextFieldViewMode(rawValue: value as! Int)!
        cell.detailTextLabel?.text = mode.description
      })
    }
    
    context.configure(.Attributes, "State") { (config) in
      config.addProperties([ "enabled", "editing" ])
    }
    
    context.configure(.Attributes, "Font") { (config) in
      config.addProperties([ "minimumFontSize" ])
    }
  }
  
}