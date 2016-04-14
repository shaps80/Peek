//
//  UIStepper+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 10/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIStepper {
  
  @objc var normalIncrementImage: UIImage? {
    return incrementImageForState(.Normal)
  }
  
  @objc var disabledIncrementImage: UIImage? {
    return incrementImageForState(.Disabled)
  }
  
  @objc var highlightedIncrementImage: UIImage? {
    return incrementImageForState(.Highlighted)
  }
  
  @objc var selectedIncrementImage: UIImage? {
    return incrementImageForState(.Selected)
  }
  
  @objc var normalDecrementImage: UIImage? {
    return decrementImageForState(.Normal)
  }
  
  @objc var disabledDecrementImage: UIImage? {
    return decrementImageForState(.Disabled)
  }
  
  @objc var highlightedDecrementImage: UIImage? {
    return decrementImageForState(.Highlighted)
  }
  
  @objc var selectedDecrementImage: UIImage? {
    return decrementImageForState(.Selected)
  }
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "continuous", "wraps" ])
      
      config.addProperty("autorepeat", displayName: "Auto Repeat", cellConfiguration: nil)
    }
    
    context.configure(.Attributes, "General") { (config) in
      config.addProperties([ "value", "minimumValue", "maximumValue", "stepValue" ])
    }
    
    context.configure(.Attributes, "Increment Images") { (config) in
      config.addProperty("normalIncrementImage", displayName: "Normal", cellConfiguration: nil)
      config.addProperty("disabledIncrementImage", displayName: "Disabled", cellConfiguration: nil)
      config.addProperty("highlightedIncrementImage", displayName: "Highlighted", cellConfiguration: nil)
      config.addProperty("selectedIncrementImage", displayName: "Selected", cellConfiguration: nil)
    }
    
    context.configure(.Attributes, "Decrement Images") { (config) in
      config.addProperty("normalDecrementImage", displayName: "Normal", cellConfiguration: nil)
      config.addProperty("disabledDecrementImage", displayName: "Disabled", cellConfiguration: nil)
      config.addProperty("highlightedDecrementImage", displayName: "Highlighted", cellConfiguration: nil)
      config.addProperty("selectedDecrementImage", displayName: "Selected", cellConfiguration: nil)
    }
  
  }
  
}