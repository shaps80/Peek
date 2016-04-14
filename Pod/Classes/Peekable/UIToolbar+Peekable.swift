//
//  UIToolbar+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 09/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIToolbar {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Appearance") { (config) in
      config.addProperties([ "translucent", "barTintColor" ])
      
      config.addProperty("barStyle", displayName: nil, cellConfiguration: { (cell, object, value) in
        let style = UIBarStyle(rawValue: value as! Int)!
        cell.detailTextLabel?.text = style.description
      })
    }
  }
  
}
