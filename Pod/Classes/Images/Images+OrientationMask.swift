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
import InkKit

extension Images {
  
  static func orientationMaskImage(mask: UIInterfaceOrientationMask) -> UIImage {
    return Image.draw(width: 60, height: 50, attributes: nil, drawing: { (context, rect, attributes) in
      drawOrientationMask(mask: mask, frame: rect)
    })
  }
  
  private static func drawOrientationMask(mask mask: UIInterfaceOrientationMask, frame: CGRect = CGRectMake(0, 0, 60, 50)) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    
    //// Color Declarations
    let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    white.set()
    
    //// landscapeLeft Drawing
    CGContextSaveGState(context!)
    CGContextTranslateCTM(context!, frame.minX + 3, frame.minY + 49)
    CGContextRotateCTM(context!, -90 * CGFloat(M_PI) / 180)
    
    let landscapeLeftPath = UIBezierPath()
    landscapeLeftPath.moveToPoint(CGPointMake(7.5, 2.5))
    landscapeLeftPath.addCurveToPoint(CGPointMake(6.13, 3.04), controlPoint1: CGPointMake(6.97, 2.5), controlPoint2: CGPointMake(6.49, 2.71))
    landscapeLeftPath.addCurveToPoint(CGPointMake(5.5, 4.5), controlPoint1: CGPointMake(5.74, 3.41), controlPoint2: CGPointMake(5.5, 3.92))
    landscapeLeftPath.addCurveToPoint(CGPointMake(7.5, 6.5), controlPoint1: CGPointMake(5.5, 5.6), controlPoint2: CGPointMake(6.4, 6.5))
    landscapeLeftPath.addCurveToPoint(CGPointMake(9.5, 4.5), controlPoint1: CGPointMake(8.6, 6.5), controlPoint2: CGPointMake(9.5, 5.6))
    landscapeLeftPath.addCurveToPoint(CGPointMake(7.5, 2.5), controlPoint1: CGPointMake(9.5, 3.4), controlPoint2: CGPointMake(8.6, 2.5))
    landscapeLeftPath.closePath()
    landscapeLeftPath.moveToPoint(CGPointMake(13.62, 0.12))
    landscapeLeftPath.addCurveToPoint(CGPointMake(14.85, 1.26), controlPoint1: CGPointMake(14.25, 0.34), controlPoint2: CGPointMake(14.66, 0.75))
    landscapeLeftPath.addCurveToPoint(CGPointMake(15, 3.06), controlPoint1: CGPointMake(15, 1.74), controlPoint2: CGPointMake(15, 2.18))
    landscapeLeftPath.addLineToPoint(CGPointMake(15, 21.94))
    landscapeLeftPath.addCurveToPoint(CGPointMake(14.87, 23.66), controlPoint1: CGPointMake(15, 22.82), controlPoint2: CGPointMake(15, 23.26))
    landscapeLeftPath.addCurveToPoint(CGPointMake(13.74, 24.85), controlPoint1: CGPointMake(14.66, 24.25), controlPoint2: CGPointMake(14.25, 24.66))
    landscapeLeftPath.addCurveToPoint(CGPointMake(11.94, 25), controlPoint1: CGPointMake(13.26, 25), controlPoint2: CGPointMake(12.82, 25))
    landscapeLeftPath.addLineToPoint(CGPointMake(3.06, 25))
    landscapeLeftPath.addCurveToPoint(CGPointMake(1.34, 24.87), controlPoint1: CGPointMake(2.18, 25), controlPoint2: CGPointMake(1.74, 25))
    landscapeLeftPath.addCurveToPoint(CGPointMake(0.15, 23.74), controlPoint1: CGPointMake(0.75, 24.66), controlPoint2: CGPointMake(0.34, 24.25))
    landscapeLeftPath.addCurveToPoint(CGPointMake(0, 21.94), controlPoint1: CGPointMake(0, 23.26), controlPoint2: CGPointMake(0, 22.82))
    landscapeLeftPath.addLineToPoint(CGPointMake(0, 3.06))
    landscapeLeftPath.addCurveToPoint(CGPointMake(0.13, 1.34), controlPoint1: CGPointMake(0, 2.18), controlPoint2: CGPointMake(0, 1.74))
    landscapeLeftPath.addCurveToPoint(CGPointMake(1.26, 0.15), controlPoint1: CGPointMake(0.34, 0.75), controlPoint2: CGPointMake(0.75, 0.34))
    landscapeLeftPath.addCurveToPoint(CGPointMake(3.04, 0), controlPoint1: CGPointMake(1.73, 0), controlPoint2: CGPointMake(2.17, 0))
    landscapeLeftPath.addLineToPoint(CGPointMake(11.94, 0))
    landscapeLeftPath.addCurveToPoint(CGPointMake(13.66, 0.13), controlPoint1: CGPointMake(12.82, 0), controlPoint2: CGPointMake(13.26, 0))
    landscapeLeftPath.addLineToPoint(CGPointMake(13.62, 0.12))
    landscapeLeftPath.closePath()
    landscapeLeftPath.lineWidth = 1
    
    if mask.contains(.LandscapeLeft) {
      landscapeLeftPath.fill()
    } else {
      landscapeLeftPath.stroke()
    }
    
    CGContextRestoreGState(context!)
    
    
    //// portrait Drawing
    let portraitPath = UIBezierPath()
    portraitPath.moveToPoint(CGPointMake(frame.minX + 15.5, frame.minY + 19))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 13.5, frame.minY + 21), controlPoint1: CGPointMake(frame.minX + 14.4, frame.minY + 19), controlPoint2: CGPointMake(frame.minX + 13.5, frame.minY + 19.9))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 15.5, frame.minY + 23), controlPoint1: CGPointMake(frame.minX + 13.5, frame.minY + 22.1), controlPoint2: CGPointMake(frame.minX + 14.4, frame.minY + 23))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 17.5, frame.minY + 21), controlPoint1: CGPointMake(frame.minX + 16.6, frame.minY + 23), controlPoint2: CGPointMake(frame.minX + 17.5, frame.minY + 22.1))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 15.68, frame.minY + 19.01), controlPoint1: CGPointMake(frame.minX + 17.5, frame.minY + 19.96), controlPoint2: CGPointMake(frame.minX + 16.7, frame.minY + 19.1))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 15.5, frame.minY + 19), controlPoint1: CGPointMake(frame.minX + 15.62, frame.minY + 19), controlPoint2: CGPointMake(frame.minX + 15.56, frame.minY + 19))
    portraitPath.closePath()
    portraitPath.moveToPoint(CGPointMake(frame.minX + 21.62, frame.minY + 0.62))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 22.85, frame.minY + 1.76), controlPoint1: CGPointMake(frame.minX + 22.25, frame.minY + 0.84), controlPoint2: CGPointMake(frame.minX + 22.66, frame.minY + 1.25))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 23, frame.minY + 3.56), controlPoint1: CGPointMake(frame.minX + 23, frame.minY + 2.24), controlPoint2: CGPointMake(frame.minX + 23, frame.minY + 2.68))
    portraitPath.addLineToPoint(CGPointMake(frame.minX + 23, frame.minY + 22.44))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 22.87, frame.minY + 24.16), controlPoint1: CGPointMake(frame.minX + 23, frame.minY + 23.32), controlPoint2: CGPointMake(frame.minX + 23, frame.minY + 23.76))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 21.74, frame.minY + 25.35), controlPoint1: CGPointMake(frame.minX + 22.66, frame.minY + 24.75), controlPoint2: CGPointMake(frame.minX + 22.25, frame.minY + 25.16))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 19.94, frame.minY + 25.5), controlPoint1: CGPointMake(frame.minX + 21.26, frame.minY + 25.5), controlPoint2: CGPointMake(frame.minX + 20.82, frame.minY + 25.5))
    portraitPath.addLineToPoint(CGPointMake(frame.minX + 11.06, frame.minY + 25.5))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 9.34, frame.minY + 25.37), controlPoint1: CGPointMake(frame.minX + 10.18, frame.minY + 25.5), controlPoint2: CGPointMake(frame.minX + 9.74, frame.minY + 25.5))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 8.15, frame.minY + 24.24), controlPoint1: CGPointMake(frame.minX + 8.75, frame.minY + 25.16), controlPoint2: CGPointMake(frame.minX + 8.34, frame.minY + 24.75))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 8, frame.minY + 22.44), controlPoint1: CGPointMake(frame.minX + 8, frame.minY + 23.76), controlPoint2: CGPointMake(frame.minX + 8, frame.minY + 23.32))
    portraitPath.addLineToPoint(CGPointMake(frame.minX + 8, frame.minY + 3.56))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 8.13, frame.minY + 1.84), controlPoint1: CGPointMake(frame.minX + 8, frame.minY + 2.68), controlPoint2: CGPointMake(frame.minX + 8, frame.minY + 2.24))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 9.26, frame.minY + 0.65), controlPoint1: CGPointMake(frame.minX + 8.34, frame.minY + 1.25), controlPoint2: CGPointMake(frame.minX + 8.75, frame.minY + 0.84))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 11.06, frame.minY + 0.5), controlPoint1: CGPointMake(frame.minX + 9.74, frame.minY + 0.5), controlPoint2: CGPointMake(frame.minX + 10.18, frame.minY + 0.5))
    portraitPath.addLineToPoint(CGPointMake(frame.minX + 19.94, frame.minY + 0.5))
    portraitPath.addCurveToPoint(CGPointMake(frame.minX + 21.66, frame.minY + 0.63), controlPoint1: CGPointMake(frame.minX + 20.82, frame.minY + 0.5), controlPoint2: CGPointMake(frame.minX + 21.26, frame.minY + 0.5))
    portraitPath.addLineToPoint(CGPointMake(frame.minX + 21.62, frame.minY + 0.62))
    portraitPath.closePath()
    portraitPath.lineWidth = 1
    
    if mask.contains(.Portrait) {
      portraitPath.fill()
    } else {
      portraitPath.stroke()
    }
    
    
    //// portraitUpsideDown Drawing
    let portraitUpsideDownPath = UIBezierPath()
    portraitUpsideDownPath.moveToPoint(CGPointMake(frame.minX + 46.5, frame.minY + 3))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 44.5, frame.minY + 5), controlPoint1: CGPointMake(frame.minX + 45.4, frame.minY + 3), controlPoint2: CGPointMake(frame.minX + 44.5, frame.minY + 3.9))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 46.5, frame.minY + 7), controlPoint1: CGPointMake(frame.minX + 44.5, frame.minY + 6.1), controlPoint2: CGPointMake(frame.minX + 45.4, frame.minY + 7))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 48.5, frame.minY + 5), controlPoint1: CGPointMake(frame.minX + 47.6, frame.minY + 7), controlPoint2: CGPointMake(frame.minX + 48.5, frame.minY + 6.1))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 46.5, frame.minY + 3), controlPoint1: CGPointMake(frame.minX + 48.5, frame.minY + 3.9), controlPoint2: CGPointMake(frame.minX + 47.6, frame.minY + 3))
    portraitUpsideDownPath.closePath()
    portraitUpsideDownPath.moveToPoint(CGPointMake(frame.minX + 52.62, frame.minY + 0.62))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 53.85, frame.minY + 1.76), controlPoint1: CGPointMake(frame.minX + 53.25, frame.minY + 0.84), controlPoint2: CGPointMake(frame.minX + 53.66, frame.minY + 1.25))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 54, frame.minY + 3.56), controlPoint1: CGPointMake(frame.minX + 54, frame.minY + 2.24), controlPoint2: CGPointMake(frame.minX + 54, frame.minY + 2.68))
    portraitUpsideDownPath.addLineToPoint(CGPointMake(frame.minX + 54, frame.minY + 22.44))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 53.87, frame.minY + 24.16), controlPoint1: CGPointMake(frame.minX + 54, frame.minY + 23.32), controlPoint2: CGPointMake(frame.minX + 54, frame.minY + 23.76))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 52.74, frame.minY + 25.35), controlPoint1: CGPointMake(frame.minX + 53.66, frame.minY + 24.75), controlPoint2: CGPointMake(frame.minX + 53.25, frame.minY + 25.16))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 50.94, frame.minY + 25.5), controlPoint1: CGPointMake(frame.minX + 52.26, frame.minY + 25.5), controlPoint2: CGPointMake(frame.minX + 51.82, frame.minY + 25.5))
    portraitUpsideDownPath.addLineToPoint(CGPointMake(frame.minX + 42.06, frame.minY + 25.5))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 40.34, frame.minY + 25.37), controlPoint1: CGPointMake(frame.minX + 41.18, frame.minY + 25.5), controlPoint2: CGPointMake(frame.minX + 40.74, frame.minY + 25.5))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 39.15, frame.minY + 24.24), controlPoint1: CGPointMake(frame.minX + 39.75, frame.minY + 25.16), controlPoint2: CGPointMake(frame.minX + 39.34, frame.minY + 24.75))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 39.04, frame.minY + 23.72), controlPoint1: CGPointMake(frame.minX + 39.1, frame.minY + 24.07), controlPoint2: CGPointMake(frame.minX + 39.06, frame.minY + 23.9))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 39, frame.minY + 22.44), controlPoint1: CGPointMake(frame.minX + 39, frame.minY + 23.39), controlPoint2: CGPointMake(frame.minX + 39, frame.minY + 23.01))
    portraitUpsideDownPath.addLineToPoint(CGPointMake(frame.minX + 39, frame.minY + 3.56))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 39.13, frame.minY + 1.84), controlPoint1: CGPointMake(frame.minX + 39, frame.minY + 2.68), controlPoint2: CGPointMake(frame.minX + 39, frame.minY + 2.24))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 40.26, frame.minY + 0.65), controlPoint1: CGPointMake(frame.minX + 39.34, frame.minY + 1.25), controlPoint2: CGPointMake(frame.minX + 39.75, frame.minY + 0.84))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 42.06, frame.minY + 0.5), controlPoint1: CGPointMake(frame.minX + 40.74, frame.minY + 0.5), controlPoint2: CGPointMake(frame.minX + 41.18, frame.minY + 0.5))
    portraitUpsideDownPath.addLineToPoint(CGPointMake(frame.minX + 50.94, frame.minY + 0.5))
    portraitUpsideDownPath.addCurveToPoint(CGPointMake(frame.minX + 52.66, frame.minY + 0.63), controlPoint1: CGPointMake(frame.minX + 51.82, frame.minY + 0.5), controlPoint2: CGPointMake(frame.minX + 52.26, frame.minY + 0.5))
    portraitUpsideDownPath.addLineToPoint(CGPointMake(frame.minX + 52.62, frame.minY + 0.62))
    portraitUpsideDownPath.closePath()
    portraitUpsideDownPath.lineWidth = 1
    
    if mask.contains(.PortraitUpsideDown) {
      portraitUpsideDownPath.fill()
    } else {
      portraitUpsideDownPath.stroke()
    }
    
    
    //// landscapeRight Drawing
    let landscapeRightPath = UIBezierPath()
    landscapeRightPath.moveToPoint(CGPointMake(frame.minX + 54.5, frame.minY + 39.5))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 52.5, frame.minY + 41.5), controlPoint1: CGPointMake(frame.minX + 53.4, frame.minY + 39.5), controlPoint2: CGPointMake(frame.minX + 52.5, frame.minY + 40.4))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 52.6, frame.minY + 42.13), controlPoint1: CGPointMake(frame.minX + 52.5, frame.minY + 41.72), controlPoint2: CGPointMake(frame.minX + 52.54, frame.minY + 41.94))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 54.5, frame.minY + 43.5), controlPoint1: CGPointMake(frame.minX + 52.87, frame.minY + 42.93), controlPoint2: CGPointMake(frame.minX + 53.62, frame.minY + 43.5))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 56.5, frame.minY + 41.5), controlPoint1: CGPointMake(frame.minX + 55.6, frame.minY + 43.5), controlPoint2: CGPointMake(frame.minX + 56.5, frame.minY + 42.6))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 54.5, frame.minY + 39.5), controlPoint1: CGPointMake(frame.minX + 56.5, frame.minY + 40.4), controlPoint2: CGPointMake(frame.minX + 55.6, frame.minY + 39.5))
    landscapeRightPath.closePath()
    landscapeRightPath.moveToPoint(CGPointMake(frame.minX + 55.94, frame.minY + 34))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 57.66, frame.minY + 34.13), controlPoint1: CGPointMake(frame.minX + 56.82, frame.minY + 34), controlPoint2: CGPointMake(frame.minX + 57.26, frame.minY + 34))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 58.85, frame.minY + 35.26), controlPoint1: CGPointMake(frame.minX + 58.25, frame.minY + 34.34), controlPoint2: CGPointMake(frame.minX + 58.66, frame.minY + 34.75))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 59, frame.minY + 37.06), controlPoint1: CGPointMake(frame.minX + 59, frame.minY + 35.74), controlPoint2: CGPointMake(frame.minX + 59, frame.minY + 36.18))
    landscapeRightPath.addLineToPoint(CGPointMake(frame.minX + 59, frame.minY + 45.94))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 58.87, frame.minY + 47.66), controlPoint1: CGPointMake(frame.minX + 59, frame.minY + 46.82), controlPoint2: CGPointMake(frame.minX + 59, frame.minY + 47.26))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 57.74, frame.minY + 48.85), controlPoint1: CGPointMake(frame.minX + 58.66, frame.minY + 48.25), controlPoint2: CGPointMake(frame.minX + 58.25, frame.minY + 48.66))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 55.94, frame.minY + 49), controlPoint1: CGPointMake(frame.minX + 57.26, frame.minY + 49), controlPoint2: CGPointMake(frame.minX + 56.82, frame.minY + 49))
    landscapeRightPath.addLineToPoint(CGPointMake(frame.minX + 37.06, frame.minY + 49))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 35.34, frame.minY + 48.87), controlPoint1: CGPointMake(frame.minX + 36.18, frame.minY + 49), controlPoint2: CGPointMake(frame.minX + 35.74, frame.minY + 49))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 34.15, frame.minY + 47.74), controlPoint1: CGPointMake(frame.minX + 34.75, frame.minY + 48.66), controlPoint2: CGPointMake(frame.minX + 34.34, frame.minY + 48.25))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 34, frame.minY + 45.94), controlPoint1: CGPointMake(frame.minX + 34, frame.minY + 47.26), controlPoint2: CGPointMake(frame.minX + 34, frame.minY + 46.82))
    landscapeRightPath.addLineToPoint(CGPointMake(frame.minX + 34, frame.minY + 37.06))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 34.13, frame.minY + 35.34), controlPoint1: CGPointMake(frame.minX + 34, frame.minY + 36.18), controlPoint2: CGPointMake(frame.minX + 34, frame.minY + 35.74))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 35.26, frame.minY + 34.15), controlPoint1: CGPointMake(frame.minX + 34.34, frame.minY + 34.75), controlPoint2: CGPointMake(frame.minX + 34.75, frame.minY + 34.34))
    landscapeRightPath.addCurveToPoint(CGPointMake(frame.minX + 37.06, frame.minY + 34), controlPoint1: CGPointMake(frame.minX + 35.74, frame.minY + 34), controlPoint2: CGPointMake(frame.minX + 36.18, frame.minY + 34))
    landscapeRightPath.addLineToPoint(CGPointMake(frame.minX + 55.94, frame.minY + 34))
    landscapeRightPath.addLineToPoint(CGPointMake(frame.minX + 55.94, frame.minY + 34))
    landscapeRightPath.closePath()
    landscapeRightPath.lineWidth = 1
    
    if mask.contains(.LandscapeRight) {
      landscapeRightPath.fill()
    } else {
      landscapeRightPath.stroke()
    }
  }
  
}