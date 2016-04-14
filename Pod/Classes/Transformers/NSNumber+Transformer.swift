//
//  Float+Transformer.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

final class NumberTransformer: NSValueTransformer {
  
  private static var floatFormatter: NSNumberFormatter {
    let formatter = NSNumberFormatter()
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 1
    formatter.minimumIntegerDigits = 1
    return formatter
  }
  
  override func transformedValue(value: AnyObject?) -> AnyObject? {
    if let value = value as? NSNumber where value.isBool() {
      return nil
    }
    
    if let value = value as? NSNumber where value.isFloat() {
      return NumberTransformer.floatFormatter.stringFromNumber(value)!
    }
    
    if let value = value as? NSNumber {
      return "\(value)"
    }
    
    return nil
  }
  
  override class func allowsReverseTransformation() -> Bool {
    return false
  }
  
}
