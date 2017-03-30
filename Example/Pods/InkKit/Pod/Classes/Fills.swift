/*
  Copyright © 13/05/2016 Shaps

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

import CoreGraphics
import GraphicsRenderer

extension RendererDrawable {
  
 /**
   Fills the specified path
   
   - parameter path:            The path to fill
   - parameter startColor:      The start color for the gradient
   - parameter endColor:        The end color for the gradient
   - parameter angleInDegrees:  The angle (in degrees) of the gradient
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public func fill(path: BezierPath, startColor: Color, endColor: Color, angleInDegrees: CGFloat, attributes attributesBlock: AttributesBlock? = nil) {
    drawGradientPath(path, startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, stroke: false, attributes: attributesBlock)
  }
  
  /**
   Fills the specified path
   
   - parameter path:            The path to fill
   - parameter color:           The color for this fill
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public func fill(path: BezierPath, color: Color, attributes attributesBlock: AttributesBlock? = nil) {
    cgContext.draw(inRect: path.bounds, attributes: attributesBlock) { context, rect, attributes in
      context.setFillColor(color.cgColor)
      context.addPath(path.cgPath)
      context.fillPath()
    }
  }
  
  /**
   Fills the specified rect
   
   - parameter rect:            The rect to fill
   - parameter color:           The color for this fill
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public func fill(rect: CGRect, color: Color, attributes attributesBlock: AttributesBlock? = nil) {
    cgContext.draw(inRect: rect, attributes: attributesBlock) { context, rect, attributes in
      context.setFillColor(color.cgColor)
      context.fill(rect)
    }
  }
  
}
