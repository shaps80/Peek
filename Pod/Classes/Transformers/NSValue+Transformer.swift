//
//  NSValue+Transformer.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

final class ValueTransformer: NSValueTransformer {
  
  private static var floatFormatter: NSNumberFormatter {
    let formatter = NSNumberFormatter()
    formatter.maximumFractionDigits = 1
    formatter.minimumFractionDigits = 0
    formatter.minimumIntegerDigits = 1
    formatter.roundingIncrement = 0.5
    return formatter
  }
  
  override func transformedValue(value: AnyObject?) -> AnyObject? {
    if let value = value as? NSValue {
      let type = String.fromCString(value.objCType)!
      
      if type.hasPrefix("{CGRect") {
        let rect = value.CGRectValue()
        return
          "(\(ValueTransformer.floatFormatter.stringFromNumber(rect.minX)!), " +
          "\(ValueTransformer.floatFormatter.stringFromNumber(rect.minY)!)), " +
          "(\(ValueTransformer.floatFormatter.stringFromNumber(rect.width)!), " +
          "\(ValueTransformer.floatFormatter.stringFromNumber(rect.height)!))"
      }
      
      if type.hasPrefix("{CGPoint") {
        let point = value.CGPointValue()
        return "(\(ValueTransformer.floatFormatter.stringFromNumber(point.x)!), \(ValueTransformer.floatFormatter.stringFromNumber(point.y)!))"
      }
      
      if type.hasPrefix("{UIEdgeInset") {
        let insets = value.UIEdgeInsetsValue()
        return
          "(\(ValueTransformer.floatFormatter.stringFromNumber(insets.left)!), " +
          "\(ValueTransformer.floatFormatter.stringFromNumber(insets.top)!), " +
          "\(ValueTransformer.floatFormatter.stringFromNumber(insets.right)!), " +
          "\(ValueTransformer.floatFormatter.stringFromNumber(insets.bottom)!))"
      }
      
      if type.hasPrefix("{UIOffset") {
        let offset = value.UIOffsetValue()
        return "(\(ValueTransformer.floatFormatter.stringFromNumber(offset.horizontal)!), \(ValueTransformer.floatFormatter.stringFromNumber(offset.vertical)!))"
      }
      
      if type.hasPrefix("{CGSize") {
        let size = value.CGSizeValue()
        return "(\(ValueTransformer.floatFormatter.stringFromNumber(size.width)!), \(ValueTransformer.floatFormatter.stringFromNumber(size.height)!))"
      }
    }
    
    return nil
  }
  
  override class func allowsReverseTransformation() -> Bool {
    return false
  }
  
}