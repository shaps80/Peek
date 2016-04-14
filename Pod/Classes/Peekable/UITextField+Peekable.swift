//
//  UITextField+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

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

