//
//  UISlider+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 28/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UISlider {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Images") { (config) in
      config.addProperties([ "currentThumbImage", "minimumValueImage", "maximumValueImage", "currentMinimumTrackImage", "currentMaximumTrackImage" ])
    }
    
    context.configure(.Attributes, "Value") { (config) in
      config.addProperties([ "minimumValue", "maximumValue" ])
      config.addProperty("value", displayName: "Current Value", cellConfiguration: nil)
    }
    
    context.configure(.Attributes, "Color") { (config) in
      config.addProperties([ "minimumTrackTintColor", "maximumTrackTintColor" ])
    }
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "continuous" ])
    }
  }
  
}
