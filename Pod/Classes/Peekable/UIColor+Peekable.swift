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
  
  /**
   Configures Peek's properties for this object
   
   - parameter context: The context to apply these properties to
   */
  public override func preparePeek(_ context: Context) {
    super.preparePeek(context)
    
    context.configure(.attributes, "Values") { (config) in
      config.addProperty("peek_alpha", displayName: "Alpha", cellConfiguration: nil)
      config.addProperty("peek_RGB", displayName: "RGB", cellConfiguration: nil)
      config.addProperty("peek_HSL", displayName: "HSL", cellConfiguration: nil)
      config.addProperty("peek_HEX", displayName: "HEX", cellConfiguration: nil)
    }
  }
  
}
