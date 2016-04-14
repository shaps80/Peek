//
//  UIButton+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIButton {
  
  @objc var normalTitle: String? {
    return titleForState(.Normal)
  }
  
  @objc var selectedTitle: String? {
    return titleForState(.Normal)
  }
  
  @objc var highlightedTitle: String? {
    return titleForState(.Normal)
  }
  
  @objc var disabledTitle: String? {
    return titleForState(.Normal)
  }
  
  
  @objc var normalTitleColor: UIColor? {
    return titleColorForState(.Normal)
  }
  
  @objc var selectedTitleColor: UIColor? {
    return titleColorForState(.Selected)
  }
  
  @objc var highlightedTitleColor: UIColor? {
    return titleColorForState(.Highlighted)
  }
  
  @objc var disabledTitleColor: UIColor? {
    return titleColorForState(.Disabled)
  }
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Components") { (config) in
      config.addProperties([ "imageView", "titleLabel" ])
    }
    
    context.configure(.Attributes, "General") { (config) in
      config.addProperty("buttonType", displayName: nil, cellConfiguration: { (cell, object, value) in
        let type = UIButtonType(rawValue: value as! Int)!
        cell.detailTextLabel?.text = type.description
      })
    }
    
    context.configure(.Layout, "Button") { (config) in
      config.addProperties([ "contentEdgeInsets", "titleEdgeInsets", "imageEdgeInsets" ])
    }
    
    context.configure(.Attributes, "State") { (config) in
      config.addProperties([ "selected", "highlighted" ])
    }
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "showsTouchWhenHighlighted", "adjustsImageWhenDisabled", "adjustsImageWhenHighlighted" ])
    }
    
    context.configure(.Attributes, "Title") { (config) in
      config.addProperty("normalTitle", displayName: "Normal", cellConfiguration: nil)
      config.addProperty("selectedTitle", displayName: "Selected", cellConfiguration: nil)
      config.addProperty("highlightedTitle", displayName: "Highlighted", cellConfiguration: nil)
      config.addProperty("disabledTitle", displayName: "Disabled", cellConfiguration: nil)
    }
    
    context.configure(.Attributes, "Title Colors") { (config) in
      config.addProperty("normalTitleColor", displayName: "Normal", cellConfiguration: nil)
      config.addProperty("selectedTitleColor", displayName: "Selected", cellConfiguration: nil)
      config.addProperty("highlightedTitleColor", displayName: "Highlighted", cellConfiguration: nil)
      config.addProperty("disabledTitleColor", displayName: "Disabled", cellConfiguration: nil)
    }
  }
  
}
