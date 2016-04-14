//
//  NSLayoutConstraint+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 14/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
  
  public override var description: String {
    var name = "\(performSelector("asciiArtDescription"))".componentsSeparatedByString(": ").last
    
    if name == "nil" {
      name = super.description
    }
    
    return name ?? super.description
  }
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "active", "shouldBeArchived" ])
    }
    
    context.configure(.Attributes, "Items") { (config) in
      config.addProperties([ "firstItem", "secondItem" ])
    }
    
    context.configure(.Attributes, "Attributes") { (config) in
      config.addProperty("firstAttribute", displayName: "First", cellConfiguration: { (cell, object, value) in
        if let mode = NSLayoutAttribute(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
      
      config.addProperty("secondAttribute", displayName: "Second", cellConfiguration: { (cell, object, value) in
        if let mode = NSLayoutAttribute(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
    }
    
    context.configure(.Attributes, "Properties") { (config) in
      config.addProperty("relation", displayName: nil, cellConfiguration: { (cell, object, value) in
        if let mode = NSLayoutRelation(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
      
      config.addProperties([ "constant", "multiplier", "priority" ])
    }
  }
  
}

