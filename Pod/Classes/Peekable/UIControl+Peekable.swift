//
//  UIControl+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 28/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIControl {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.View, "State") { (config) in
      config.addProperties([ "enabled", "selected", "highlighted" ])
    }
    
    context.configure(.Layout, "Control") { (config) in
      config.addProperty("contentVerticalAlignment", displayName: "Vertical Alignment", cellConfiguration: { (cell, object, value) in
        let alignment = UIControlContentVerticalAlignment(rawValue: value as! Int)!
        cell.detailTextLabel?.text = alignment.description
      })
      
      config.addProperty("contentHorizontalAlignment", displayName: "Horizontal Alignment", cellConfiguration: { (cell, object, value) in
        let alignment = UIControlContentHorizontalAlignment(rawValue: value as! Int)!
        cell.detailTextLabel?.text = alignment.description
      })
    }
  }
  
}
