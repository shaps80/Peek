//
//  UILabel+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UILabel {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Text") { (config) in
      config.addProperties([ "text", "font" ])
      
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
      
      config.addProperties([ "adjustsFontSizeToFitWidth", "numberOfLines", "minimumScaleFactor" ])
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

