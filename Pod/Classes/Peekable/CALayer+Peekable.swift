//
//  CALayer+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension CALayer {
  
  @objc var peek_borderColor: UIColor? {
    if let color = borderColor {
      return UIColor(CGColor: color)
    }
    
    return nil
  }
  
  @objc var peek_shadowColor: UIColor? {
    if let color = shadowColor {
      return UIColor(CGColor: color)
    }
    
    return nil
  }
  
  @objc var peek_backgroundColor: UIColor? {
    if let color = backgroundColor {
      return UIColor(CGColor: color)
    }
    
    return nil
  }
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Layer, "Appearance") { (config) in
      config.addProperty("layer.peek_backgroundColor", displayName: "Background Color", cellConfiguration: nil)
      config.addProperties([ "layer.cornerRadius", "layer.masksToBounds", "layer.doubleSided" ])
    }
    
    context.configure(.Layer, "Visibility") { (config) in
      config.addProperties([ "layer.opacity", "layer.allowsGroupOpacity", "layer.hidden" ])
    }
    
    context.configure(.Layer, "Rasterization") { (config) in
      config.addProperties([ "layer.shouldRasterize", "layer.rasterizationScale", "opaque" ])
    }
    
    context.configure(.Layer, "Shadow") { (config) in
      config.addProperty("layer.peek_shadowColor", displayName: "Shadow Color", cellConfiguration: nil)
      config.addProperties([ "layer.shadowOffset", "layer.shadowOpacity", "layer.shadowRadius" ])
    }
    
    context.configure(.Layer, "Border") { (config) in
      config.addProperty("layer.peek_borderColor", displayName: "Border Color", cellConfiguration: nil)
      config.addProperties([ "layer.borderWidth" ])
    }
    
    context.configure(.Layer, "Contents") { (config) in
      config.addProperties([ "layer.contentsRect", "layer.contentsScale", "layer.contentsCenter" ])
      
      config.addProperty("layer.contentsGravity", displayName: nil, cellConfiguration: { (cell, object, value) in
        cell.detailTextLabel?.text = (value as? String)?.capitalizedString
      })
    }
  }
  
}

