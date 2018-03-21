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

extension UIColor {
    
    internal static var overlay: UIColor? {
        return .black
    }
    
    internal static var separator: UIColor? {
        return UIColor(white: 1, alpha: 0.1)
    }
    
    internal static var inspectorBlack: UIColor? {
        return .black
    }
    
    internal static var inspectorDark: UIColor? {
        return Color(hex: "1c1c1c")!.systemColor
    }
    
    internal static var textDark: UIColor? {
        return Color(hex: "1c1c1c")!.systemColor
    }
    
    internal static var textLight: UIColor? {
        return UIColor.white
    }
    
    internal static var editingTint: UIColor? {
        return Color(hex: "4CD863")!.systemColor
    }
    
    internal static var counter: UIColor? {
        return Color(hex: "3EB454")!.systemColor
    }
    
    internal static var neutral: UIColor? {
        return UIColor(white: 1, alpha: 0.6)
    }
    
    internal static var primaryTint: UIColor? {
        return Color(literalRed: 135, green: 252, blue: 112).systemColor
    }

    internal var hslComponents:(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, l: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &l, alpha: &a)
        return (h, s, l, a)
    }

    internal var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
    
}
