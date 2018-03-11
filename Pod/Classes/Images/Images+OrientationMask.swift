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
import GraphicsRenderer

extension Images {
    
    static func orientationMaskImage(_ mask: UIInterfaceOrientationMask) -> UIImage {
        return ImageRenderer(size: CGSize(width: 60, height: 50)).image { context in
            let frame = context.format.bounds
        
            //// General Declarations
            let context = UIGraphicsGetCurrentContext()
            
            //// Color Declarations
            let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
            white.set()
            
            //// landscapeLeft Drawing
            context!.saveGState()
            context!.translateBy(x: frame.minX + 3, y: frame.minY + 49)
            context!.rotate(by: -90 * CGFloat.pi / 180)
            
            let landscapeLeftPath = UIBezierPath()
            landscapeLeftPath.move(to: CGPoint(x: 7.5, y: 2.5))
            landscapeLeftPath.addCurve(to: CGPoint(x: 6.13, y: 3.04), controlPoint1: CGPoint(x: 6.97, y: 2.5), controlPoint2: CGPoint(x: 6.49, y: 2.71))
            landscapeLeftPath.addCurve(to: CGPoint(x: 5.5, y: 4.5), controlPoint1: CGPoint(x: 5.74, y: 3.41), controlPoint2: CGPoint(x: 5.5, y: 3.92))
            landscapeLeftPath.addCurve(to: CGPoint(x: 7.5, y: 6.5), controlPoint1: CGPoint(x: 5.5, y: 5.6), controlPoint2: CGPoint(x: 6.4, y: 6.5))
            landscapeLeftPath.addCurve(to: CGPoint(x: 9.5, y: 4.5), controlPoint1: CGPoint(x: 8.6, y: 6.5), controlPoint2: CGPoint(x: 9.5, y: 5.6))
            landscapeLeftPath.addCurve(to: CGPoint(x: 7.5, y: 2.5), controlPoint1: CGPoint(x: 9.5, y: 3.4), controlPoint2: CGPoint(x: 8.6, y: 2.5))
            landscapeLeftPath.close()
            landscapeLeftPath.move(to: CGPoint(x: 13.62, y: 0.12))
            landscapeLeftPath.addCurve(to: CGPoint(x: 14.85, y: 1.26), controlPoint1: CGPoint(x: 14.25, y: 0.34), controlPoint2: CGPoint(x: 14.66, y: 0.75))
            landscapeLeftPath.addCurve(to: CGPoint(x: 15, y: 3.06), controlPoint1: CGPoint(x: 15, y: 1.74), controlPoint2: CGPoint(x: 15, y: 2.18))
            landscapeLeftPath.addLine(to: CGPoint(x: 15, y: 21.94))
            landscapeLeftPath.addCurve(to: CGPoint(x: 14.87, y: 23.66), controlPoint1: CGPoint(x: 15, y: 22.82), controlPoint2: CGPoint(x: 15, y: 23.26))
            landscapeLeftPath.addCurve(to: CGPoint(x: 13.74, y: 24.85), controlPoint1: CGPoint(x: 14.66, y: 24.25), controlPoint2: CGPoint(x: 14.25, y: 24.66))
            landscapeLeftPath.addCurve(to: CGPoint(x: 11.94, y: 25), controlPoint1: CGPoint(x: 13.26, y: 25), controlPoint2: CGPoint(x: 12.82, y: 25))
            landscapeLeftPath.addLine(to: CGPoint(x: 3.06, y: 25))
            landscapeLeftPath.addCurve(to: CGPoint(x: 1.34, y: 24.87), controlPoint1: CGPoint(x: 2.18, y: 25), controlPoint2: CGPoint(x: 1.74, y: 25))
            landscapeLeftPath.addCurve(to: CGPoint(x: 0.15, y: 23.74), controlPoint1: CGPoint(x: 0.75, y: 24.66), controlPoint2: CGPoint(x: 0.34, y: 24.25))
            landscapeLeftPath.addCurve(to: CGPoint(x: 0, y: 21.94), controlPoint1: CGPoint(x: 0, y: 23.26), controlPoint2: CGPoint(x: 0, y: 22.82))
            landscapeLeftPath.addLine(to: CGPoint(x: 0, y: 3.06))
            landscapeLeftPath.addCurve(to: CGPoint(x: 0.13, y: 1.34), controlPoint1: CGPoint(x: 0, y: 2.18), controlPoint2: CGPoint(x: 0, y: 1.74))
            landscapeLeftPath.addCurve(to: CGPoint(x: 1.26, y: 0.15), controlPoint1: CGPoint(x: 0.34, y: 0.75), controlPoint2: CGPoint(x: 0.75, y: 0.34))
            landscapeLeftPath.addCurve(to: CGPoint(x: 3.04, y: 0), controlPoint1: CGPoint(x: 1.73, y: 0), controlPoint2: CGPoint(x: 2.17, y: 0))
            landscapeLeftPath.addLine(to: CGPoint(x: 11.94, y: 0))
            landscapeLeftPath.addCurve(to: CGPoint(x: 13.66, y: 0.13), controlPoint1: CGPoint(x: 12.82, y: 0), controlPoint2: CGPoint(x: 13.26, y: 0))
            landscapeLeftPath.addLine(to: CGPoint(x: 13.62, y: 0.12))
            landscapeLeftPath.close()
            landscapeLeftPath.lineWidth = 1
            
            if mask.contains(.landscapeLeft) {
                landscapeLeftPath.fill()
            } else {
                landscapeLeftPath.stroke()
            }
            
            context!.restoreGState()
            
            //// portrait Drawing
            let portraitPath = UIBezierPath()
            portraitPath.move(to: CGPoint(x: frame.minX + 15.5, y: frame.minY + 19))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 13.5, y: frame.minY + 21), controlPoint1: CGPoint(x: frame.minX + 14.4, y: frame.minY + 19), controlPoint2: CGPoint(x: frame.minX + 13.5, y: frame.minY + 19.9))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 15.5, y: frame.minY + 23), controlPoint1: CGPoint(x: frame.minX + 13.5, y: frame.minY + 22.1), controlPoint2: CGPoint(x: frame.minX + 14.4, y: frame.minY + 23))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 17.5, y: frame.minY + 21), controlPoint1: CGPoint(x: frame.minX + 16.6, y: frame.minY + 23), controlPoint2: CGPoint(x: frame.minX + 17.5, y: frame.minY + 22.1))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 15.68, y: frame.minY + 19.01), controlPoint1: CGPoint(x: frame.minX + 17.5, y: frame.minY + 19.96), controlPoint2: CGPoint(x: frame.minX + 16.7, y: frame.minY + 19.1))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 15.5, y: frame.minY + 19), controlPoint1: CGPoint(x: frame.minX + 15.62, y: frame.minY + 19), controlPoint2: CGPoint(x: frame.minX + 15.56, y: frame.minY + 19))
            portraitPath.close()
            portraitPath.move(to: CGPoint(x: frame.minX + 21.62, y: frame.minY + 0.62))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 22.85, y: frame.minY + 1.76), controlPoint1: CGPoint(x: frame.minX + 22.25, y: frame.minY + 0.84), controlPoint2: CGPoint(x: frame.minX + 22.66, y: frame.minY + 1.25))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 23, y: frame.minY + 3.56), controlPoint1: CGPoint(x: frame.minX + 23, y: frame.minY + 2.24), controlPoint2: CGPoint(x: frame.minX + 23, y: frame.minY + 2.68))
            portraitPath.addLine(to: CGPoint(x: frame.minX + 23, y: frame.minY + 22.44))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 22.87, y: frame.minY + 24.16), controlPoint1: CGPoint(x: frame.minX + 23, y: frame.minY + 23.32), controlPoint2: CGPoint(x: frame.minX + 23, y: frame.minY + 23.76))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 21.74, y: frame.minY + 25.35), controlPoint1: CGPoint(x: frame.minX + 22.66, y: frame.minY + 24.75), controlPoint2: CGPoint(x: frame.minX + 22.25, y: frame.minY + 25.16))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 19.94, y: frame.minY + 25.5), controlPoint1: CGPoint(x: frame.minX + 21.26, y: frame.minY + 25.5), controlPoint2: CGPoint(x: frame.minX + 20.82, y: frame.minY + 25.5))
            portraitPath.addLine(to: CGPoint(x: frame.minX + 11.06, y: frame.minY + 25.5))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 9.34, y: frame.minY + 25.37), controlPoint1: CGPoint(x: frame.minX + 10.18, y: frame.minY + 25.5), controlPoint2: CGPoint(x: frame.minX + 9.74, y: frame.minY + 25.5))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 8.15, y: frame.minY + 24.24), controlPoint1: CGPoint(x: frame.minX + 8.75, y: frame.minY + 25.16), controlPoint2: CGPoint(x: frame.minX + 8.34, y: frame.minY + 24.75))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 8, y: frame.minY + 22.44), controlPoint1: CGPoint(x: frame.minX + 8, y: frame.minY + 23.76), controlPoint2: CGPoint(x: frame.minX + 8, y: frame.minY + 23.32))
            portraitPath.addLine(to: CGPoint(x: frame.minX + 8, y: frame.minY + 3.56))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 8.13, y: frame.minY + 1.84), controlPoint1: CGPoint(x: frame.minX + 8, y: frame.minY + 2.68), controlPoint2: CGPoint(x: frame.minX + 8, y: frame.minY + 2.24))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 9.26, y: frame.minY + 0.65), controlPoint1: CGPoint(x: frame.minX + 8.34, y: frame.minY + 1.25), controlPoint2: CGPoint(x: frame.minX + 8.75, y: frame.minY + 0.84))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 11.06, y: frame.minY + 0.5), controlPoint1: CGPoint(x: frame.minX + 9.74, y: frame.minY + 0.5), controlPoint2: CGPoint(x: frame.minX + 10.18, y: frame.minY + 0.5))
            portraitPath.addLine(to: CGPoint(x: frame.minX + 19.94, y: frame.minY + 0.5))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 21.66, y: frame.minY + 0.63), controlPoint1: CGPoint(x: frame.minX + 20.82, y: frame.minY + 0.5), controlPoint2: CGPoint(x: frame.minX + 21.26, y: frame.minY + 0.5))
            portraitPath.addLine(to: CGPoint(x: frame.minX + 21.62, y: frame.minY + 0.62))
            portraitPath.close()
            portraitPath.lineWidth = 1
            
            if mask.contains(.portrait) {
                portraitPath.fill()
            } else {
                portraitPath.stroke()
            }
            
            //// portraitUpsideDown Drawing
            let portraitUpsideDownPath = UIBezierPath()
            portraitUpsideDownPath.move(to: CGPoint(x: frame.minX + 46.5, y: frame.minY + 3))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 44.5, y: frame.minY + 5), controlPoint1: CGPoint(x: frame.minX + 45.4, y: frame.minY + 3), controlPoint2: CGPoint(x: frame.minX + 44.5, y: frame.minY + 3.9))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 46.5, y: frame.minY + 7), controlPoint1: CGPoint(x: frame.minX + 44.5, y: frame.minY + 6.1), controlPoint2: CGPoint(x: frame.minX + 45.4, y: frame.minY + 7))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 48.5, y: frame.minY + 5), controlPoint1: CGPoint(x: frame.minX + 47.6, y: frame.minY + 7), controlPoint2: CGPoint(x: frame.minX + 48.5, y: frame.minY + 6.1))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 46.5, y: frame.minY + 3), controlPoint1: CGPoint(x: frame.minX + 48.5, y: frame.minY + 3.9), controlPoint2: CGPoint(x: frame.minX + 47.6, y: frame.minY + 3))
            portraitUpsideDownPath.close()
            portraitUpsideDownPath.move(to: CGPoint(x: frame.minX + 52.62, y: frame.minY + 0.62))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 53.85, y: frame.minY + 1.76), controlPoint1: CGPoint(x: frame.minX + 53.25, y: frame.minY + 0.84), controlPoint2: CGPoint(x: frame.minX + 53.66, y: frame.minY + 1.25))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 54, y: frame.minY + 3.56), controlPoint1: CGPoint(x: frame.minX + 54, y: frame.minY + 2.24), controlPoint2: CGPoint(x: frame.minX + 54, y: frame.minY + 2.68))
            portraitUpsideDownPath.addLine(to: CGPoint(x: frame.minX + 54, y: frame.minY + 22.44))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 53.87, y: frame.minY + 24.16), controlPoint1: CGPoint(x: frame.minX + 54, y: frame.minY + 23.32), controlPoint2: CGPoint(x: frame.minX + 54, y: frame.minY + 23.76))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 52.74, y: frame.minY + 25.35), controlPoint1: CGPoint(x: frame.minX + 53.66, y: frame.minY + 24.75), controlPoint2: CGPoint(x: frame.minX + 53.25, y: frame.minY + 25.16))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 50.94, y: frame.minY + 25.5), controlPoint1: CGPoint(x: frame.minX + 52.26, y: frame.minY + 25.5), controlPoint2: CGPoint(x: frame.minX + 51.82, y: frame.minY + 25.5))
            portraitUpsideDownPath.addLine(to: CGPoint(x: frame.minX + 42.06, y: frame.minY + 25.5))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 40.34, y: frame.minY + 25.37), controlPoint1: CGPoint(x: frame.minX + 41.18, y: frame.minY + 25.5), controlPoint2: CGPoint(x: frame.minX + 40.74, y: frame.minY + 25.5))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 39.15, y: frame.minY + 24.24), controlPoint1: CGPoint(x: frame.minX + 39.75, y: frame.minY + 25.16), controlPoint2: CGPoint(x: frame.minX + 39.34, y: frame.minY + 24.75))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 39.04, y: frame.minY + 23.72), controlPoint1: CGPoint(x: frame.minX + 39.1, y: frame.minY + 24.07), controlPoint2: CGPoint(x: frame.minX + 39.06, y: frame.minY + 23.9))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 39, y: frame.minY + 22.44), controlPoint1: CGPoint(x: frame.minX + 39, y: frame.minY + 23.39), controlPoint2: CGPoint(x: frame.minX + 39, y: frame.minY + 23.01))
            portraitUpsideDownPath.addLine(to: CGPoint(x: frame.minX + 39, y: frame.minY + 3.56))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 39.13, y: frame.minY + 1.84), controlPoint1: CGPoint(x: frame.minX + 39, y: frame.minY + 2.68), controlPoint2: CGPoint(x: frame.minX + 39, y: frame.minY + 2.24))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 40.26, y: frame.minY + 0.65), controlPoint1: CGPoint(x: frame.minX + 39.34, y: frame.minY + 1.25), controlPoint2: CGPoint(x: frame.minX + 39.75, y: frame.minY + 0.84))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 42.06, y: frame.minY + 0.5), controlPoint1: CGPoint(x: frame.minX + 40.74, y: frame.minY + 0.5), controlPoint2: CGPoint(x: frame.minX + 41.18, y: frame.minY + 0.5))
            portraitUpsideDownPath.addLine(to: CGPoint(x: frame.minX + 50.94, y: frame.minY + 0.5))
            portraitUpsideDownPath.addCurve(to: CGPoint(x: frame.minX + 52.66, y: frame.minY + 0.63), controlPoint1: CGPoint(x: frame.minX + 51.82, y: frame.minY + 0.5), controlPoint2: CGPoint(x: frame.minX + 52.26, y: frame.minY + 0.5))
            portraitUpsideDownPath.addLine(to: CGPoint(x: frame.minX + 52.62, y: frame.minY + 0.62))
            portraitUpsideDownPath.close()
            portraitUpsideDownPath.lineWidth = 1
            
            if mask.contains(.portraitUpsideDown) {
                portraitUpsideDownPath.fill()
            } else {
                portraitUpsideDownPath.stroke()
            }
            
            //// landscapeRight Drawing
            let landscapeRightPath = UIBezierPath()
            landscapeRightPath.move(to: CGPoint(x: frame.minX + 54.5, y: frame.minY + 39.5))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 52.5, y: frame.minY + 41.5), controlPoint1: CGPoint(x: frame.minX + 53.4, y: frame.minY + 39.5), controlPoint2: CGPoint(x: frame.minX + 52.5, y: frame.minY + 40.4))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 52.6, y: frame.minY + 42.13), controlPoint1: CGPoint(x: frame.minX + 52.5, y: frame.minY + 41.72), controlPoint2: CGPoint(x: frame.minX + 52.54, y: frame.minY + 41.94))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 54.5, y: frame.minY + 43.5), controlPoint1: CGPoint(x: frame.minX + 52.87, y: frame.minY + 42.93), controlPoint2: CGPoint(x: frame.minX + 53.62, y: frame.minY + 43.5))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 56.5, y: frame.minY + 41.5), controlPoint1: CGPoint(x: frame.minX + 55.6, y: frame.minY + 43.5), controlPoint2: CGPoint(x: frame.minX + 56.5, y: frame.minY + 42.6))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 54.5, y: frame.minY + 39.5), controlPoint1: CGPoint(x: frame.minX + 56.5, y: frame.minY + 40.4), controlPoint2: CGPoint(x: frame.minX + 55.6, y: frame.minY + 39.5))
            landscapeRightPath.close()
            landscapeRightPath.move(to: CGPoint(x: frame.minX + 55.94, y: frame.minY + 34))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 57.66, y: frame.minY + 34.13), controlPoint1: CGPoint(x: frame.minX + 56.82, y: frame.minY + 34), controlPoint2: CGPoint(x: frame.minX + 57.26, y: frame.minY + 34))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 58.85, y: frame.minY + 35.26), controlPoint1: CGPoint(x: frame.minX + 58.25, y: frame.minY + 34.34), controlPoint2: CGPoint(x: frame.minX + 58.66, y: frame.minY + 34.75))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 59, y: frame.minY + 37.06), controlPoint1: CGPoint(x: frame.minX + 59, y: frame.minY + 35.74), controlPoint2: CGPoint(x: frame.minX + 59, y: frame.minY + 36.18))
            landscapeRightPath.addLine(to: CGPoint(x: frame.minX + 59, y: frame.minY + 45.94))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 58.87, y: frame.minY + 47.66), controlPoint1: CGPoint(x: frame.minX + 59, y: frame.minY + 46.82), controlPoint2: CGPoint(x: frame.minX + 59, y: frame.minY + 47.26))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 57.74, y: frame.minY + 48.85), controlPoint1: CGPoint(x: frame.minX + 58.66, y: frame.minY + 48.25), controlPoint2: CGPoint(x: frame.minX + 58.25, y: frame.minY + 48.66))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 55.94, y: frame.minY + 49), controlPoint1: CGPoint(x: frame.minX + 57.26, y: frame.minY + 49), controlPoint2: CGPoint(x: frame.minX + 56.82, y: frame.minY + 49))
            landscapeRightPath.addLine(to: CGPoint(x: frame.minX + 37.06, y: frame.minY + 49))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 35.34, y: frame.minY + 48.87), controlPoint1: CGPoint(x: frame.minX + 36.18, y: frame.minY + 49), controlPoint2: CGPoint(x: frame.minX + 35.74, y: frame.minY + 49))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 34.15, y: frame.minY + 47.74), controlPoint1: CGPoint(x: frame.minX + 34.75, y: frame.minY + 48.66), controlPoint2: CGPoint(x: frame.minX + 34.34, y: frame.minY + 48.25))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 34, y: frame.minY + 45.94), controlPoint1: CGPoint(x: frame.minX + 34, y: frame.minY + 47.26), controlPoint2: CGPoint(x: frame.minX + 34, y: frame.minY + 46.82))
            landscapeRightPath.addLine(to: CGPoint(x: frame.minX + 34, y: frame.minY + 37.06))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 34.13, y: frame.minY + 35.34), controlPoint1: CGPoint(x: frame.minX + 34, y: frame.minY + 36.18), controlPoint2: CGPoint(x: frame.minX + 34, y: frame.minY + 35.74))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 35.26, y: frame.minY + 34.15), controlPoint1: CGPoint(x: frame.minX + 34.34, y: frame.minY + 34.75), controlPoint2: CGPoint(x: frame.minX + 34.75, y: frame.minY + 34.34))
            landscapeRightPath.addCurve(to: CGPoint(x: frame.minX + 37.06, y: frame.minY + 34), controlPoint1: CGPoint(x: frame.minX + 35.74, y: frame.minY + 34), controlPoint2: CGPoint(x: frame.minX + 36.18, y: frame.minY + 34))
            landscapeRightPath.addLine(to: CGPoint(x: frame.minX + 55.94, y: frame.minY + 34))
            landscapeRightPath.addLine(to: CGPoint(x: frame.minX + 55.94, y: frame.minY + 34))
            landscapeRightPath.close()
            landscapeRightPath.lineWidth = 1
            
            if mask.contains(.landscapeRight) {
                landscapeRightPath.fill()
            } else {
                landscapeRightPath.stroke()
            }
        }
    }
    
}
