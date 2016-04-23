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

extension UIColor {
  
  public func colorWithDelta(delta: CGFloat = 0.1) -> UIColor {
    let d = max(min(delta, 1), -1)
    let (r, g, b, a) = rgbComponents
    return UIColor(red: r + d, green: g + d, blue: b + d, alpha: a)
  }
  
  public class func neutralColor() -> UIColor {
    return UIColor(white: 0.6, alpha: 1)
  }
  
  public class func primaryColor() -> UIColor {
    return UIColor.colorWithRed(red: 135, green: 252, blue: 112, alpha: 1)
  }
  
  public class func secondaryColor() -> UIColor {
    return UIColor.colorWithRed(red: 255, green: 41, blue: 105, alpha: 1)
  }
  
  public func values() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return (r, g, b, a)
  }
  
  public func hexValue(includeAlpha alpha: Bool) -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    
    if (alpha) {
      return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
    } else {
      return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
  }
  
  private class func colorWithRed(red red: UInt, green: UInt, blue: UInt, alpha: CGFloat) -> UIColor {
    return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
  }
  
  var hslComponents:(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
    var h: CGFloat = 0, s: CGFloat = 0, l: CGFloat = 0, a: CGFloat = 0
    getHue(&h, saturation: &s, brightness: &l, alpha: &a)
    return (h, s, l, a)
  }
  
  var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return (r, g, b, a)
  }
  
}