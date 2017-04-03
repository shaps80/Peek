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
  
  // MARK: Internal functions
  
  internal func drawGradientPath(_ path: BezierPath, startColor: Color, endColor: Color, angleInDegrees: CGFloat, stroke: Bool, attributes attributesBlock: AttributesBlock? = nil) {
    cgContext.draw(inRect: path.bounds, attributes: attributesBlock, drawing: { (context, rect, attributes) in
      context.addPath(path.cgPath)
      
      if stroke {
        context.replacePathWithStrokedPath()
      }
      
      if !context.isPathEmpty {
        context.clip()
      }
      
      let rect = path.cgPath.boundingBox
      let locations: [CGFloat] = [0, 1]
      let colorSpace = CGColorSpaceCreateDeviceRGB()
      let colors = [startColor.cgColor, endColor.cgColor] as CFArray
      let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
      var (start, end) = rect.size.gradientPoints(forAngleInDegrees: angleInDegrees)
      
      start.x += rect.origin.x
      start.y += rect.origin.y
      end.x += rect.origin.x
      end.y += rect.origin.y
      
      context.drawLinearGradient(gradient!, start: start, end: end, options: [ .drawsAfterEndLocation, .drawsBeforeStartLocation ])
    })
  }
  
}
