//
//  UIColor+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 10/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIColor {
  
  var peek_alpha: CGFloat {
    return rgbComponents.alpha
  }
  
  var peek_HEX: String {
    return hexValue(includeAlpha: false)
  }
  
  var peek_HSL: String {
    return "\(Int(hslComponents.hue * 360)), \(Int(hslComponents.saturation * 100)), \(Int(hslComponents.brightness * 100))"
  }
  
  var peek_RGB: String {
    return "\(Int(rgbComponents.red * 255)), \(Int(rgbComponents.green * 255)), \(Int(rgbComponents.blue * 255))"
  }
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Values") { (config) in
      config.addProperty("peek_alpha", displayName: "Alpha", cellConfiguration: nil)
      config.addProperty("peek_RGB", displayName: "RGB", cellConfiguration: nil)
      config.addProperty("peek_HSL", displayName: "HSL", cellConfiguration: nil)
      config.addProperty("peek_HEX", displayName: "HEX", cellConfiguration: nil)
    }
  }
  
}
