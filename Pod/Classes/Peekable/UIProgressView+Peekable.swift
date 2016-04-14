//
//  UIProgressView.swift
//  Peek
//
//  Created by Shaps Mohsenin on 10/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIProgressView {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Appearance") { (config) in
      config.addProperty("progressViewStyle", displayName: "View Style", cellConfiguration: { (cell, view, value) in
        if let mode = UIProgressViewStyle(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
    }
    
    context.configure(.Attributes, "Colors") { (config) in
      config.addProperties([ "progressTintColor", "trackTintColor" ])
    }
    
    context.configure(.Attributes, "Images") { (config) in
      config.addProperties([ "trackImage", "progressImage" ])
    }
    
    context.configure(.Attributes, "Value") { (config) in
      config.addProperties([ "progress" ])
    }
  }
  
}
