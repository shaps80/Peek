//
//  UIView+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIView {
  
  @objc var horizontalConstraints: [NSLayoutConstraint] {
    return constraintsAffectingLayoutForAxis(.Horizontal)
  }
  
  @objc var verticalConstraints: [NSLayoutConstraint] {
    return constraintsAffectingLayoutForAxis(.Vertical)
  }
  
  @objc var horizontalContentHuggingPriority: UILayoutPriority {
    return contentHuggingPriorityForAxis(.Horizontal)
  }
  
  @objc var verticalContentHuggingPriority: UILayoutPriority {
    return contentHuggingPriorityForAxis(.Vertical)
  }
  
  @objc var horizontalContentCompressionResistance: UILayoutPriority {
    return contentCompressionResistancePriorityForAxis(.Horizontal)
  }
  
  @objc var verticalContentCompressionResistance: UILayoutPriority {
    return contentCompressionResistancePriorityForAxis(.Vertical)
  }
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Layout, "General") { config in
      config.addProperties([ "frame", "bounds", "center", "intrinsicContentSize", "alignmentRectInsets" ])
      config.addProperty("translatesAutoresizingMaskIntoConstraints", displayName: "Autoresizing to Constraints", cellConfiguration: nil)
    }
    
    context.configure(.Layout, "Content Hugging Priority") { (config) in
      config.addProperty("horizontalContentHuggingPriority", displayName: "Horizontal", cellConfiguration: nil)
      config.addProperty("verticalContentHuggingPriority", displayName: "Vertical", cellConfiguration: nil)
    }
    
    context.configure(.Layout, "Content Compression Resistance") { (config) in
      config.addProperty("horizontalContentCompressionResistance", displayName: "Horizontal", cellConfiguration: nil)
      config.addProperty("verticalContentCompressionResistance", displayName: "Vertical", cellConfiguration: nil)
    }
    
    context.configure(.Layout, "Constraints") { (config) in
      config.addProperty("horizontalConstraints", displayName: "Horizontal", cellConfiguration: nil)
      config.addProperty("verticalConstraints", displayName: "Vertical", cellConfiguration: nil)
    }
    
    context.configure(.View, "Appearance") { (config) in
      config.addProperty("contentMode", displayName: nil, cellConfiguration: { (cell, view, value) in
        if let mode = UIViewContentMode(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
    }
    
    context.configure(.View, "Interaction") { config in
      config.addProperties([ "userInteractionEnabled", "multipleTouchEnabled", "exclusiveTouch" ])
    }
    
    context.configure(.View, "Color") { config in
      config.addProperties([ "alpha", "backgroundColor", "tintColor" ])
      
      config.addProperty("tintAdjustmentMode", displayName: nil, cellConfiguration: { (cell, view, value) in
        if let mode = UIViewTintAdjustmentMode(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
    }
    
    context.configure(.View, "Drawing") { config in
      config.addProperties([ "opaque", "hidden", "clipsToBounds" ])
    }
    
    context.configure(.View, "General") { config in
      config.addProperties([ "tag", "class", "superclass" ])
    }
    
    context.configure(.Layout, "Layer") { (config) in
      config.addProperties([ "layer.position", "layer.anchorPoint", "layer.zPosition", "layer.geometryFlipped", "layer.anchorPointZ",  ])
    }
  }
  
}
