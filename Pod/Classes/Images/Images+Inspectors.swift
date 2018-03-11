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

final class Images {
    
    static func disclosure(size: CGSize, thickness: CGFloat) -> UIImage {
        return ImageRenderer(size: size).image { context in
            let rect = context.format.bounds.insetBy(dx: thickness, dy: thickness)
            let path = UIBezierPath()
            
            path.move(to: rect.origin)
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            path.lineWidth = thickness
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            
            UIColor.white.setStroke()
            path.stroke()
        }
    }
    
    static var close: UIImage {
        return ImageRenderer(size: CGSize(width: 18, height: 18)).image { context in
            let color = UIColor.neutral
            let thickness: CGFloat = 2
            let rect = context.format.bounds.insetBy(dx: thickness, dy: thickness)
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            color?.setStroke()
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            path.lineWidth = thickness
            path.stroke()
        }
    }
    
    internal static var attributes: UIImage {
        return ImageRenderer(size: CGSize(width: 30, height: 25)).image { context in
            //// Color Declarations
            let color2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
            
            //// Bezier 4 Drawing
            let bezier4Path = UIBezierPath()
            bezier4Path.move(to: CGPoint(x: 7.5, y: 3.71))
            bezier4Path.addCurve(to: CGPoint(x: 6.5, y: 3.5), controlPoint1: CGPoint(x: 7.19, y: 3.57), controlPoint2: CGPoint(x: 6.86, y: 3.5))
            bezier4Path.addCurve(to: CGPoint(x: 5.87, y: 3.58), controlPoint1: CGPoint(x: 6.28, y: 3.5), controlPoint2: CGPoint(x: 6.07, y: 3.53))
            bezier4Path.addCurve(to: CGPoint(x: 5.5, y: 3.71), controlPoint1: CGPoint(x: 5.74, y: 3.61), controlPoint2: CGPoint(x: 5.62, y: 3.66))
            bezier4Path.addCurve(to: CGPoint(x: 5.5, y: 1.07), controlPoint1: CGPoint(x: 5.5, y: 2.89), controlPoint2: CGPoint(x: 5.5, y: 2.01))
            bezier4Path.addLine(to: CGPoint(x: 5.5, y: 1))
            bezier4Path.addLine(to: CGPoint(x: 7.5, y: 1))
            bezier4Path.addCurve(to: CGPoint(x: 7.5, y: 3.71), controlPoint1: CGPoint(x: 7.5, y: 1.97), controlPoint2: CGPoint(x: 7.5, y: 2.87))
            bezier4Path.close()
            bezier4Path.move(to: CGPoint(x: 7.5, y: 17.59))
            bezier4Path.addCurve(to: CGPoint(x: 7.5, y: 17.97), controlPoint1: CGPoint(x: 7.5, y: 17.87), controlPoint2: CGPoint(x: 7.5, y: 17.87))
            bezier4Path.addLine(to: CGPoint(x: 5.5, y: 18))
            bezier4Path.addCurve(to: CGPoint(x: 5.5, y: 17.59), controlPoint1: CGPoint(x: 5.5, y: 17.87), controlPoint2: CGPoint(x: 5.5, y: 17.87))
            bezier4Path.addCurve(to: CGPoint(x: 5.5, y: 8.29), controlPoint1: CGPoint(x: 5.5, y: 15.4), controlPoint2: CGPoint(x: 5.5, y: 14.92))
            bezier4Path.addCurve(to: CGPoint(x: 6.5, y: 8.5), controlPoint1: CGPoint(x: 5.81, y: 8.43), controlPoint2: CGPoint(x: 6.14, y: 8.5))
            bezier4Path.addCurve(to: CGPoint(x: 7.5, y: 8.29), controlPoint1: CGPoint(x: 6.86, y: 8.5), controlPoint2: CGPoint(x: 7.19, y: 8.43))
            bezier4Path.addCurve(to: CGPoint(x: 7.5, y: 17.59), controlPoint1: CGPoint(x: 7.5, y: 14.92), controlPoint2: CGPoint(x: 7.5, y: 15.4))
            bezier4Path.close()
            bezier4Path.move(to: CGPoint(x: 5.5, y: 18.01))
            bezier4Path.addCurve(to: CGPoint(x: 7.5, y: 18.01), controlPoint1: CGPoint(x: 5.5, y: 18.01), controlPoint2: CGPoint(x: 5.5, y: 18.01))
            bezier4Path.addLine(to: CGPoint(x: 5.5, y: 18.01))
            bezier4Path.addLine(to: CGPoint(x: 5.5, y: 18.01))
            bezier4Path.close()
            color2.setFill()
            bezier4Path.fill()
            
            //// Bezier Drawing
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 16.5, y: 10.71))
            bezierPath.addCurve(to: CGPoint(x: 15.5, y: 10.5), controlPoint1: CGPoint(x: 16.19, y: 10.57), controlPoint2: CGPoint(x: 15.86, y: 10.5))
            bezierPath.addCurve(to: CGPoint(x: 15.01, y: 10.55), controlPoint1: CGPoint(x: 15.33, y: 10.5), controlPoint2: CGPoint(x: 15.17, y: 10.52))
            bezierPath.addCurve(to: CGPoint(x: 14.5, y: 10.71), controlPoint1: CGPoint(x: 14.83, y: 10.58), controlPoint2: CGPoint(x: 14.66, y: 10.64))
            bezierPath.addCurve(to: CGPoint(x: 14.5, y: 1.25), controlPoint1: CGPoint(x: 14.5, y: 8.88), controlPoint2: CGPoint(x: 14.5, y: 6.27))
            bezierPath.addLine(to: CGPoint(x: 14.5, y: 1))
            bezierPath.addLine(to: CGPoint(x: 16.5, y: 1))
            bezierPath.addCurve(to: CGPoint(x: 16.5, y: 10.71), controlPoint1: CGPoint(x: 16.5, y: 6.18), controlPoint2: CGPoint(x: 16.5, y: 8.85))
            bezierPath.close()
            bezierPath.move(to: CGPoint(x: 15.5, y: 15.5))
            bezierPath.addCurve(to: CGPoint(x: 16.5, y: 15.29), controlPoint1: CGPoint(x: 15.86, y: 15.5), controlPoint2: CGPoint(x: 16.19, y: 15.43))
            bezierPath.addCurve(to: CGPoint(x: 16.5, y: 15.93), controlPoint1: CGPoint(x: 16.5, y: 15.49), controlPoint2: CGPoint(x: 16.5, y: 15.71))
            bezierPath.addCurve(to: CGPoint(x: 16.5, y: 17.77), controlPoint1: CGPoint(x: 16.5, y: 17.25), controlPoint2: CGPoint(x: 16.5, y: 17.25))
            bezierPath.addCurve(to: CGPoint(x: 16.5, y: 17.99), controlPoint1: CGPoint(x: 16.5, y: 17.93), controlPoint2: CGPoint(x: 16.5, y: 17.93))
            bezierPath.addLine(to: CGPoint(x: 14.5, y: 18))
            bezierPath.addCurve(to: CGPoint(x: 14.5, y: 17.77), controlPoint1: CGPoint(x: 14.5, y: 17.93), controlPoint2: CGPoint(x: 14.5, y: 17.93))
            bezierPath.addCurve(to: CGPoint(x: 14.5, y: 15.93), controlPoint1: CGPoint(x: 14.5, y: 17.25), controlPoint2: CGPoint(x: 14.5, y: 17.25))
            bezierPath.addCurve(to: CGPoint(x: 14.5, y: 15.29), controlPoint1: CGPoint(x: 14.5, y: 15.71), controlPoint2: CGPoint(x: 14.5, y: 15.49))
            bezierPath.addCurve(to: CGPoint(x: 15.5, y: 15.5), controlPoint1: CGPoint(x: 14.81, y: 15.43), controlPoint2: CGPoint(x: 15.14, y: 15.5))
            bezierPath.close()
            bezierPath.move(to: CGPoint(x: 14.5, y: 18.01))
            bezierPath.addCurve(to: CGPoint(x: 15.7, y: 18.01), controlPoint1: CGPoint(x: 14.5, y: 18.01), controlPoint2: CGPoint(x: 14.5, y: 18.01))
            bezierPath.addCurve(to: CGPoint(x: 14.5, y: 18.01), controlPoint1: CGPoint(x: 15.14, y: 18.01), controlPoint2: CGPoint(x: 14.5, y: 18.01))
            bezierPath.close()
            bezierPath.move(to: CGPoint(x: 15.7, y: 18.01))
            bezierPath.addCurve(to: CGPoint(x: 16.5, y: 18.01), controlPoint1: CGPoint(x: 16.12, y: 18.01), controlPoint2: CGPoint(x: 16.5, y: 18.01))
            bezierPath.addCurve(to: CGPoint(x: 15.7, y: 18.01), controlPoint1: CGPoint(x: 16.19, y: 18.01), controlPoint2: CGPoint(x: 15.92, y: 18.01))
            bezierPath.close()
            color2.setFill()
            bezierPath.fill()
            
            //// Bezier 2 Drawing
            let bezier2Path = UIBezierPath()
            bezier2Path.move(to: CGPoint(x: 25.5, y: 5.71))
            bezier2Path.addCurve(to: CGPoint(x: 24.5, y: 5.5), controlPoint1: CGPoint(x: 25.19, y: 5.57), controlPoint2: CGPoint(x: 24.86, y: 5.5))
            bezier2Path.addCurve(to: CGPoint(x: 23.5, y: 5.71), controlPoint1: CGPoint(x: 24.14, y: 5.5), controlPoint2: CGPoint(x: 23.81, y: 5.57))
            bezier2Path.addCurve(to: CGPoint(x: 23.5, y: 1.34), controlPoint1: CGPoint(x: 23.5, y: 4.49), controlPoint2: CGPoint(x: 23.5, y: 3.06))
            bezier2Path.addLine(to: CGPoint(x: 23.5, y: 1))
            bezier2Path.addLine(to: CGPoint(x: 25.5, y: 1))
            bezier2Path.addCurve(to: CGPoint(x: 25.5, y: 5.71), controlPoint1: CGPoint(x: 25.5, y: 2.87), controlPoint2: CGPoint(x: 25.5, y: 4.41))
            bezier2Path.close()
            bezier2Path.move(to: CGPoint(x: 25.5, y: 15.93))
            bezier2Path.addCurve(to: CGPoint(x: 25.5, y: 17.77), controlPoint1: CGPoint(x: 25.5, y: 17.25), controlPoint2: CGPoint(x: 25.5, y: 17.25))
            bezier2Path.addCurve(to: CGPoint(x: 25.5, y: 17.99), controlPoint1: CGPoint(x: 25.5, y: 17.93), controlPoint2: CGPoint(x: 25.5, y: 17.93))
            bezier2Path.addLine(to: CGPoint(x: 23.5, y: 18))
            bezier2Path.addCurve(to: CGPoint(x: 23.5, y: 17.77), controlPoint1: CGPoint(x: 23.5, y: 17.93), controlPoint2: CGPoint(x: 23.5, y: 17.93))
            bezier2Path.addCurve(to: CGPoint(x: 23.5, y: 15.93), controlPoint1: CGPoint(x: 23.5, y: 17.25), controlPoint2: CGPoint(x: 23.5, y: 17.25))
            bezier2Path.addCurve(to: CGPoint(x: 23.5, y: 10.29), controlPoint1: CGPoint(x: 23.5, y: 13.59), controlPoint2: CGPoint(x: 23.5, y: 12.54))
            bezier2Path.addCurve(to: CGPoint(x: 24.5, y: 10.5), controlPoint1: CGPoint(x: 23.81, y: 10.43), controlPoint2: CGPoint(x: 24.14, y: 10.5))
            bezier2Path.addCurve(to: CGPoint(x: 25.5, y: 10.29), controlPoint1: CGPoint(x: 24.86, y: 10.5), controlPoint2: CGPoint(x: 25.19, y: 10.43))
            bezier2Path.addCurve(to: CGPoint(x: 25.5, y: 15.93), controlPoint1: CGPoint(x: 25.5, y: 12.54), controlPoint2: CGPoint(x: 25.5, y: 13.59))
            bezier2Path.close()
            bezier2Path.move(to: CGPoint(x: 23.5, y: 18.01))
            bezier2Path.addCurve(to: CGPoint(x: 24.7, y: 18.01), controlPoint1: CGPoint(x: 23.5, y: 18.01), controlPoint2: CGPoint(x: 23.5, y: 18.01))
            bezier2Path.addCurve(to: CGPoint(x: 23.5, y: 18.01), controlPoint1: CGPoint(x: 24.14, y: 18.01), controlPoint2: CGPoint(x: 23.5, y: 18.01))
            bezier2Path.close()
            bezier2Path.move(to: CGPoint(x: 24.7, y: 18.01))
            bezier2Path.addCurve(to: CGPoint(x: 25.5, y: 18.01), controlPoint1: CGPoint(x: 25.12, y: 18.01), controlPoint2: CGPoint(x: 25.5, y: 18.01))
            bezier2Path.addCurve(to: CGPoint(x: 24.7, y: 18.01), controlPoint1: CGPoint(x: 25.19, y: 18.01), controlPoint2: CGPoint(x: 24.92, y: 18.01))
            bezier2Path.close()
            color2.setFill()
            bezier2Path.fill()
            
            //// Oval Drawing
            let ovalPath = UIBezierPath(ovalIn: CGRect(x: 5, y: 4.5, width: 3, height: 3))
            color2.setFill()
            ovalPath.fill()
            
            //// Oval 2 Drawing
            let oval2Path = UIBezierPath(ovalIn: CGRect(x: 14, y: 11.5, width: 3, height: 3))
            color2.setFill()
            oval2Path.fill()
            
            //// Oval 3 Drawing
            let oval3Path = UIBezierPath(ovalIn: CGRect(x: 23, y: 6.5, width: 3, height: 3))
            color2.setFill()
            oval3Path.fill()
        }
    }
    
    internal static var report: UIImage {
        return ImageRenderer(size: CGSize(width: 26, height: 22)).image { context in
            let frame = context.format.bounds
            //// Color Declarations
            let color3 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
            var color3HueComponent: CGFloat = 1
            var color3SaturationComponent: CGFloat = 1
            var color3BrightnessComponent: CGFloat = 1
            color3.getHue(&color3HueComponent, saturation: &color3SaturationComponent, brightness: &color3BrightnessComponent, alpha: nil)
            
            let color2 = UIColor(hue: color3HueComponent, saturation: color3SaturationComponent, brightness: 0.567, alpha: color3.cgColor.alpha)
            let color4 = UIColor(red: 0.527, green: 0.527, blue: 0.527, alpha: 1.000)
            
            //// Bezier Drawing
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: frame.minX + 4, y: frame.minY + 1))
            bezierPath.addLine(to: CGPoint(x: frame.minX + 4, y: frame.minY + 20))
            bezierPath.addLine(to: CGPoint(x: frame.minX + 9.4, y: frame.minY + 17))
            bezierPath.addLine(to: CGPoint(x: frame.minX + 13.9, y: frame.minY + 20))
            bezierPath.addLine(to: CGPoint(x: frame.minX + 17.5, y: frame.minY + 17))
            bezierPath.addLine(to: CGPoint(x: frame.minX + 22, y: frame.minY + 20))
            bezierPath.addLine(to: CGPoint(x: frame.minX + 22, y: frame.minY + 1))
            bezierPath.addLine(to: CGPoint(x: frame.minX + 4, y: frame.minY + 1))
            bezierPath.close()
            color2.setStroke()
            bezierPath.lineWidth = 1.5
            bezierPath.stroke()
            
                        //// Rectangle Drawing
            let rectanglePath = UIBezierPath(rect: CGRect(x: frame.minX + 7, y: frame.minY + 4, width: 10, height: 1.5))
            color4.setFill()
            rectanglePath.fill()
            
            //// Rectangle 2 Drawing
            let rectangle2Path = UIBezierPath(rect: CGRect(x: frame.minX + 7, y: frame.minY + 7, width: 10, height: 1.5))
            color4.setFill()
            rectangle2Path.fill()
            
            //// Rectangle 3 Drawing
            let rectangle3Path = UIBezierPath(rect: CGRect(x: frame.minX + 7, y: frame.minY + 10, width: 6, height: 1.5))
            color4.setFill()
            rectangle3Path.fill()
        }.withRenderingMode(.alwaysTemplate)
    }

}
