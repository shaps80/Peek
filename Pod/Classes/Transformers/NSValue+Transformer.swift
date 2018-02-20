/*
 Copyright © 23/04/2016 Shaps
 
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

/// Creates string representations of common values, e.g. CGPoint, CGRect, etc...
final class ValueTransformer: Foundation.ValueTransformer {
    
    fileprivate static var floatFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.minimumIntegerDigits = 1
        formatter.roundingIncrement = 0.5
        return formatter
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        if let value = value as? NSValue {
            let type = String(cString: value.objCType)
            
            if type.hasPrefix("{CGRect") {
                let rect = value.cgRectValue
                return
                    "(\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(rect.minX)))!), " +
                        "\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(rect.minY)))!)), " +
                        "(\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(rect.width)))!), " +
                "\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(rect.height)))!))"
            }
            
            if type.hasPrefix("{CGPoint") {
                let point = value.cgPointValue
                return "(\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(point.x)))!), \(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(point.y)))!))"
            }
            
            if type.hasPrefix("{UIEdgeInset") {
                let insets = value.uiEdgeInsetsValue
                return
                    "(\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(insets.left)))!), " +
                        "\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(insets.top)))!), " +
                        "\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(insets.right)))!), " +
                "\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(insets.bottom)))!))"
            }
            
            if type.hasPrefix("{UIOffset") {
                let offset = value.uiOffsetValue
                return "(\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(offset.horizontal)))!), \(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(offset.vertical)))!))"
            }
            
            if type.hasPrefix("{CGSize") {
                let size = value.cgSizeValue
                return "(\(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(size.width)))!), \(ValueTransformer.floatFormatter.string(from: NSNumber(value: Float(size.height)))!))"
            }
        }
        
        return nil
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
}
