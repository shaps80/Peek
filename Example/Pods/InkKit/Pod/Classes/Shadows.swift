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

public enum ShadowType {
  case inner
  case outer
}

extension RendererDrawable {
  
  /**
   Draws a shadow from the specified paths edge
   
   - parameter type:   The type of shadow to draw
   - parameter path:   The path to apply this shadow to
   - parameter color:  The color for this shadow -- opacity is controlled through the color's opacity
   - parameter radius: The blur radius of this shadow
   - parameter offset: The offest of this shadow
   */
  public func draw(shadow type: ShadowType, path: BezierPath, color: Color, radius: CGFloat, offset shadowOffset: CGSize) {
    var offset: CGSize
    
    #if os(OSX)
      offset = CGSize(width: shadowOffset.width, height: shadowOffset.height * -1)
    #else
      offset = shadowOffset
    #endif
    
    switch type {
    case .inner:
      addInnerShadow(path, color: color, radius: radius, offset: offset)
    case .outer:
      addOuterShadow(path, color: color, radius: radius, offset: offset)
    }
  }
  
  private func addInnerShadow(_ path: BezierPath, color: Color, radius: CGFloat, offset: CGSize) {
    cgContext.draw(inRect: path.bounds, attributes: nil) { (context, rect, attributes) in
      context.addPath(path.cgPath)
      
      if !context.isPathEmpty {
        context.clip()
      }
      
      let opaqueShadowColor = color.cgColor.copy(alpha: 1)
      
      context.setAlpha(color.cgColor.alpha)
      context.beginTransparencyLayer(auxiliaryInfo: nil)
      context.setShadow(offset: offset, blur: radius, color: opaqueShadowColor)
      context.setBlendMode(.sourceOut)
      context.setFillColor(opaqueShadowColor!)
      context.addPath(path.cgPath)
      context.fillPath()
      context.endTransparencyLayer()
    }
  }
  
  private func addOuterShadow(_ path: BezierPath, color: Color, radius: CGFloat, offset: CGSize) {
    cgContext.draw(inRect: path.bounds, attributes: nil) { (context, rect, attributes) in
      context.beginTransparencyLayer(auxiliaryInfo: nil)
      context.setShadow(offset: offset, blur: radius, color: color.cgColor)
      context.addPath(path.cgPath)
      context.fillPath()
      context.endTransparencyLayer()
    }
  }

}
