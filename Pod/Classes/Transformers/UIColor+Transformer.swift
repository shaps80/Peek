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

/// Creates a HEX string representation of a UIColor
final class ColorTransformer: Foundation.ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        if let value = value as? UIColor, let color = Color(systemColor: value) {
            if color == .clear {
                return "Clear"
            }
            
            if color.cgColor.pattern != nil {
                return "Pattern"
            }
            
            return color.rgba.alpha == 0
                ? "Transparent"
                : value.peek_HEX
        }
        
        if CFGetTypeID(value as CFTypeRef) == CGColor.typeID {
            // swiftlint:disable force_cast
            let color = Color(cgColor: value as! CGColor)
            return color?.rgba.alpha == 0 ? "Clear" : color?.systemColor.peek_HEX
        }
        
        return "none"
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
}
