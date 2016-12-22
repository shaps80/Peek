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

extension Draw {
  
  /**
   Strokes the specified rect
   
   - parameter rect:            The rect to stroke
   - parameter color:           The color for this stroke
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public static func strokeRect(rect: CGRect, color: Color? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    GraphicsContext()?.draw(inRect: rect, attributes: attributesBlock) { (context, rect, attributes) in
      color?.setStroke()
      CGContextAddRect(context, rect)
      CGContextStrokeRect(context, rect)
    }
  }
  
  /**
   Strokes the specified rect with a gradient
   
   - parameter rect:            The rect to stroke
   - parameter startColor:      The start color for this gradient
   - parameter endColor:        The end color for this gradient
   - parameter angleInDegrees:  The angle for this gradient
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public static func strokeRect(rect: CGRect, startColor: Color, endColor: Color, angleInDegrees: CGFloat, attributes attributesBlock: AttributesBlock? = nil) {
    strokePath(BezierPath(rect: rect), startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, attributes: attributesBlock)
  }
  
  /**
   Strokes the specified path
   
   - parameter path:            The path to stroke
   - parameter color:           The color for this stroke
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public static func strokePath(path: BezierPath, color: Color, attributes attributesBlock: AttributesBlock? = nil) {
    GraphicsContext()?.draw(inRect: path.bounds, attributes: attributesBlock) { (context, rect, attributes) in
      CGContextAddPath(context, path.CGPath)
      CGContextStrokePath(context)
    }
  }
  
  /**
   Strokes a line from startPoint to endPoint with a gradient. Note: The following is valid -- endPoint.x < startPoint.x || endPoint.y < startPoint.y
   
   - parameter startPoint:      The startpoint for this line
   - parameter endPoint:        The endpoint for this line
   - parameter startColor:      The start color for the gradient
   - parameter endColor:        The end color for the gradient
   - parameter angleInDegrees:  The angle (in degrees) of the gradient for this line
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public static func strokeLine(startPoint: CGPoint, endPoint: CGPoint, startColor: Color, endColor: Color, angleInDegrees: CGFloat = 0, attributes attributesBlock: AttributesBlock? = nil) {
    let path = BezierPath()
    path.moveToPoint(startPoint)
    path.addLineToPoint(endPoint)
    drawGradientPath(path, startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, stroke: true, attributes: attributesBlock)
  }
  
  /**
   Strokes the specified path
   
   - parameter path:            The path to stroke
   - parameter startColor:      The start color for the gradient
   - parameter endColor:        The end color for the gradient
   - parameter angleInDegrees:  The angle (in degrees) of the gradient
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public static func strokePath(path: BezierPath, startColor: Color, endColor: Color, angleInDegrees: CGFloat, attributes attributesBlock: AttributesBlock? = nil) {
    drawGradientPath(path, startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, stroke: true, attributes: attributesBlock)
  }
  
  /**
   Strokes a line from startPoint to endPoint with a single color (optimized). Note: The following is valid -- endPoint.x < startPoint.x || endPoint.y < startPoint.y
   
   - parameter startPoint:      The start point for this line
   - parameter endPoint:        The end point for this line
   - parameter color:           The color for this line
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public static func strokeLine(startPoint: CGPoint, endPoint: CGPoint, color: Color? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    let rect = reversibleRect(fromPoint: startPoint, toPoint: endPoint)
    
    GraphicsContext()?.draw(inRect: rect, attributes: attributesBlock) { (context, rect, attributes) in
      color?.setStroke()
      CGContextStrokeLineSegments(context, [ startPoint, endPoint ], 2)
    }
  }
  
}