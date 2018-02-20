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

/// Returns a string representation of a number -- e.g. floats and doubles: 0.5, 2.58
final class NumberTransformer: Foundation.ValueTransformer {
    
    fileprivate static var floatFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 1
        formatter.minimumIntegerDigits = 1
        return formatter
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        if let value = value as? NSNumber, value.isBool() {
            return nil
        }
        
        if let value = value as? NSNumber, value.isFloat() {
            return NumberTransformer.floatFormatter.string(from: value)!
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
