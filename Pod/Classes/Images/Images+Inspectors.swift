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

final class Images {
  
  static func tabItemIndicatorImage() -> UIImage {
    return Image.draw(width: 1, height: 49, attributes: nil, drawing: { (context, rect, attributes) in
      let height: CGFloat = 3
      let rect = CGRect(x: 0, y: rect.maxY - height, width: 1, height: height)
      
      UIColor.secondaryColor().setFill()
      UIRectFill(rect)
    }).resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
  }
  
  static func backIndicatorImage() -> UIImage {
    return Image.draw(width: 12, height: 22, attributes: nil, drawing: { (context, rect, attributes) in
      let frame = rect.insetBy(dx: 1, dy: 1)
      let color = UIColor.white
      
      let bezierPath = UIBezierPath()
      bezierPath.move(to: CGPoint(x: frame.maxX, y: frame.minY))
      bezierPath.addLine(to: CGPoint(x: frame.maxX - 10, y: frame.midY))
      bezierPath.addLine(to: CGPoint(x: frame.maxX, y: frame.maxY))
      
      color.setStroke()
      bezierPath.lineCapStyle = .round
      bezierPath.lineJoinStyle = .round
      bezierPath.lineWidth = 2
      bezierPath.stroke()
    })
  }
  
  static func viewImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(rect: CGRect(x: 2, y: 0, width: 12, height: 9))
      UIColor.gray.setFill()
      rectanglePath.fill()
      
      
      //// Rectangle 2 Drawing
      let rectangle2Path = UIBezierPath(rect: CGRect(x: 16, y: 0, width: 12, height: 9))
      UIColor.gray.setFill()
      rectangle2Path.fill()
      
      
      //// Rectangle 3 Drawing
      let rectangle3Path = UIBezierPath(rect: CGRect(x: 2, y: 11, width: 12, height: 9))
      UIColor.gray.setFill()
      rectangle3Path.fill()
      
      
      //// Rectangle 4 Drawing
      let rectangle4Path = UIBezierPath(rect: CGRect(x: 16, y: 11, width: 12, height: 9))
      UIColor.gray.setFill()
      rectangle4Path.fill()

    })
  }
  
  static func inspectorImage(_ inspector: Inspector) -> UIImage? {
    switch inspector {
    case .attributes: return attributesImage()
    case .view: return viewImage()
    case .layout: return layoutImage()
    case .layer: return layerImage()
    case .controller: return controllerImage()
    case .device: return deviceImage()
    case .screen: return screenImage()
    case .application: return applicationImage()
    }
  }
  
  static func inspectorsToggleImage(_ inspectorSet: InspectorSet) -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      //// Color Declarations
      let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
      let gray = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.500)
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 4, y: 1, width: 23.5, height: 21.5), cornerRadius: 2)
      white.setStroke()
      rectanglePath.lineWidth = 1
      rectanglePath.stroke()
      
      
      //// tab1 Drawing
      let tab1Path = UIBezierPath()
      tab1Path.move(to: CGPoint(x: 15, y: 15))
      tab1Path.addCurve(to: CGPoint(x: 15, y: 20.5), controlPoint1: CGPoint(x: 15, y: 15), controlPoint2: CGPoint(x: 15, y: 20.5))
      tab1Path.addLine(to: CGPoint(x: 6, y: 20.5))
      tab1Path.addLine(to: CGPoint(x: 6, y: 15))
      tab1Path.addLine(to: CGPoint(x: 15, y: 15))
      tab1Path.addLine(to: CGPoint(x: 15, y: 15))
      tab1Path.close()
      
      if inspectorSet == .primary {
        white.setFill()
      } else {
        gray.setFill()
      }
      
      tab1Path.fill()
      
      
      //// tab2 Drawing
      let tab2Path = UIBezierPath()
      tab2Path.move(to: CGPoint(x: 25.5, y: 15))
      tab2Path.addCurve(to: CGPoint(x: 25.5, y: 20.5), controlPoint1: CGPoint(x: 25.5, y: 15), controlPoint2: CGPoint(x: 25.5, y: 20.5))
      tab2Path.addLine(to: CGPoint(x: 16.5, y: 20.5))
      tab2Path.addLine(to: CGPoint(x: 16.5, y: 15))
      tab2Path.addLine(to: CGPoint(x: 25.5, y: 15))
      tab2Path.addLine(to: CGPoint(x: 25.5, y: 15))
      tab2Path.close()
      
      if inspectorSet == .secondary {
        white.setFill()
      } else {
        gray.setFill()
      }
      
      tab2Path.fill()
    })
  }
  
  fileprivate static func applicationImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      //// Color Declarations
      let color = UIColor(red: 1.000, green: 0.973, blue: 0.973, alpha: 1.000)
      let color2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 5.5, y: 0.5, width: 19, height: 19), cornerRadius: 2)
      color.setStroke()
      rectanglePath.lineWidth = 1
      rectanglePath.stroke()
      
      
      //// Bezier Drawing
      let bezierPath = UIBezierPath()
      bezierPath.move(to: CGPoint(x: 7, y: 5.5))
      bezierPath.addLine(to: CGPoint(x: 16, y: 5.5))
      color2.setStroke()
      bezierPath.lineWidth = 1
      bezierPath.stroke()
      
      
      //// Bezier 2 Drawing
      let bezier2Path = UIBezierPath()
      bezier2Path.move(to: CGPoint(x: 7, y: 8.5))
      bezier2Path.addLine(to: CGPoint(x: 19, y: 8.5))
      color2.setStroke()
      bezier2Path.lineWidth = 1
      bezier2Path.stroke()
      
      
      //// Bezier 3 Drawing
      let bezier3Path = UIBezierPath()
      bezier3Path.move(to: CGPoint(x: 7, y: 11.5))
      bezier3Path.addLine(to: CGPoint(x: 11, y: 11.5))
      color2.setStroke()
      bezier3Path.lineWidth = 1
      bezier3Path.stroke()
      
      
      //// Bezier 4 Drawing
      let bezier4Path = UIBezierPath()
      bezier4Path.move(to: CGPoint(x: 23.54, y: 0.55))
      bezier4Path.addCurve(to: CGPoint(x: 24.5, y: 1.69), controlPoint1: CGPoint(x: 24.22, y: 0.81), controlPoint2: CGPoint(x: 24.5, y: 1.22))
      bezier4Path.addCurve(to: CGPoint(x: 24.5, y: 3), controlPoint1: CGPoint(x: 24.5, y: 1.75), controlPoint2: CGPoint(x: 24.5, y: 3))
      bezier4Path.addLine(to: CGPoint(x: 5.5, y: 3))
      bezier4Path.addLine(to: CGPoint(x: 5.5, y: 1.75))
      bezier4Path.addCurve(to: CGPoint(x: 5.93, y: 0.78), controlPoint1: CGPoint(x: 5.5, y: 1.34), controlPoint2: CGPoint(x: 5.66, y: 1))
      bezier4Path.addCurve(to: CGPoint(x: 6.27, y: 0.59), controlPoint1: CGPoint(x: 6.03, y: 0.7), controlPoint2: CGPoint(x: 6.14, y: 0.64))
      bezier4Path.addCurve(to: CGPoint(x: 7.14, y: 0.5), controlPoint1: CGPoint(x: 6.51, y: 0.52), controlPoint2: CGPoint(x: 6.75, y: 0.5))
      bezier4Path.addCurve(to: CGPoint(x: 7.39, y: 0.5), controlPoint1: CGPoint(x: 7.22, y: 0.5), controlPoint2: CGPoint(x: 7.3, y: 0.5))
      bezier4Path.addLine(to: CGPoint(x: 21.44, y: 0.5))
      bezier4Path.addCurve(to: CGPoint(x: 23.59, y: 0.56), controlPoint1: CGPoint(x: 22.95, y: 0.5), controlPoint2: CGPoint(x: 23.35, y: 0.5))
      bezier4Path.addLine(to: CGPoint(x: 23.54, y: 0.55))
      bezier4Path.close()
      bezier4Path.move(to: CGPoint(x: 12.75, y: 1))
      bezier4Path.addCurve(to: CGPoint(x: 12.05, y: 1.49), controlPoint1: CGPoint(x: 12.43, y: 1), controlPoint2: CGPoint(x: 12.15, y: 1.21))
      bezier4Path.addCurve(to: CGPoint(x: 12, y: 1.75), controlPoint1: CGPoint(x: 12.02, y: 1.57), controlPoint2: CGPoint(x: 12, y: 1.66))
      bezier4Path.addCurve(to: CGPoint(x: 12.75, y: 2.5), controlPoint1: CGPoint(x: 12, y: 2.16), controlPoint2: CGPoint(x: 12.34, y: 2.5))
      bezier4Path.addCurve(to: CGPoint(x: 13.5, y: 1.75), controlPoint1: CGPoint(x: 13.16, y: 2.5), controlPoint2: CGPoint(x: 13.5, y: 2.16))
      bezier4Path.addCurve(to: CGPoint(x: 12.75, y: 1), controlPoint1: CGPoint(x: 13.5, y: 1.34), controlPoint2: CGPoint(x: 13.16, y: 1))
      bezier4Path.close()
      bezier4Path.move(to: CGPoint(x: 10.25, y: 1))
      bezier4Path.addCurve(to: CGPoint(x: 9.56, y: 1.45), controlPoint1: CGPoint(x: 9.94, y: 1), controlPoint2: CGPoint(x: 9.67, y: 1.19))
      bezier4Path.addCurve(to: CGPoint(x: 9.5, y: 1.75), controlPoint1: CGPoint(x: 9.52, y: 1.55), controlPoint2: CGPoint(x: 9.5, y: 1.65))
      bezier4Path.addCurve(to: CGPoint(x: 10.25, y: 2.5), controlPoint1: CGPoint(x: 9.5, y: 2.16), controlPoint2: CGPoint(x: 9.84, y: 2.5))
      bezier4Path.addCurve(to: CGPoint(x: 11, y: 1.75), controlPoint1: CGPoint(x: 10.66, y: 2.5), controlPoint2: CGPoint(x: 11, y: 2.16))
      bezier4Path.addCurve(to: CGPoint(x: 10.25, y: 1), controlPoint1: CGPoint(x: 11, y: 1.34), controlPoint2: CGPoint(x: 10.66, y: 1))
      bezier4Path.close()
      bezier4Path.move(to: CGPoint(x: 7.75, y: 1))
      bezier4Path.addCurve(to: CGPoint(x: 7.09, y: 1.4), controlPoint1: CGPoint(x: 7.46, y: 1), controlPoint2: CGPoint(x: 7.22, y: 1.16))
      bezier4Path.addCurve(to: CGPoint(x: 7, y: 1.75), controlPoint1: CGPoint(x: 7.03, y: 1.5), controlPoint2: CGPoint(x: 7, y: 1.62))
      bezier4Path.addCurve(to: CGPoint(x: 7.75, y: 2.5), controlPoint1: CGPoint(x: 7, y: 2.16), controlPoint2: CGPoint(x: 7.34, y: 2.5))
      bezier4Path.addCurve(to: CGPoint(x: 8.5, y: 1.75), controlPoint1: CGPoint(x: 8.16, y: 2.5), controlPoint2: CGPoint(x: 8.5, y: 2.16))
      bezier4Path.addCurve(to: CGPoint(x: 7.75, y: 1), controlPoint1: CGPoint(x: 8.5, y: 1.34), controlPoint2: CGPoint(x: 8.16, y: 1))
      bezier4Path.close()
      UIColor.white.setFill()
      bezier4Path.fill()
    })
  }
  
  fileprivate static func screenImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 4.5, y: 1, width: 22, height: 16.5), cornerRadius: 2)
      UIColor.white.setStroke()
      rectanglePath.lineWidth = 1
      rectanglePath.stroke()
      
      
      //// Rectangle 2 Drawing
      let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: 9.5, y: 19.5, width: 11.5, height: 1), cornerRadius: 0.5)
      UIColor.white.setStroke()
      rectangle2Path.lineWidth = 1
      rectangle2Path.stroke()
    })
  }
  
  fileprivate static func deviceImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      //// Color Declarations
      let color5 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 9, y: 0.5, width: 12, height: 19), cornerRadius: 2)
      UIColor.white.setStroke()
      rectanglePath.lineWidth = 1
      rectanglePath.stroke()
      
      
      //// Bezier Drawing
      let bezierPath = UIBezierPath()
      bezierPath.move(to: CGPoint(x: 20.5, y: 17))
      bezierPath.addCurve(to: CGPoint(x: 20.5, y: 19), controlPoint1: CGPoint(x: 20.5, y: 17), controlPoint2: CGPoint(x: 20.5, y: 19))
      bezierPath.addLine(to: CGPoint(x: 15, y: 19))
      bezierPath.addCurve(to: CGPoint(x: 15.5, y: 18.5), controlPoint1: CGPoint(x: 15.28, y: 19), controlPoint2: CGPoint(x: 15.5, y: 18.78))
      bezierPath.addCurve(to: CGPoint(x: 15.18, y: 18.03), controlPoint1: CGPoint(x: 15.5, y: 18.29), controlPoint2: CGPoint(x: 15.37, y: 18.11))
      bezierPath.addCurve(to: CGPoint(x: 15, y: 18), controlPoint1: CGPoint(x: 15.13, y: 18.01), controlPoint2: CGPoint(x: 15.06, y: 18))
      bezierPath.addCurve(to: CGPoint(x: 14.5, y: 18.5), controlPoint1: CGPoint(x: 14.72, y: 18), controlPoint2: CGPoint(x: 14.5, y: 18.22))
      bezierPath.addCurve(to: CGPoint(x: 15, y: 19), controlPoint1: CGPoint(x: 14.5, y: 18.78), controlPoint2: CGPoint(x: 14.72, y: 19))
      bezierPath.addLine(to: CGPoint(x: 9.5, y: 19))
      bezierPath.addLine(to: CGPoint(x: 9.5, y: 17))
      bezierPath.addLine(to: CGPoint(x: 20.5, y: 17))
      bezierPath.addLine(to: CGPoint(x: 20.5, y: 17))
      bezierPath.close()
      color5.setFill()
      bezierPath.fill()
    })
  }
  
  fileprivate static func controllerImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      //// Color Declarations
      let color = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
      let color2 = UIColor(red: 0.647, green: 0.647, blue: 0.647, alpha: 0.300)
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 5, y: 1, width: 20, height: 20), cornerRadius: 2)
      color2.setFill()
      rectanglePath.fill()
      color.setStroke()
      rectanglePath.lineWidth = 1
      rectanglePath.stroke()
    })
  }
  
  fileprivate static func layerImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      
      //// Bezier 4 Drawing
      let bezier4Path = UIBezierPath()
      bezier4Path.move(to: CGPoint(x: 23.43, y: 8.25))
      bezier4Path.addCurve(to: CGPoint(x: 27.5, y: 9.75), controlPoint1: CGPoint(x: 25.67, y: 9.08), controlPoint2: CGPoint(x: 27.5, y: 9.75))
      bezier4Path.addLine(to: CGPoint(x: 15.3, y: 15.75))
      bezier4Path.addLine(to: CGPoint(x: 2, y: 10.75))
      bezier4Path.addCurve(to: CGPoint(x: 6.43, y: 8.92), controlPoint1: CGPoint(x: 2, y: 10.75), controlPoint2: CGPoint(x: 3.99, y: 9.93))
      bezier4Path.addCurve(to: CGPoint(x: 15.3, y: 12.25), controlPoint1: CGPoint(x: 10.3, y: 10.37), controlPoint2: CGPoint(x: 15.3, y: 12.25))
      bezier4Path.addCurve(to: CGPoint(x: 23.43, y: 8.25), controlPoint1: CGPoint(x: 15.3, y: 12.25), controlPoint2: CGPoint(x: 19.89, y: 10))
      bezier4Path.close()
      bezier4Path.move(to: CGPoint(x: 2, y: 5.5))
      bezier4Path.addLine(to: CGPoint(x: 15.3, y: 0))
      bezier4Path.addLine(to: CGPoint(x: 27.5, y: 4.5))
      bezier4Path.addLine(to: CGPoint(x: 15.3, y: 10.5))
      bezier4Path.addLine(to: CGPoint(x: 2, y: 5.5))
      bezier4Path.close()
      bezier4Path.move(to: CGPoint(x: 23.43, y: 13.5))
      bezier4Path.addCurve(to: CGPoint(x: 27.5, y: 15), controlPoint1: CGPoint(x: 25.67, y: 14.33), controlPoint2: CGPoint(x: 27.5, y: 15))
      bezier4Path.addLine(to: CGPoint(x: 15.3, y: 21))
      bezier4Path.addLine(to: CGPoint(x: 2, y: 16))
      bezier4Path.addCurve(to: CGPoint(x: 6.43, y: 14.17), controlPoint1: CGPoint(x: 2, y: 16), controlPoint2: CGPoint(x: 3.99, y: 15.18))
      bezier4Path.addCurve(to: CGPoint(x: 15.3, y: 17.5), controlPoint1: CGPoint(x: 10.3, y: 15.62), controlPoint2: CGPoint(x: 15.3, y: 17.5))
      bezier4Path.addCurve(to: CGPoint(x: 23.43, y: 13.5), controlPoint1: CGPoint(x: 15.3, y: 17.5), controlPoint2: CGPoint(x: 19.89, y: 15.25))
      bezier4Path.close()
      UIColor.white.setFill()
      bezier4Path.fill()
    })
  }
  
  fileprivate static func layoutImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      //// General Declarations
      let context = UIGraphicsGetCurrentContext()
      
      //// Bezier Drawing
      context?.saveGState()
      context?.translateBy(x: 0, y: 13.56)
      context?.rotate(by: -25 * CGFloat.pi / 180)
      
      let bezierPath = UIBezierPath()
      bezierPath.move(to: CGPoint(x: 29, y: 0))
      bezierPath.addCurve(to: CGPoint(x: 29, y: 6), controlPoint1: CGPoint(x: 29, y: 0), controlPoint2: CGPoint(x: 29, y: 6))
      bezierPath.addLine(to: CGPoint(x: 0, y: 6))
      bezierPath.addLine(to: CGPoint(x: 0, y: 0))
      bezierPath.addLine(to: CGPoint(x: 2, y: 0))
      bezierPath.addLine(to: CGPoint(x: 2, y: 3))
      bezierPath.addLine(to: CGPoint(x: 3, y: 3))
      bezierPath.addLine(to: CGPoint(x: 3, y: 0))
      bezierPath.addLine(to: CGPoint(x: 6, y: 0))
      bezierPath.addLine(to: CGPoint(x: 6, y: 3))
      bezierPath.addLine(to: CGPoint(x: 7, y: 3))
      bezierPath.addLine(to: CGPoint(x: 7, y: 0))
      bezierPath.addLine(to: CGPoint(x: 10, y: 0))
      bezierPath.addLine(to: CGPoint(x: 10, y: 3))
      bezierPath.addLine(to: CGPoint(x: 11, y: 3))
      bezierPath.addLine(to: CGPoint(x: 11, y: 0))
      bezierPath.addLine(to: CGPoint(x: 14, y: 0))
      bezierPath.addLine(to: CGPoint(x: 14, y: 3))
      bezierPath.addLine(to: CGPoint(x: 15, y: 3))
      bezierPath.addLine(to: CGPoint(x: 15, y: 0))
      bezierPath.addLine(to: CGPoint(x: 18, y: 0))
      bezierPath.addLine(to: CGPoint(x: 18, y: 3))
      bezierPath.addLine(to: CGPoint(x: 19, y: 3))
      bezierPath.addLine(to: CGPoint(x: 19, y: 0))
      bezierPath.addLine(to: CGPoint(x: 22, y: 0))
      bezierPath.addLine(to: CGPoint(x: 22, y: 3))
      bezierPath.addLine(to: CGPoint(x: 23, y: 3))
      bezierPath.addLine(to: CGPoint(x: 23, y: 0))
      bezierPath.addLine(to: CGPoint(x: 26, y: 0))
      bezierPath.addLine(to: CGPoint(x: 26, y: 3))
      bezierPath.addLine(to: CGPoint(x: 27, y: 3))
      bezierPath.addLine(to: CGPoint(x: 27, y: 0))
      bezierPath.addLine(to: CGPoint(x: 29, y: 0))
      bezierPath.addLine(to: CGPoint(x: 29, y: 0))
      bezierPath.close()
      UIColor.gray.setFill()
      bezierPath.fill()
      
      context?.restoreGState()

    })
  }
  
  fileprivate static func attributesImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
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
    })
  }
  
}
