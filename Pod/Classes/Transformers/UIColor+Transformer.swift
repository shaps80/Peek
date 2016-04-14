//
//  UIColor+Transformer.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

final class ColorTransformer: NSValueTransformer {
  
  override func transformedValue(value: AnyObject?) -> AnyObject? {
    if let value = value as? UIColor {
      return value.values().a == 0 ? "Clear" : value.hexValue(includeAlpha: false)
    }
    
    if CFGetTypeID(value) == CGColorGetTypeID() {
      let color = UIColor(CGColor: value as! CGColor)
      return color.values().a == 0 ? "Clear" : color.hexValue(includeAlpha: false)
    }
    
    return "NIL"
  }
  
  override class func allowsReverseTransformation() -> Bool {
    return false
  }
  
}
