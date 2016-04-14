//
//  UITextView+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UITextView {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Text") { (config) in
      config.addProperties([ "text", "textColor", "font" ])
      
      config.addProperty("textAlignment", displayName: "Alignment", cellConfiguration: { (cell, object, value) in
        let alignment = NSTextAlignment(rawValue: value as! Int)!
        cell.detailTextLabel?.text = alignment.description
      })
    }
    
    context.configure(.Attributes, "State") { (config) in
      config.addProperties([ "enabled", "editing", "selectable" ])
    }
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "clearsOnInsertion", "allowsEditingTextAttributes" ])
    }
  }
  
}
