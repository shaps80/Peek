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

public enum ShadowType {
  case Inner
  case Outer
}

extension Draw {
  
  /**
   Draws a shadow from the specified paths edge
   
   - parameter type:   The type of shadow to draw
   - parameter path:   The path to apply this shadow to
   - parameter color:  The color for this shadow -- opacity is controlled through the color's opacity
   - parameter radius: The blur radius of this shadow
   - parameter offset: The offest of this shadow
   */
  public static func addShadow(type: ShadowType, path: BezierPath, color: Color, radius: CGFloat, offset shadowOffset: CGSize) {
    var offset: CGSize
    
    #if os(OSX)
      offset = CGSize(width: shadowOffset.width, height: shadowOffset.height * -1)
    #else
      offset = shadowOffset
    #endif
    
    switch type {
    case .Inner:
      addInnerShadow(path, color: color, radius: radius, offset: offset)
    case .Outer:
      addOuterShadow(path, color: color, radius: radius, offset: offset)
    }
  }
  
  private static func addInnerShadow(path: BezierPath, color: Color, radius: CGFloat, offset: CGSize) {
    GraphicsContext()?.draw(inRect: path.bounds, attributes: nil) { (context, rect, attributes) in
      CGContextAddPath(context, path.CGPath)
      
      if !CGContextIsPathEmpty(context) {
        CGContextClip(context)
      }
      
      let opaqueShadowColor = CGColorCreateCopyWithAlpha(color.CGColor, 1.0)
      
      CGContextSetAlpha(context, CGColorGetAlpha(color.CGColor))
      CGContextBeginTransparencyLayer(context, nil)
      CGContextSetShadowWithColor(context, offset, radius, opaqueShadowColor)
      CGContextSetBlendMode(context, .SourceOut)
      CGContextSetFillColorWithColor(context, opaqueShadowColor!)
      CGContextAddPath(context, path.CGPath)
      CGContextFillPath(context)
      CGContextEndTransparencyLayer(context)
    }
  }
  
  private static func addOuterShadow(path: BezierPath, color: Color, radius: CGFloat, offset: CGSize) {
    GraphicsContext()?.draw(inRect: path.bounds, attributes: nil) { (context, rect, attributes) in
      CGContextBeginTransparencyLayer(context, nil)
      CGContextSetShadowWithColor(context, offset, radius, color.CGColor)
      CGContextAddPath(context, path.CGPath)
      CGContextFillPath(context)
      CGContextEndTransparencyLayer(context)
    }
  }

}