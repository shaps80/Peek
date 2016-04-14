//
//  UIActivityIndicatorView+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 10/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "hidesWhenStopped" ])
    }
    
    context.configure(.Attributes, "State") { (config) in
      config.addProperties([ "isAnimating" ])
    }
    
    context.configure(.Attributes, "Appearance") { (config) in
      config.addProperties([ "color" ])
      
      config.addProperty("activityIndicatorViewStyle", displayName: "Display Style", cellConfiguration: { (cell, view, value) in
        if let mode = UIActivityIndicatorViewStyle(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
    }
  }
  
}
