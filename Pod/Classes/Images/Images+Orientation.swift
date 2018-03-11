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

import Foundation
import GraphicsRenderer

extension Images {
    
    static func orientationImage(_ orientation: UIInterfaceOrientation) -> UIImage {
        return ImageRenderer(size: CGSize(width: 25, height: 25)).image { context in
            let rect = context.format.bounds
            drawOrientation(frame: rect, portraitVisible: orientation == .portrait, portraitUpsideDownVisible: orientation == .portraitUpsideDown, lanscapeLeftVisible: orientation == .landscapeLeft, landscapeRightVisible: orientation == .landscapeRight)
        }
    }
    
    static func drawOrientation(frame: CGRect = CGRect(x: 0, y: 0, width: 25, height: 25), portraitVisible: Bool = true, portraitUpsideDownVisible: Bool = false, lanscapeLeftVisible: Bool = false, landscapeRightVisible: Bool = false) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        if portraitVisible {
            //// portrait Drawing
            let portraitPath = UIBezierPath()
            portraitPath.move(to: CGPoint(x: frame.minX + 12.5, y: frame.minY + 18.5))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 10.5, y: frame.minY + 20.5), controlPoint1: CGPoint(x: frame.minX + 11.4, y: frame.minY + 18.5), controlPoint2: CGPoint(x: frame.minX + 10.5, y: frame.minY + 19.4))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 12.5, y: frame.minY + 22.5), controlPoint1: CGPoint(x: frame.minX + 10.5, y: frame.minY + 21.6), controlPoint2: CGPoint(x: frame.minX + 11.4, y: frame.minY + 22.5))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 14.5, y: frame.minY + 20.5), controlPoint1: CGPoint(x: frame.minX + 13.6, y: frame.minY + 22.5), controlPoint2: CGPoint(x: frame.minX + 14.5, y: frame.minY + 21.6))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 12.68, y: frame.minY + 18.51), controlPoint1: CGPoint(x: frame.minX + 14.5, y: frame.minY + 19.46), controlPoint2: CGPoint(x: frame.minX + 13.7, y: frame.minY + 18.6))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 12.5, y: frame.minY + 18.5), controlPoint1: CGPoint(x: frame.minX + 12.62, y: frame.minY + 18.5), controlPoint2: CGPoint(x: frame.minX + 12.56, y: frame.minY + 18.5))
            portraitPath.close()
            portraitPath.move(to: CGPoint(x: frame.minX + 18.62, y: frame.minY + 0.12))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 19.85, y: frame.minY + 1.26), controlPoint1: CGPoint(x: frame.minX + 19.25, y: frame.minY + 0.34), controlPoint2: CGPoint(x: frame.minX + 19.66, y: frame.minY + 0.75))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 20, y: frame.minY + 3.06), controlPoint1: CGPoint(x: frame.minX + 20, y: frame.minY + 1.74), controlPoint2: CGPoint(x: frame.minX + 20, y: frame.minY + 2.18))
            portraitPath.addLine(to: CGPoint(x: frame.minX + 20, y: frame.minY + 21.94))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 19.87, y: frame.minY + 23.66), controlPoint1: CGPoint(x: frame.minX + 20, y: frame.minY + 22.82), controlPoint2: CGPoint(x: frame.minX + 20, y: frame.minY + 23.26))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 18.74, y: frame.minY + 24.85), controlPoint1: CGPoint(x: frame.minX + 19.66, y: frame.minY + 24.25), controlPoint2: CGPoint(x: frame.minX + 19.25, y: frame.minY + 24.66))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 16.94, y: frame.minY + 25), controlPoint1: CGPoint(x: frame.minX + 18.26, y: frame.minY + 25), controlPoint2: CGPoint(x: frame.minX + 17.82, y: frame.minY + 25))
            portraitPath.addLine(to: CGPoint(x: frame.minX + 8.06, y: frame.minY + 25))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 6.34, y: frame.minY + 24.87), controlPoint1: CGPoint(x: frame.minX + 7.18, y: frame.minY + 25), controlPoint2: CGPoint(x: frame.minX + 6.74, y: frame.minY + 25))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 5.15, y: frame.minY + 23.74), controlPoint1: CGPoint(x: frame.minX + 5.75, y: frame.minY + 24.66), controlPoint2: CGPoint(x: frame.minX + 5.34, y: frame.minY + 24.25))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 5, y: frame.minY + 21.94), controlPoint1: CGPoint(x: frame.minX + 5, y: frame.minY + 23.26), controlPoint2: CGPoint(x: frame.minX + 5, y: frame.minY + 22.82))
            portraitPath.addLine(to: CGPoint(x: frame.minX + 5, y: frame.minY + 3.06))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 5.13, y: frame.minY + 1.34), controlPoint1: CGPoint(x: frame.minX + 5, y: frame.minY + 2.18), controlPoint2: CGPoint(x: frame.minX + 5, y: frame.minY + 1.74))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 6.26, y: frame.minY + 0.15), controlPoint1: CGPoint(x: frame.minX + 5.34, y: frame.minY + 0.75), controlPoint2: CGPoint(x: frame.minX + 5.75, y: frame.minY + 0.34))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 8.06, y: frame.minY), controlPoint1: CGPoint(x: frame.minX + 6.74, y: frame.minY), controlPoint2: CGPoint(x: frame.minX + 7.18, y: frame.minY))
            portraitPath.addLine(to: CGPoint(x: frame.minX + 16.94, y: frame.minY))
            portraitPath.addCurve(to: CGPoint(x: frame.minX + 18.66, y: frame.minY + 0.13), controlPoint1: CGPoint(x: frame.minX + 17.82, y: frame.minY), controlPoint2: CGPoint(x: frame.minX + 18.26, y: frame.minY))
            portraitPath.addLine(to: CGPoint(x: frame.minX + 18.62, y: frame.minY + 0.12))
            portraitPath.close()
            white.setFill()
            portraitPath.fill()
        }
        
        if portraitUpsideDownVisible {
            //// upsideDown Drawing
            let upsideDownPath = UIBezierPath()
            upsideDownPath.move(to: CGPoint(x: frame.minX + 12.5, y: frame.minY + 6.5))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 10.5, y: frame.minY + 4.5), controlPoint1: CGPoint(x: frame.minX + 11.4, y: frame.minY + 6.5), controlPoint2: CGPoint(x: frame.minX + 10.5, y: frame.minY + 5.6))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 12.5, y: frame.minY + 2.5), controlPoint1: CGPoint(x: frame.minX + 10.5, y: frame.minY + 3.4), controlPoint2: CGPoint(x: frame.minX + 11.4, y: frame.minY + 2.5))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 14.5, y: frame.minY + 4.5), controlPoint1: CGPoint(x: frame.minX + 13.6, y: frame.minY + 2.5), controlPoint2: CGPoint(x: frame.minX + 14.5, y: frame.minY + 3.4))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 12.68, y: frame.minY + 6.49), controlPoint1: CGPoint(x: frame.minX + 14.5, y: frame.minY + 5.54), controlPoint2: CGPoint(x: frame.minX + 13.7, y: frame.minY + 6.4))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 12.5, y: frame.minY + 6.5), controlPoint1: CGPoint(x: frame.minX + 12.62, y: frame.minY + 6.5), controlPoint2: CGPoint(x: frame.minX + 12.56, y: frame.minY + 6.5))
            upsideDownPath.close()
            upsideDownPath.move(to: CGPoint(x: frame.minX + 18.62, y: frame.minY + 24.88))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 19.85, y: frame.minY + 23.74), controlPoint1: CGPoint(x: frame.minX + 19.25, y: frame.minY + 24.66), controlPoint2: CGPoint(x: frame.minX + 19.66, y: frame.minY + 24.25))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 20, y: frame.minY + 21.94), controlPoint1: CGPoint(x: frame.minX + 20, y: frame.minY + 23.26), controlPoint2: CGPoint(x: frame.minX + 20, y: frame.minY + 22.82))
            upsideDownPath.addLine(to: CGPoint(x: frame.minX + 20, y: frame.minY + 3.06))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 19.87, y: frame.minY + 1.34), controlPoint1: CGPoint(x: frame.minX + 20, y: frame.minY + 2.18), controlPoint2: CGPoint(x: frame.minX + 20, y: frame.minY + 1.74))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 18.74, y: frame.minY + 0.15), controlPoint1: CGPoint(x: frame.minX + 19.66, y: frame.minY + 0.75), controlPoint2: CGPoint(x: frame.minX + 19.25, y: frame.minY + 0.34))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 16.94, y: frame.minY), controlPoint1: CGPoint(x: frame.minX + 18.26, y: frame.minY), controlPoint2: CGPoint(x: frame.minX + 17.82, y: frame.minY))
            upsideDownPath.addLine(to: CGPoint(x: frame.minX + 8.06, y: frame.minY))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 6.34, y: frame.minY + 0.13), controlPoint1: CGPoint(x: frame.minX + 7.18, y: frame.minY), controlPoint2: CGPoint(x: frame.minX + 6.74, y: frame.minY))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 5.15, y: frame.minY + 1.26), controlPoint1: CGPoint(x: frame.minX + 5.75, y: frame.minY + 0.34), controlPoint2: CGPoint(x: frame.minX + 5.34, y: frame.minY + 0.75))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 5, y: frame.minY + 3.06), controlPoint1: CGPoint(x: frame.minX + 5, y: frame.minY + 1.74), controlPoint2: CGPoint(x: frame.minX + 5, y: frame.minY + 2.18))
            upsideDownPath.addLine(to: CGPoint(x: frame.minX + 5, y: frame.minY + 21.94))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 5.13, y: frame.minY + 23.66), controlPoint1: CGPoint(x: frame.minX + 5, y: frame.minY + 22.82), controlPoint2: CGPoint(x: frame.minX + 5, y: frame.minY + 23.26))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 6.26, y: frame.minY + 24.85), controlPoint1: CGPoint(x: frame.minX + 5.34, y: frame.minY + 24.25), controlPoint2: CGPoint(x: frame.minX + 5.75, y: frame.minY + 24.66))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 8.06, y: frame.minY + 25), controlPoint1: CGPoint(x: frame.minX + 6.74, y: frame.minY + 25), controlPoint2: CGPoint(x: frame.minX + 7.18, y: frame.minY + 25))
            upsideDownPath.addLine(to: CGPoint(x: frame.minX + 16.94, y: frame.minY + 25))
            upsideDownPath.addCurve(to: CGPoint(x: frame.minX + 18.66, y: frame.minY + 24.87), controlPoint1: CGPoint(x: frame.minX + 17.82, y: frame.minY + 25), controlPoint2: CGPoint(x: frame.minX + 18.26, y: frame.minY + 25))
            upsideDownPath.addLine(to: CGPoint(x: frame.minX + 18.62, y: frame.minY + 24.88))
            upsideDownPath.close()
            white.setFill()
            upsideDownPath.fill()
        }
        
        if lanscapeLeftVisible {
            //// left Drawing
            context!.saveGState()
            context!.translateBy(x: frame.minX + 25, y: frame.minY + 5)
            context!.rotate(by: 90 * CGFloat.pi / 180)
            
            let leftPath = UIBezierPath()
            leftPath.move(to: CGPoint(x: 7.5, y: 18.5))
            leftPath.addCurve(to: CGPoint(x: 5.5, y: 20.5), controlPoint1: CGPoint(x: 6.4, y: 18.5), controlPoint2: CGPoint(x: 5.5, y: 19.4))
            leftPath.addCurve(to: CGPoint(x: 7.5, y: 22.5), controlPoint1: CGPoint(x: 5.5, y: 21.6), controlPoint2: CGPoint(x: 6.4, y: 22.5))
            leftPath.addCurve(to: CGPoint(x: 9.5, y: 20.5), controlPoint1: CGPoint(x: 8.6, y: 22.5), controlPoint2: CGPoint(x: 9.5, y: 21.6))
            leftPath.addCurve(to: CGPoint(x: 7.68, y: 18.51), controlPoint1: CGPoint(x: 9.5, y: 19.46), controlPoint2: CGPoint(x: 8.7, y: 18.6))
            leftPath.addCurve(to: CGPoint(x: 7.5, y: 18.5), controlPoint1: CGPoint(x: 7.62, y: 18.5), controlPoint2: CGPoint(x: 7.56, y: 18.5))
            leftPath.close()
            leftPath.move(to: CGPoint(x: 13.62, y: 0.12))
            leftPath.addCurve(to: CGPoint(x: 14.85, y: 1.26), controlPoint1: CGPoint(x: 14.25, y: 0.34), controlPoint2: CGPoint(x: 14.66, y: 0.75))
            leftPath.addCurve(to: CGPoint(x: 15, y: 3.06), controlPoint1: CGPoint(x: 15, y: 1.74), controlPoint2: CGPoint(x: 15, y: 2.18))
            leftPath.addLine(to: CGPoint(x: 15, y: 21.94))
            leftPath.addCurve(to: CGPoint(x: 14.87, y: 23.66), controlPoint1: CGPoint(x: 15, y: 22.82), controlPoint2: CGPoint(x: 15, y: 23.26))
            leftPath.addCurve(to: CGPoint(x: 13.74, y: 24.85), controlPoint1: CGPoint(x: 14.66, y: 24.25), controlPoint2: CGPoint(x: 14.25, y: 24.66))
            leftPath.addCurve(to: CGPoint(x: 11.94, y: 25), controlPoint1: CGPoint(x: 13.26, y: 25), controlPoint2: CGPoint(x: 12.82, y: 25))
            leftPath.addLine(to: CGPoint(x: 3.06, y: 25))
            leftPath.addCurve(to: CGPoint(x: 1.34, y: 24.87), controlPoint1: CGPoint(x: 2.18, y: 25), controlPoint2: CGPoint(x: 1.74, y: 25))
            leftPath.addCurve(to: CGPoint(x: 0.15, y: 23.74), controlPoint1: CGPoint(x: 0.75, y: 24.66), controlPoint2: CGPoint(x: 0.34, y: 24.25))
            leftPath.addCurve(to: CGPoint(x: 0, y: 21.94), controlPoint1: CGPoint(x: 0, y: 23.26), controlPoint2: CGPoint(x: 0, y: 22.82))
            leftPath.addLine(to: CGPoint(x: 0, y: 3.06))
            leftPath.addCurve(to: CGPoint(x: 0.13, y: 1.34), controlPoint1: CGPoint(x: 0, y: 2.18), controlPoint2: CGPoint(x: 0, y: 1.74))
            leftPath.addCurve(to: CGPoint(x: 1.26, y: 0.15), controlPoint1: CGPoint(x: 0.34, y: 0.75), controlPoint2: CGPoint(x: 0.75, y: 0.34))
            leftPath.addCurve(to: CGPoint(x: 3.06, y: 0), controlPoint1: CGPoint(x: 1.74, y: 0), controlPoint2: CGPoint(x: 2.18, y: 0))
            leftPath.addLine(to: CGPoint(x: 11.94, y: 0))
            leftPath.addCurve(to: CGPoint(x: 13.66, y: 0.13), controlPoint1: CGPoint(x: 12.82, y: 0), controlPoint2: CGPoint(x: 13.26, y: 0))
            leftPath.addLine(to: CGPoint(x: 13.62, y: 0.12))
            leftPath.close()
            white.setFill()
            leftPath.fill()
            
            context!.restoreGState()
        }
        
        if landscapeRightVisible {
            //// right Drawing
            context!.saveGState()
            context!.translateBy(x: frame.minX, y: frame.minY + 20)
            context!.rotate(by: -90 * CGFloat.pi / 180)
            
            let rightPath = UIBezierPath()
            rightPath.move(to: CGPoint(x: 7.5, y: 18.5))
            rightPath.addCurve(to: CGPoint(x: 5.5, y: 20.5), controlPoint1: CGPoint(x: 6.4, y: 18.5), controlPoint2: CGPoint(x: 5.5, y: 19.4))
            rightPath.addCurve(to: CGPoint(x: 7.5, y: 22.5), controlPoint1: CGPoint(x: 5.5, y: 21.6), controlPoint2: CGPoint(x: 6.4, y: 22.5))
            rightPath.addCurve(to: CGPoint(x: 9.5, y: 20.5), controlPoint1: CGPoint(x: 8.6, y: 22.5), controlPoint2: CGPoint(x: 9.5, y: 21.6))
            rightPath.addCurve(to: CGPoint(x: 7.68, y: 18.51), controlPoint1: CGPoint(x: 9.5, y: 19.46), controlPoint2: CGPoint(x: 8.7, y: 18.6))
            rightPath.addCurve(to: CGPoint(x: 7.5, y: 18.5), controlPoint1: CGPoint(x: 7.62, y: 18.5), controlPoint2: CGPoint(x: 7.56, y: 18.5))
            rightPath.close()
            rightPath.move(to: CGPoint(x: 13.62, y: 0.12))
            rightPath.addCurve(to: CGPoint(x: 14.85, y: 1.26), controlPoint1: CGPoint(x: 14.25, y: 0.34), controlPoint2: CGPoint(x: 14.66, y: 0.75))
            rightPath.addCurve(to: CGPoint(x: 15, y: 3.06), controlPoint1: CGPoint(x: 15, y: 1.74), controlPoint2: CGPoint(x: 15, y: 2.18))
            rightPath.addLine(to: CGPoint(x: 15, y: 21.94))
            rightPath.addCurve(to: CGPoint(x: 14.87, y: 23.66), controlPoint1: CGPoint(x: 15, y: 22.82), controlPoint2: CGPoint(x: 15, y: 23.26))
            rightPath.addCurve(to: CGPoint(x: 13.74, y: 24.85), controlPoint1: CGPoint(x: 14.66, y: 24.25), controlPoint2: CGPoint(x: 14.25, y: 24.66))
            rightPath.addCurve(to: CGPoint(x: 11.94, y: 25), controlPoint1: CGPoint(x: 13.26, y: 25), controlPoint2: CGPoint(x: 12.82, y: 25))
            rightPath.addLine(to: CGPoint(x: 3.06, y: 25))
            rightPath.addCurve(to: CGPoint(x: 1.34, y: 24.87), controlPoint1: CGPoint(x: 2.18, y: 25), controlPoint2: CGPoint(x: 1.74, y: 25))
            rightPath.addCurve(to: CGPoint(x: 0.15, y: 23.74), controlPoint1: CGPoint(x: 0.75, y: 24.66), controlPoint2: CGPoint(x: 0.34, y: 24.25))
            rightPath.addCurve(to: CGPoint(x: 0, y: 21.94), controlPoint1: CGPoint(x: 0, y: 23.26), controlPoint2: CGPoint(x: 0, y: 22.82))
            rightPath.addLine(to: CGPoint(x: 0, y: 3.06))
            rightPath.addCurve(to: CGPoint(x: 0.13, y: 1.34), controlPoint1: CGPoint(x: 0, y: 2.18), controlPoint2: CGPoint(x: 0, y: 1.74))
            rightPath.addCurve(to: CGPoint(x: 1.26, y: 0.15), controlPoint1: CGPoint(x: 0.34, y: 0.75), controlPoint2: CGPoint(x: 0.75, y: 0.34))
            rightPath.addCurve(to: CGPoint(x: 3.06, y: 0), controlPoint1: CGPoint(x: 1.74, y: 0), controlPoint2: CGPoint(x: 2.18, y: 0))
            rightPath.addLine(to: CGPoint(x: 11.94, y: 0))
            rightPath.addCurve(to: CGPoint(x: 13.66, y: 0.13), controlPoint1: CGPoint(x: 12.82, y: 0), controlPoint2: CGPoint(x: 13.26, y: 0))
            rightPath.addLine(to: CGPoint(x: 13.62, y: 0.12))
            rightPath.close()
            white.setFill()
            rightPath.fill()
            
            context!.restoreGState()
        }
    }
    
}
