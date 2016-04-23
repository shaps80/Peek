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

import Foundation
import InkKit

extension Images {
  
  static func orientationImage(orientation: UIInterfaceOrientation) -> UIImage {
    return Image.draw(width: 25, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      drawOrientation(frame: rect, portraitVisible: orientation == .Portrait, portraitUpsideDownVisible: orientation == .PortraitUpsideDown, lanscapeLeftVisible: orientation == .LandscapeLeft, landscapeRightVisible: orientation == .LandscapeRight)
    })
  }
  
  static func drawOrientation(frame frame: CGRect = CGRectMake(0, 0, 25, 25), portraitVisible: Bool = true, portraitUpsideDownVisible: Bool = false, lanscapeLeftVisible: Bool = false, landscapeRightVisible: Bool = false) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    
    //// Color Declarations
    let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    
    if (portraitVisible) {
      //// portrait Drawing
      let portraitPath = UIBezierPath()
      portraitPath.moveToPoint(CGPointMake(frame.minX + 12.5, frame.minY + 18.5))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 10.5, frame.minY + 20.5), controlPoint1: CGPointMake(frame.minX + 11.4, frame.minY + 18.5), controlPoint2: CGPointMake(frame.minX + 10.5, frame.minY + 19.4))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 12.5, frame.minY + 22.5), controlPoint1: CGPointMake(frame.minX + 10.5, frame.minY + 21.6), controlPoint2: CGPointMake(frame.minX + 11.4, frame.minY + 22.5))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 14.5, frame.minY + 20.5), controlPoint1: CGPointMake(frame.minX + 13.6, frame.minY + 22.5), controlPoint2: CGPointMake(frame.minX + 14.5, frame.minY + 21.6))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 12.68, frame.minY + 18.51), controlPoint1: CGPointMake(frame.minX + 14.5, frame.minY + 19.46), controlPoint2: CGPointMake(frame.minX + 13.7, frame.minY + 18.6))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 12.5, frame.minY + 18.5), controlPoint1: CGPointMake(frame.minX + 12.62, frame.minY + 18.5), controlPoint2: CGPointMake(frame.minX + 12.56, frame.minY + 18.5))
      portraitPath.closePath()
      portraitPath.moveToPoint(CGPointMake(frame.minX + 18.62, frame.minY + 0.12))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 19.85, frame.minY + 1.26), controlPoint1: CGPointMake(frame.minX + 19.25, frame.minY + 0.34), controlPoint2: CGPointMake(frame.minX + 19.66, frame.minY + 0.75))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 20, frame.minY + 3.06), controlPoint1: CGPointMake(frame.minX + 20, frame.minY + 1.74), controlPoint2: CGPointMake(frame.minX + 20, frame.minY + 2.18))
      portraitPath.addLineToPoint(CGPointMake(frame.minX + 20, frame.minY + 21.94))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 19.87, frame.minY + 23.66), controlPoint1: CGPointMake(frame.minX + 20, frame.minY + 22.82), controlPoint2: CGPointMake(frame.minX + 20, frame.minY + 23.26))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 18.74, frame.minY + 24.85), controlPoint1: CGPointMake(frame.minX + 19.66, frame.minY + 24.25), controlPoint2: CGPointMake(frame.minX + 19.25, frame.minY + 24.66))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 16.94, frame.minY + 25), controlPoint1: CGPointMake(frame.minX + 18.26, frame.minY + 25), controlPoint2: CGPointMake(frame.minX + 17.82, frame.minY + 25))
      portraitPath.addLineToPoint(CGPointMake(frame.minX + 8.06, frame.minY + 25))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 6.34, frame.minY + 24.87), controlPoint1: CGPointMake(frame.minX + 7.18, frame.minY + 25), controlPoint2: CGPointMake(frame.minX + 6.74, frame.minY + 25))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 5.15, frame.minY + 23.74), controlPoint1: CGPointMake(frame.minX + 5.75, frame.minY + 24.66), controlPoint2: CGPointMake(frame.minX + 5.34, frame.minY + 24.25))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 5, frame.minY + 21.94), controlPoint1: CGPointMake(frame.minX + 5, frame.minY + 23.26), controlPoint2: CGPointMake(frame.minX + 5, frame.minY + 22.82))
      portraitPath.addLineToPoint(CGPointMake(frame.minX + 5, frame.minY + 3.06))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 5.13, frame.minY + 1.34), controlPoint1: CGPointMake(frame.minX + 5, frame.minY + 2.18), controlPoint2: CGPointMake(frame.minX + 5, frame.minY + 1.74))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 6.26, frame.minY + 0.15), controlPoint1: CGPointMake(frame.minX + 5.34, frame.minY + 0.75), controlPoint2: CGPointMake(frame.minX + 5.75, frame.minY + 0.34))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 8.06, frame.minY), controlPoint1: CGPointMake(frame.minX + 6.74, frame.minY), controlPoint2: CGPointMake(frame.minX + 7.18, frame.minY))
      portraitPath.addLineToPoint(CGPointMake(frame.minX + 16.94, frame.minY))
      portraitPath.addCurveToPoint(CGPointMake(frame.minX + 18.66, frame.minY + 0.13), controlPoint1: CGPointMake(frame.minX + 17.82, frame.minY), controlPoint2: CGPointMake(frame.minX + 18.26, frame.minY))
      portraitPath.addLineToPoint(CGPointMake(frame.minX + 18.62, frame.minY + 0.12))
      portraitPath.closePath()
      white.setFill()
      portraitPath.fill()
    }
    
    
    if (portraitUpsideDownVisible) {
      //// upsideDown Drawing
      let upsideDownPath = UIBezierPath()
      upsideDownPath.moveToPoint(CGPointMake(frame.minX + 12.5, frame.minY + 6.5))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 10.5, frame.minY + 4.5), controlPoint1: CGPointMake(frame.minX + 11.4, frame.minY + 6.5), controlPoint2: CGPointMake(frame.minX + 10.5, frame.minY + 5.6))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 12.5, frame.minY + 2.5), controlPoint1: CGPointMake(frame.minX + 10.5, frame.minY + 3.4), controlPoint2: CGPointMake(frame.minX + 11.4, frame.minY + 2.5))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 14.5, frame.minY + 4.5), controlPoint1: CGPointMake(frame.minX + 13.6, frame.minY + 2.5), controlPoint2: CGPointMake(frame.minX + 14.5, frame.minY + 3.4))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 12.68, frame.minY + 6.49), controlPoint1: CGPointMake(frame.minX + 14.5, frame.minY + 5.54), controlPoint2: CGPointMake(frame.minX + 13.7, frame.minY + 6.4))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 12.5, frame.minY + 6.5), controlPoint1: CGPointMake(frame.minX + 12.62, frame.minY + 6.5), controlPoint2: CGPointMake(frame.minX + 12.56, frame.minY + 6.5))
      upsideDownPath.closePath()
      upsideDownPath.moveToPoint(CGPointMake(frame.minX + 18.62, frame.minY + 24.88))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 19.85, frame.minY + 23.74), controlPoint1: CGPointMake(frame.minX + 19.25, frame.minY + 24.66), controlPoint2: CGPointMake(frame.minX + 19.66, frame.minY + 24.25))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 20, frame.minY + 21.94), controlPoint1: CGPointMake(frame.minX + 20, frame.minY + 23.26), controlPoint2: CGPointMake(frame.minX + 20, frame.minY + 22.82))
      upsideDownPath.addLineToPoint(CGPointMake(frame.minX + 20, frame.minY + 3.06))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 19.87, frame.minY + 1.34), controlPoint1: CGPointMake(frame.minX + 20, frame.minY + 2.18), controlPoint2: CGPointMake(frame.minX + 20, frame.minY + 1.74))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 18.74, frame.minY + 0.15), controlPoint1: CGPointMake(frame.minX + 19.66, frame.minY + 0.75), controlPoint2: CGPointMake(frame.minX + 19.25, frame.minY + 0.34))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 16.94, frame.minY), controlPoint1: CGPointMake(frame.minX + 18.26, frame.minY), controlPoint2: CGPointMake(frame.minX + 17.82, frame.minY))
      upsideDownPath.addLineToPoint(CGPointMake(frame.minX + 8.06, frame.minY))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 6.34, frame.minY + 0.13), controlPoint1: CGPointMake(frame.minX + 7.18, frame.minY), controlPoint2: CGPointMake(frame.minX + 6.74, frame.minY))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 5.15, frame.minY + 1.26), controlPoint1: CGPointMake(frame.minX + 5.75, frame.minY + 0.34), controlPoint2: CGPointMake(frame.minX + 5.34, frame.minY + 0.75))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 5, frame.minY + 3.06), controlPoint1: CGPointMake(frame.minX + 5, frame.minY + 1.74), controlPoint2: CGPointMake(frame.minX + 5, frame.minY + 2.18))
      upsideDownPath.addLineToPoint(CGPointMake(frame.minX + 5, frame.minY + 21.94))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 5.13, frame.minY + 23.66), controlPoint1: CGPointMake(frame.minX + 5, frame.minY + 22.82), controlPoint2: CGPointMake(frame.minX + 5, frame.minY + 23.26))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 6.26, frame.minY + 24.85), controlPoint1: CGPointMake(frame.minX + 5.34, frame.minY + 24.25), controlPoint2: CGPointMake(frame.minX + 5.75, frame.minY + 24.66))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 8.06, frame.minY + 25), controlPoint1: CGPointMake(frame.minX + 6.74, frame.minY + 25), controlPoint2: CGPointMake(frame.minX + 7.18, frame.minY + 25))
      upsideDownPath.addLineToPoint(CGPointMake(frame.minX + 16.94, frame.minY + 25))
      upsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 18.66, frame.minY + 24.87), controlPoint1: CGPointMake(frame.minX + 17.82, frame.minY + 25), controlPoint2: CGPointMake(frame.minX + 18.26, frame.minY + 25))
      upsideDownPath.addLineToPoint(CGPointMake(frame.minX + 18.62, frame.minY + 24.88))
      upsideDownPath.closePath()
      white.setFill()
      upsideDownPath.fill()
    }
    
    
    if (lanscapeLeftVisible) {
      //// left Drawing
      CGContextSaveGState(context)
      CGContextTranslateCTM(context, frame.minX + 25, frame.minY + 5)
      CGContextRotateCTM(context, 90 * CGFloat(M_PI) / 180)
      
      let leftPath = UIBezierPath()
      leftPath.moveToPoint(CGPointMake(7.5, 18.5))
      leftPath.addCurveToPoint(CGPointMake(5.5, 20.5), controlPoint1: CGPointMake(6.4, 18.5), controlPoint2: CGPointMake(5.5, 19.4))
      leftPath.addCurveToPoint(CGPointMake(7.5, 22.5), controlPoint1: CGPointMake(5.5, 21.6), controlPoint2: CGPointMake(6.4, 22.5))
      leftPath.addCurveToPoint(CGPointMake(9.5, 20.5), controlPoint1: CGPointMake(8.6, 22.5), controlPoint2: CGPointMake(9.5, 21.6))
      leftPath.addCurveToPoint(CGPointMake(7.68, 18.51), controlPoint1: CGPointMake(9.5, 19.46), controlPoint2: CGPointMake(8.7, 18.6))
      leftPath.addCurveToPoint(CGPointMake(7.5, 18.5), controlPoint1: CGPointMake(7.62, 18.5), controlPoint2: CGPointMake(7.56, 18.5))
      leftPath.closePath()
      leftPath.moveToPoint(CGPointMake(13.62, 0.12))
      leftPath.addCurveToPoint(CGPointMake(14.85, 1.26), controlPoint1: CGPointMake(14.25, 0.34), controlPoint2: CGPointMake(14.66, 0.75))
      leftPath.addCurveToPoint(CGPointMake(15, 3.06), controlPoint1: CGPointMake(15, 1.74), controlPoint2: CGPointMake(15, 2.18))
      leftPath.addLineToPoint(CGPointMake(15, 21.94))
      leftPath.addCurveToPoint(CGPointMake(14.87, 23.66), controlPoint1: CGPointMake(15, 22.82), controlPoint2: CGPointMake(15, 23.26))
      leftPath.addCurveToPoint(CGPointMake(13.74, 24.85), controlPoint1: CGPointMake(14.66, 24.25), controlPoint2: CGPointMake(14.25, 24.66))
      leftPath.addCurveToPoint(CGPointMake(11.94, 25), controlPoint1: CGPointMake(13.26, 25), controlPoint2: CGPointMake(12.82, 25))
      leftPath.addLineToPoint(CGPointMake(3.06, 25))
      leftPath.addCurveToPoint(CGPointMake(1.34, 24.87), controlPoint1: CGPointMake(2.18, 25), controlPoint2: CGPointMake(1.74, 25))
      leftPath.addCurveToPoint(CGPointMake(0.15, 23.74), controlPoint1: CGPointMake(0.75, 24.66), controlPoint2: CGPointMake(0.34, 24.25))
      leftPath.addCurveToPoint(CGPointMake(0, 21.94), controlPoint1: CGPointMake(0, 23.26), controlPoint2: CGPointMake(0, 22.82))
      leftPath.addLineToPoint(CGPointMake(0, 3.06))
      leftPath.addCurveToPoint(CGPointMake(0.13, 1.34), controlPoint1: CGPointMake(0, 2.18), controlPoint2: CGPointMake(0, 1.74))
      leftPath.addCurveToPoint(CGPointMake(1.26, 0.15), controlPoint1: CGPointMake(0.34, 0.75), controlPoint2: CGPointMake(0.75, 0.34))
      leftPath.addCurveToPoint(CGPointMake(3.06, 0), controlPoint1: CGPointMake(1.74, 0), controlPoint2: CGPointMake(2.18, 0))
      leftPath.addLineToPoint(CGPointMake(11.94, 0))
      leftPath.addCurveToPoint(CGPointMake(13.66, 0.13), controlPoint1: CGPointMake(12.82, 0), controlPoint2: CGPointMake(13.26, 0))
      leftPath.addLineToPoint(CGPointMake(13.62, 0.12))
      leftPath.closePath()
      white.setFill()
      leftPath.fill()
      
      CGContextRestoreGState(context)
    }
    
    
    if (landscapeRightVisible) {
      //// right Drawing
      CGContextSaveGState(context)
      CGContextTranslateCTM(context, frame.minX, frame.minY + 20)
      CGContextRotateCTM(context, -90 * CGFloat(M_PI) / 180)
      
      let rightPath = UIBezierPath()
      rightPath.moveToPoint(CGPointMake(7.5, 18.5))
      rightPath.addCurveToPoint(CGPointMake(5.5, 20.5), controlPoint1: CGPointMake(6.4, 18.5), controlPoint2: CGPointMake(5.5, 19.4))
      rightPath.addCurveToPoint(CGPointMake(7.5, 22.5), controlPoint1: CGPointMake(5.5, 21.6), controlPoint2: CGPointMake(6.4, 22.5))
      rightPath.addCurveToPoint(CGPointMake(9.5, 20.5), controlPoint1: CGPointMake(8.6, 22.5), controlPoint2: CGPointMake(9.5, 21.6))
      rightPath.addCurveToPoint(CGPointMake(7.68, 18.51), controlPoint1: CGPointMake(9.5, 19.46), controlPoint2: CGPointMake(8.7, 18.6))
      rightPath.addCurveToPoint(CGPointMake(7.5, 18.5), controlPoint1: CGPointMake(7.62, 18.5), controlPoint2: CGPointMake(7.56, 18.5))
      rightPath.closePath()
      rightPath.moveToPoint(CGPointMake(13.62, 0.12))
      rightPath.addCurveToPoint(CGPointMake(14.85, 1.26), controlPoint1: CGPointMake(14.25, 0.34), controlPoint2: CGPointMake(14.66, 0.75))
      rightPath.addCurveToPoint(CGPointMake(15, 3.06), controlPoint1: CGPointMake(15, 1.74), controlPoint2: CGPointMake(15, 2.18))
      rightPath.addLineToPoint(CGPointMake(15, 21.94))
      rightPath.addCurveToPoint(CGPointMake(14.87, 23.66), controlPoint1: CGPointMake(15, 22.82), controlPoint2: CGPointMake(15, 23.26))
      rightPath.addCurveToPoint(CGPointMake(13.74, 24.85), controlPoint1: CGPointMake(14.66, 24.25), controlPoint2: CGPointMake(14.25, 24.66))
      rightPath.addCurveToPoint(CGPointMake(11.94, 25), controlPoint1: CGPointMake(13.26, 25), controlPoint2: CGPointMake(12.82, 25))
      rightPath.addLineToPoint(CGPointMake(3.06, 25))
      rightPath.addCurveToPoint(CGPointMake(1.34, 24.87), controlPoint1: CGPointMake(2.18, 25), controlPoint2: CGPointMake(1.74, 25))
      rightPath.addCurveToPoint(CGPointMake(0.15, 23.74), controlPoint1: CGPointMake(0.75, 24.66), controlPoint2: CGPointMake(0.34, 24.25))
      rightPath.addCurveToPoint(CGPointMake(0, 21.94), controlPoint1: CGPointMake(0, 23.26), controlPoint2: CGPointMake(0, 22.82))
      rightPath.addLineToPoint(CGPointMake(0, 3.06))
      rightPath.addCurveToPoint(CGPointMake(0.13, 1.34), controlPoint1: CGPointMake(0, 2.18), controlPoint2: CGPointMake(0, 1.74))
      rightPath.addCurveToPoint(CGPointMake(1.26, 0.15), controlPoint1: CGPointMake(0.34, 0.75), controlPoint2: CGPointMake(0.75, 0.34))
      rightPath.addCurveToPoint(CGPointMake(3.06, 0), controlPoint1: CGPointMake(1.74, 0), controlPoint2: CGPointMake(2.18, 0))
      rightPath.addLineToPoint(CGPointMake(11.94, 0))
      rightPath.addCurveToPoint(CGPointMake(13.66, 0.13), controlPoint1: CGPointMake(12.82, 0), controlPoint2: CGPointMake(13.26, 0))
      rightPath.addLineToPoint(CGPointMake(13.62, 0.12))
      rightPath.closePath()
      white.setFill()
      rightPath.fill()
      
      CGContextRestoreGState(context)
    }
  }
  
}