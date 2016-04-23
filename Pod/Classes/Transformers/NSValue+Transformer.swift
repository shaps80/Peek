/*
  Copyright © 23/04/2016 Snippex

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 */

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