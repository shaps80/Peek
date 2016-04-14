//
//  Images.swift
//  Peek
//
//  Created by Shaps Mohsenin on 26/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit
import InkKit

final class Images {
  
  static func tabItemIndicatorImage() -> UIImage {
    return Image.draw(width: 1, height: 49, attributes: nil, drawing: { (context, rect, attributes) in
      let height: CGFloat = 3
      let rect = CGRectMake(0, rect.maxY - height, 1, height);
      
      UIColor.secondaryColor().setFill()
      UIRectFill(rect)
    }).resizableImageWithCapInsets(UIEdgeInsetsZero, resizingMode: .Stretch)
  }
  
  static func backIndicatorImage() -> UIImage {
    return Image.draw(width: 12, height: 22, attributes: nil, drawing: { (context, rect, attributes) in
      let frame = rect.insetBy(dx: 1, dy: 1)
      let color = UIColor.whiteColor()
      
      let bezierPath = UIBezierPath()
      bezierPath.moveToPoint(CGPointMake(frame.maxX, frame.minY))
      bezierPath.addLineToPoint(CGPointMake(frame.maxX - 10, frame.midY))
      bezierPath.addLineToPoint(CGPointMake(frame.maxX, frame.maxY))
      
      color.setStroke()
      bezierPath.lineCapStyle = .Round
      bezierPath.lineJoinStyle = .Round
      bezierPath.lineWidth = 2
      bezierPath.stroke()
    })
  }
  
  static func viewImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(rect: CGRectMake(2, 0, 12, 9))
      UIColor.grayColor().setFill()
      rectanglePath.fill()
      
      
      //// Rectangle 2 Drawing
      let rectangle2Path = UIBezierPath(rect: CGRectMake(16, 0, 12, 9))
      UIColor.grayColor().setFill()
      rectangle2Path.fill()
      
      
      //// Rectangle 3 Drawing
      let rectangle3Path = UIBezierPath(rect: CGRectMake(2, 11, 12, 9))
      UIColor.grayColor().setFill()
      rectangle3Path.fill()
      
      
      //// Rectangle 4 Drawing
      let rectangle4Path = UIBezierPath(rect: CGRectMake(16, 11, 12, 9))
      UIColor.grayColor().setFill()
      rectangle4Path.fill()

    })
  }
  
  static func inspectorImage(inspector: Inspector) -> UIImage? {
    switch inspector {
    case .Attributes: return attributesImage()
    case .View: return viewImage()
    case .Layout: return layoutImage()
    case .Layer: return layerImage()
    case .Controller: return controllerImage()
    case .Device: return deviceImage()
    case .Screen: return screenImage()
    case .Application: return applicationImage()
    }
  }
  
  static func inspectorsToggleImage(inspectorSet: InspectorSet) -> UIImage {
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
      tab1Path.moveToPoint(CGPoint(x: 15, y: 15))
      tab1Path.addCurveToPoint(CGPoint(x: 15, y: 20.5), controlPoint1: CGPoint(x: 15, y: 15), controlPoint2: CGPoint(x: 15, y: 20.5))
      tab1Path.addLineToPoint(CGPoint(x: 6, y: 20.5))
      tab1Path.addLineToPoint(CGPoint(x: 6, y: 15))
      tab1Path.addLineToPoint(CGPoint(x: 15, y: 15))
      tab1Path.addLineToPoint(CGPoint(x: 15, y: 15))
      tab1Path.closePath()
      
      if inspectorSet == .Primary {
        white.setFill()
      } else {
        gray.setFill()
      }
      
      tab1Path.fill()
      
      
      //// tab2 Drawing
      let tab2Path = UIBezierPath()
      tab2Path.moveToPoint(CGPoint(x: 25.5, y: 15))
      tab2Path.addCurveToPoint(CGPoint(x: 25.5, y: 20.5), controlPoint1: CGPoint(x: 25.5, y: 15), controlPoint2: CGPoint(x: 25.5, y: 20.5))
      tab2Path.addLineToPoint(CGPoint(x: 16.5, y: 20.5))
      tab2Path.addLineToPoint(CGPoint(x: 16.5, y: 15))
      tab2Path.addLineToPoint(CGPoint(x: 25.5, y: 15))
      tab2Path.addLineToPoint(CGPoint(x: 25.5, y: 15))
      tab2Path.closePath()
      
      if inspectorSet == .Secondary {
        white.setFill()
      } else {
        gray.setFill()
      }
      
      tab2Path.fill()
    })
  }
  
  private static func applicationImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      //// Color Declarations
      let color = UIColor(red: 1.000, green: 0.973, blue: 0.973, alpha: 1.000)
      let color2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(roundedRect: CGRectMake(5.5, 0.5, 19, 19), cornerRadius: 2)
      color.setStroke()
      rectanglePath.lineWidth = 1
      rectanglePath.stroke()
      
      
      //// Bezier Drawing
      let bezierPath = UIBezierPath()
      bezierPath.moveToPoint(CGPointMake(7, 5.5))
      bezierPath.addLineToPoint(CGPointMake(16, 5.5))
      color2.setStroke()
      bezierPath.lineWidth = 1
      bezierPath.stroke()
      
      
      //// Bezier 2 Drawing
      let bezier2Path = UIBezierPath()
      bezier2Path.moveToPoint(CGPointMake(7, 8.5))
      bezier2Path.addLineToPoint(CGPointMake(19, 8.5))
      color2.setStroke()
      bezier2Path.lineWidth = 1
      bezier2Path.stroke()
      
      
      //// Bezier 3 Drawing
      let bezier3Path = UIBezierPath()
      bezier3Path.moveToPoint(CGPointMake(7, 11.5))
      bezier3Path.addLineToPoint(CGPointMake(11, 11.5))
      color2.setStroke()
      bezier3Path.lineWidth = 1
      bezier3Path.stroke()
      
      
      //// Bezier 4 Drawing
      let bezier4Path = UIBezierPath()
      bezier4Path.moveToPoint(CGPointMake(23.54, 0.55))
      bezier4Path.addCurveToPoint(CGPointMake(24.5, 1.69), controlPoint1: CGPointMake(24.22, 0.81), controlPoint2: CGPointMake(24.5, 1.22))
      bezier4Path.addCurveToPoint(CGPointMake(24.5, 3), controlPoint1: CGPointMake(24.5, 1.75), controlPoint2: CGPointMake(24.5, 3))
      bezier4Path.addLineToPoint(CGPointMake(5.5, 3))
      bezier4Path.addLineToPoint(CGPointMake(5.5, 1.75))
      bezier4Path.addCurveToPoint(CGPointMake(5.93, 0.78), controlPoint1: CGPointMake(5.5, 1.34), controlPoint2: CGPointMake(5.66, 1))
      bezier4Path.addCurveToPoint(CGPointMake(6.27, 0.59), controlPoint1: CGPointMake(6.03, 0.7), controlPoint2: CGPointMake(6.14, 0.64))
      bezier4Path.addCurveToPoint(CGPointMake(7.14, 0.5), controlPoint1: CGPointMake(6.51, 0.52), controlPoint2: CGPointMake(6.75, 0.5))
      bezier4Path.addCurveToPoint(CGPointMake(7.39, 0.5), controlPoint1: CGPointMake(7.22, 0.5), controlPoint2: CGPointMake(7.3, 0.5))
      bezier4Path.addLineToPoint(CGPointMake(21.44, 0.5))
      bezier4Path.addCurveToPoint(CGPointMake(23.59, 0.56), controlPoint1: CGPointMake(22.95, 0.5), controlPoint2: CGPointMake(23.35, 0.5))
      bezier4Path.addLineToPoint(CGPointMake(23.54, 0.55))
      bezier4Path.closePath()
      bezier4Path.moveToPoint(CGPointMake(12.75, 1))
      bezier4Path.addCurveToPoint(CGPointMake(12.05, 1.49), controlPoint1: CGPointMake(12.43, 1), controlPoint2: CGPointMake(12.15, 1.21))
      bezier4Path.addCurveToPoint(CGPointMake(12, 1.75), controlPoint1: CGPointMake(12.02, 1.57), controlPoint2: CGPointMake(12, 1.66))
      bezier4Path.addCurveToPoint(CGPointMake(12.75, 2.5), controlPoint1: CGPointMake(12, 2.16), controlPoint2: CGPointMake(12.34, 2.5))
      bezier4Path.addCurveToPoint(CGPointMake(13.5, 1.75), controlPoint1: CGPointMake(13.16, 2.5), controlPoint2: CGPointMake(13.5, 2.16))
      bezier4Path.addCurveToPoint(CGPointMake(12.75, 1), controlPoint1: CGPointMake(13.5, 1.34), controlPoint2: CGPointMake(13.16, 1))
      bezier4Path.closePath()
      bezier4Path.moveToPoint(CGPointMake(10.25, 1))
      bezier4Path.addCurveToPoint(CGPointMake(9.56, 1.45), controlPoint1: CGPointMake(9.94, 1), controlPoint2: CGPointMake(9.67, 1.19))
      bezier4Path.addCurveToPoint(CGPointMake(9.5, 1.75), controlPoint1: CGPointMake(9.52, 1.55), controlPoint2: CGPointMake(9.5, 1.65))
      bezier4Path.addCurveToPoint(CGPointMake(10.25, 2.5), controlPoint1: CGPointMake(9.5, 2.16), controlPoint2: CGPointMake(9.84, 2.5))
      bezier4Path.addCurveToPoint(CGPointMake(11, 1.75), controlPoint1: CGPointMake(10.66, 2.5), controlPoint2: CGPointMake(11, 2.16))
      bezier4Path.addCurveToPoint(CGPointMake(10.25, 1), controlPoint1: CGPointMake(11, 1.34), controlPoint2: CGPointMake(10.66, 1))
      bezier4Path.closePath()
      bezier4Path.moveToPoint(CGPointMake(7.75, 1))
      bezier4Path.addCurveToPoint(CGPointMake(7.09, 1.4), controlPoint1: CGPointMake(7.46, 1), controlPoint2: CGPointMake(7.22, 1.16))
      bezier4Path.addCurveToPoint(CGPointMake(7, 1.75), controlPoint1: CGPointMake(7.03, 1.5), controlPoint2: CGPointMake(7, 1.62))
      bezier4Path.addCurveToPoint(CGPointMake(7.75, 2.5), controlPoint1: CGPointMake(7, 2.16), controlPoint2: CGPointMake(7.34, 2.5))
      bezier4Path.addCurveToPoint(CGPointMake(8.5, 1.75), controlPoint1: CGPointMake(8.16, 2.5), controlPoint2: CGPointMake(8.5, 2.16))
      bezier4Path.addCurveToPoint(CGPointMake(7.75, 1), controlPoint1: CGPointMake(8.5, 1.34), controlPoint2: CGPointMake(8.16, 1))
      bezier4Path.closePath()
      UIColor.whiteColor().setFill()
      bezier4Path.fill()
    })
  }
  
  private static func screenImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(roundedRect: CGRectMake(4.5, 1, 22, 16.5), cornerRadius: 2)
      UIColor.whiteColor().setStroke()
      rectanglePath.lineWidth = 1
      rectanglePath.stroke()
      
      
      //// Rectangle 2 Drawing
      let rectangle2Path = UIBezierPath(roundedRect: CGRectMake(9.5, 19.5, 11.5, 1), cornerRadius: 0.5)
      UIColor.whiteColor().setStroke()
      rectangle2Path.lineWidth = 1
      rectangle2Path.stroke()
    })
  }
  
  private static func deviceImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      //// Color Declarations
      let color5 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(roundedRect: CGRectMake(9, 0.5, 12, 19), cornerRadius: 2)
      UIColor.whiteColor().setStroke()
      rectanglePath.lineWidth = 1
      rectanglePath.stroke()
      
      
      //// Bezier Drawing
      let bezierPath = UIBezierPath()
      bezierPath.moveToPoint(CGPointMake(20.5, 17))
      bezierPath.addCurveToPoint(CGPointMake(20.5, 19), controlPoint1: CGPointMake(20.5, 17), controlPoint2: CGPointMake(20.5, 19))
      bezierPath.addLineToPoint(CGPointMake(15, 19))
      bezierPath.addCurveToPoint(CGPointMake(15.5, 18.5), controlPoint1: CGPointMake(15.28, 19), controlPoint2: CGPointMake(15.5, 18.78))
      bezierPath.addCurveToPoint(CGPointMake(15.18, 18.03), controlPoint1: CGPointMake(15.5, 18.29), controlPoint2: CGPointMake(15.37, 18.11))
      bezierPath.addCurveToPoint(CGPointMake(15, 18), controlPoint1: CGPointMake(15.13, 18.01), controlPoint2: CGPointMake(15.06, 18))
      bezierPath.addCurveToPoint(CGPointMake(14.5, 18.5), controlPoint1: CGPointMake(14.72, 18), controlPoint2: CGPointMake(14.5, 18.22))
      bezierPath.addCurveToPoint(CGPointMake(15, 19), controlPoint1: CGPointMake(14.5, 18.78), controlPoint2: CGPointMake(14.72, 19))
      bezierPath.addLineToPoint(CGPointMake(9.5, 19))
      bezierPath.addLineToPoint(CGPointMake(9.5, 17))
      bezierPath.addLineToPoint(CGPointMake(20.5, 17))
      bezierPath.addLineToPoint(CGPointMake(20.5, 17))
      bezierPath.closePath()
      color5.setFill()
      bezierPath.fill()
    })
  }
  
  private static func controllerImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      //// Color Declarations
      let color = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
      let color2 = UIColor(red: 0.647, green: 0.647, blue: 0.647, alpha: 0.300)
      
      //// Rectangle Drawing
      let rectanglePath = UIBezierPath(roundedRect: CGRectMake(5, 1, 20, 20), cornerRadius: 2)
      color2.setFill()
      rectanglePath.fill()
      color.setStroke()
      rectanglePath.lineWidth = 1
      rectanglePath.stroke()
    })
  }
  
  private static func layerImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      
      //// Bezier 4 Drawing
      let bezier4Path = UIBezierPath()
      bezier4Path.moveToPoint(CGPointMake(23.43, 8.25))
      bezier4Path.addCurveToPoint(CGPointMake(27.5, 9.75), controlPoint1: CGPointMake(25.67, 9.08), controlPoint2: CGPointMake(27.5, 9.75))
      bezier4Path.addLineToPoint(CGPointMake(15.3, 15.75))
      bezier4Path.addLineToPoint(CGPointMake(2, 10.75))
      bezier4Path.addCurveToPoint(CGPointMake(6.43, 8.92), controlPoint1: CGPointMake(2, 10.75), controlPoint2: CGPointMake(3.99, 9.93))
      bezier4Path.addCurveToPoint(CGPointMake(15.3, 12.25), controlPoint1: CGPointMake(10.3, 10.37), controlPoint2: CGPointMake(15.3, 12.25))
      bezier4Path.addCurveToPoint(CGPointMake(23.43, 8.25), controlPoint1: CGPointMake(15.3, 12.25), controlPoint2: CGPointMake(19.89, 10))
      bezier4Path.closePath()
      bezier4Path.moveToPoint(CGPointMake(2, 5.5))
      bezier4Path.addLineToPoint(CGPointMake(15.3, 0))
      bezier4Path.addLineToPoint(CGPointMake(27.5, 4.5))
      bezier4Path.addLineToPoint(CGPointMake(15.3, 10.5))
      bezier4Path.addLineToPoint(CGPointMake(2, 5.5))
      bezier4Path.closePath()
      bezier4Path.moveToPoint(CGPointMake(23.43, 13.5))
      bezier4Path.addCurveToPoint(CGPointMake(27.5, 15), controlPoint1: CGPointMake(25.67, 14.33), controlPoint2: CGPointMake(27.5, 15))
      bezier4Path.addLineToPoint(CGPointMake(15.3, 21))
      bezier4Path.addLineToPoint(CGPointMake(2, 16))
      bezier4Path.addCurveToPoint(CGPointMake(6.43, 14.17), controlPoint1: CGPointMake(2, 16), controlPoint2: CGPointMake(3.99, 15.18))
      bezier4Path.addCurveToPoint(CGPointMake(15.3, 17.5), controlPoint1: CGPointMake(10.3, 15.62), controlPoint2: CGPointMake(15.3, 17.5))
      bezier4Path.addCurveToPoint(CGPointMake(23.43, 13.5), controlPoint1: CGPointMake(15.3, 17.5), controlPoint2: CGPointMake(19.89, 15.25))
      bezier4Path.closePath()
      UIColor.whiteColor().setFill()
      bezier4Path.fill()
    })
  }
  
  private static func layoutImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      //// General Declarations
      let context = UIGraphicsGetCurrentContext()
      
      //// Bezier Drawing
      CGContextSaveGState(context)
      CGContextTranslateCTM(context, 0, 13.56)
      CGContextRotateCTM(context, -25 * CGFloat(M_PI) / 180)
      
      let bezierPath = UIBezierPath()
      bezierPath.moveToPoint(CGPointMake(29, 0))
      bezierPath.addCurveToPoint(CGPointMake(29, 6), controlPoint1: CGPointMake(29, 0), controlPoint2: CGPointMake(29, 6))
      bezierPath.addLineToPoint(CGPointMake(0, 6))
      bezierPath.addLineToPoint(CGPointMake(0, 0))
      bezierPath.addLineToPoint(CGPointMake(2, 0))
      bezierPath.addLineToPoint(CGPointMake(2, 3))
      bezierPath.addLineToPoint(CGPointMake(3, 3))
      bezierPath.addLineToPoint(CGPointMake(3, 0))
      bezierPath.addLineToPoint(CGPointMake(6, 0))
      bezierPath.addLineToPoint(CGPointMake(6, 3))
      bezierPath.addLineToPoint(CGPointMake(7, 3))
      bezierPath.addLineToPoint(CGPointMake(7, 0))
      bezierPath.addLineToPoint(CGPointMake(10, 0))
      bezierPath.addLineToPoint(CGPointMake(10, 3))
      bezierPath.addLineToPoint(CGPointMake(11, 3))
      bezierPath.addLineToPoint(CGPointMake(11, 0))
      bezierPath.addLineToPoint(CGPointMake(14, 0))
      bezierPath.addLineToPoint(CGPointMake(14, 3))
      bezierPath.addLineToPoint(CGPointMake(15, 3))
      bezierPath.addLineToPoint(CGPointMake(15, 0))
      bezierPath.addLineToPoint(CGPointMake(18, 0))
      bezierPath.addLineToPoint(CGPointMake(18, 3))
      bezierPath.addLineToPoint(CGPointMake(19, 3))
      bezierPath.addLineToPoint(CGPointMake(19, 0))
      bezierPath.addLineToPoint(CGPointMake(22, 0))
      bezierPath.addLineToPoint(CGPointMake(22, 3))
      bezierPath.addLineToPoint(CGPointMake(23, 3))
      bezierPath.addLineToPoint(CGPointMake(23, 0))
      bezierPath.addLineToPoint(CGPointMake(26, 0))
      bezierPath.addLineToPoint(CGPointMake(26, 3))
      bezierPath.addLineToPoint(CGPointMake(27, 3))
      bezierPath.addLineToPoint(CGPointMake(27, 0))
      bezierPath.addLineToPoint(CGPointMake(29, 0))
      bezierPath.addLineToPoint(CGPointMake(29, 0))
      bezierPath.closePath()
      UIColor.grayColor().setFill()
      bezierPath.fill()
      
      CGContextRestoreGState(context)

    })
  }
  
  private static func attributesImage() -> UIImage {
    return Image.draw(width: 30, height: 25, attributes: nil, drawing: { (context, rect, attributes) in
      //// Color Declarations
      let color2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
      
      //// Bezier 4 Drawing
      let bezier4Path = UIBezierPath()
      bezier4Path.moveToPoint(CGPointMake(7.5, 3.71))
      bezier4Path.addCurveToPoint(CGPointMake(6.5, 3.5), controlPoint1: CGPointMake(7.19, 3.57), controlPoint2: CGPointMake(6.86, 3.5))
      bezier4Path.addCurveToPoint(CGPointMake(5.87, 3.58), controlPoint1: CGPointMake(6.28, 3.5), controlPoint2: CGPointMake(6.07, 3.53))
      bezier4Path.addCurveToPoint(CGPointMake(5.5, 3.71), controlPoint1: CGPointMake(5.74, 3.61), controlPoint2: CGPointMake(5.62, 3.66))
      bezier4Path.addCurveToPoint(CGPointMake(5.5, 1.07), controlPoint1: CGPointMake(5.5, 2.89), controlPoint2: CGPointMake(5.5, 2.01))
      bezier4Path.addLineToPoint(CGPointMake(5.5, 1))
      bezier4Path.addLineToPoint(CGPointMake(7.5, 1))
      bezier4Path.addCurveToPoint(CGPointMake(7.5, 3.71), controlPoint1: CGPointMake(7.5, 1.97), controlPoint2: CGPointMake(7.5, 2.87))
      bezier4Path.closePath()
      bezier4Path.moveToPoint(CGPointMake(7.5, 17.59))
      bezier4Path.addCurveToPoint(CGPointMake(7.5, 17.97), controlPoint1: CGPointMake(7.5, 17.87), controlPoint2: CGPointMake(7.5, 17.87))
      bezier4Path.addLineToPoint(CGPointMake(5.5, 18))
      bezier4Path.addCurveToPoint(CGPointMake(5.5, 17.59), controlPoint1: CGPointMake(5.5, 17.87), controlPoint2: CGPointMake(5.5, 17.87))
      bezier4Path.addCurveToPoint(CGPointMake(5.5, 8.29), controlPoint1: CGPointMake(5.5, 15.4), controlPoint2: CGPointMake(5.5, 14.92))
      bezier4Path.addCurveToPoint(CGPointMake(6.5, 8.5), controlPoint1: CGPointMake(5.81, 8.43), controlPoint2: CGPointMake(6.14, 8.5))
      bezier4Path.addCurveToPoint(CGPointMake(7.5, 8.29), controlPoint1: CGPointMake(6.86, 8.5), controlPoint2: CGPointMake(7.19, 8.43))
      bezier4Path.addCurveToPoint(CGPointMake(7.5, 17.59), controlPoint1: CGPointMake(7.5, 14.92), controlPoint2: CGPointMake(7.5, 15.4))
      bezier4Path.closePath()
      bezier4Path.moveToPoint(CGPointMake(5.5, 18.01))
      bezier4Path.addCurveToPoint(CGPointMake(7.5, 18.01), controlPoint1: CGPointMake(5.5, 18.01), controlPoint2: CGPointMake(5.5, 18.01))
      bezier4Path.addLineToPoint(CGPointMake(5.5, 18.01))
      bezier4Path.addLineToPoint(CGPointMake(5.5, 18.01))
      bezier4Path.closePath()
      color2.setFill()
      bezier4Path.fill()
      
      
      //// Bezier Drawing
      let bezierPath = UIBezierPath()
      bezierPath.moveToPoint(CGPointMake(16.5, 10.71))
      bezierPath.addCurveToPoint(CGPointMake(15.5, 10.5), controlPoint1: CGPointMake(16.19, 10.57), controlPoint2: CGPointMake(15.86, 10.5))
      bezierPath.addCurveToPoint(CGPointMake(15.01, 10.55), controlPoint1: CGPointMake(15.33, 10.5), controlPoint2: CGPointMake(15.17, 10.52))
      bezierPath.addCurveToPoint(CGPointMake(14.5, 10.71), controlPoint1: CGPointMake(14.83, 10.58), controlPoint2: CGPointMake(14.66, 10.64))
      bezierPath.addCurveToPoint(CGPointMake(14.5, 1.25), controlPoint1: CGPointMake(14.5, 8.88), controlPoint2: CGPointMake(14.5, 6.27))
      bezierPath.addLineToPoint(CGPointMake(14.5, 1))
      bezierPath.addLineToPoint(CGPointMake(16.5, 1))
      bezierPath.addCurveToPoint(CGPointMake(16.5, 10.71), controlPoint1: CGPointMake(16.5, 6.18), controlPoint2: CGPointMake(16.5, 8.85))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(15.5, 15.5))
      bezierPath.addCurveToPoint(CGPointMake(16.5, 15.29), controlPoint1: CGPointMake(15.86, 15.5), controlPoint2: CGPointMake(16.19, 15.43))
      bezierPath.addCurveToPoint(CGPointMake(16.5, 15.93), controlPoint1: CGPointMake(16.5, 15.49), controlPoint2: CGPointMake(16.5, 15.71))
      bezierPath.addCurveToPoint(CGPointMake(16.5, 17.77), controlPoint1: CGPointMake(16.5, 17.25), controlPoint2: CGPointMake(16.5, 17.25))
      bezierPath.addCurveToPoint(CGPointMake(16.5, 17.99), controlPoint1: CGPointMake(16.5, 17.93), controlPoint2: CGPointMake(16.5, 17.93))
      bezierPath.addLineToPoint(CGPointMake(14.5, 18))
      bezierPath.addCurveToPoint(CGPointMake(14.5, 17.77), controlPoint1: CGPointMake(14.5, 17.93), controlPoint2: CGPointMake(14.5, 17.93))
      bezierPath.addCurveToPoint(CGPointMake(14.5, 15.93), controlPoint1: CGPointMake(14.5, 17.25), controlPoint2: CGPointMake(14.5, 17.25))
      bezierPath.addCurveToPoint(CGPointMake(14.5, 15.29), controlPoint1: CGPointMake(14.5, 15.71), controlPoint2: CGPointMake(14.5, 15.49))
      bezierPath.addCurveToPoint(CGPointMake(15.5, 15.5), controlPoint1: CGPointMake(14.81, 15.43), controlPoint2: CGPointMake(15.14, 15.5))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(14.5, 18.01))
      bezierPath.addCurveToPoint(CGPointMake(15.7, 18.01), controlPoint1: CGPointMake(14.5, 18.01), controlPoint2: CGPointMake(14.5, 18.01))
      bezierPath.addCurveToPoint(CGPointMake(14.5, 18.01), controlPoint1: CGPointMake(15.14, 18.01), controlPoint2: CGPointMake(14.5, 18.01))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(15.7, 18.01))
      bezierPath.addCurveToPoint(CGPointMake(16.5, 18.01), controlPoint1: CGPointMake(16.12, 18.01), controlPoint2: CGPointMake(16.5, 18.01))
      bezierPath.addCurveToPoint(CGPointMake(15.7, 18.01), controlPoint1: CGPointMake(16.19, 18.01), controlPoint2: CGPointMake(15.92, 18.01))
      bezierPath.closePath()
      color2.setFill()
      bezierPath.fill()
      
      
      //// Bezier 2 Drawing
      let bezier2Path = UIBezierPath()
      bezier2Path.moveToPoint(CGPointMake(25.5, 5.71))
      bezier2Path.addCurveToPoint(CGPointMake(24.5, 5.5), controlPoint1: CGPointMake(25.19, 5.57), controlPoint2: CGPointMake(24.86, 5.5))
      bezier2Path.addCurveToPoint(CGPointMake(23.5, 5.71), controlPoint1: CGPointMake(24.14, 5.5), controlPoint2: CGPointMake(23.81, 5.57))
      bezier2Path.addCurveToPoint(CGPointMake(23.5, 1.34), controlPoint1: CGPointMake(23.5, 4.49), controlPoint2: CGPointMake(23.5, 3.06))
      bezier2Path.addLineToPoint(CGPointMake(23.5, 1))
      bezier2Path.addLineToPoint(CGPointMake(25.5, 1))
      bezier2Path.addCurveToPoint(CGPointMake(25.5, 5.71), controlPoint1: CGPointMake(25.5, 2.87), controlPoint2: CGPointMake(25.5, 4.41))
      bezier2Path.closePath()
      bezier2Path.moveToPoint(CGPointMake(25.5, 15.93))
      bezier2Path.addCurveToPoint(CGPointMake(25.5, 17.77), controlPoint1: CGPointMake(25.5, 17.25), controlPoint2: CGPointMake(25.5, 17.25))
      bezier2Path.addCurveToPoint(CGPointMake(25.5, 17.99), controlPoint1: CGPointMake(25.5, 17.93), controlPoint2: CGPointMake(25.5, 17.93))
      bezier2Path.addLineToPoint(CGPointMake(23.5, 18))
      bezier2Path.addCurveToPoint(CGPointMake(23.5, 17.77), controlPoint1: CGPointMake(23.5, 17.93), controlPoint2: CGPointMake(23.5, 17.93))
      bezier2Path.addCurveToPoint(CGPointMake(23.5, 15.93), controlPoint1: CGPointMake(23.5, 17.25), controlPoint2: CGPointMake(23.5, 17.25))
      bezier2Path.addCurveToPoint(CGPointMake(23.5, 10.29), controlPoint1: CGPointMake(23.5, 13.59), controlPoint2: CGPointMake(23.5, 12.54))
      bezier2Path.addCurveToPoint(CGPointMake(24.5, 10.5), controlPoint1: CGPointMake(23.81, 10.43), controlPoint2: CGPointMake(24.14, 10.5))
      bezier2Path.addCurveToPoint(CGPointMake(25.5, 10.29), controlPoint1: CGPointMake(24.86, 10.5), controlPoint2: CGPointMake(25.19, 10.43))
      bezier2Path.addCurveToPoint(CGPointMake(25.5, 15.93), controlPoint1: CGPointMake(25.5, 12.54), controlPoint2: CGPointMake(25.5, 13.59))
      bezier2Path.closePath()
      bezier2Path.moveToPoint(CGPointMake(23.5, 18.01))
      bezier2Path.addCurveToPoint(CGPointMake(24.7, 18.01), controlPoint1: CGPointMake(23.5, 18.01), controlPoint2: CGPointMake(23.5, 18.01))
      bezier2Path.addCurveToPoint(CGPointMake(23.5, 18.01), controlPoint1: CGPointMake(24.14, 18.01), controlPoint2: CGPointMake(23.5, 18.01))
      bezier2Path.closePath()
      bezier2Path.moveToPoint(CGPointMake(24.7, 18.01))
      bezier2Path.addCurveToPoint(CGPointMake(25.5, 18.01), controlPoint1: CGPointMake(25.12, 18.01), controlPoint2: CGPointMake(25.5, 18.01))
      bezier2Path.addCurveToPoint(CGPointMake(24.7, 18.01), controlPoint1: CGPointMake(25.19, 18.01), controlPoint2: CGPointMake(24.92, 18.01))
      bezier2Path.closePath()
      color2.setFill()
      bezier2Path.fill()
      
      
      //// Oval Drawing
      let ovalPath = UIBezierPath(ovalInRect: CGRectMake(5, 4.5, 3, 3))
      color2.setFill()
      ovalPath.fill()
      
      
      //// Oval 2 Drawing
      let oval2Path = UIBezierPath(ovalInRect: CGRectMake(14, 11.5, 3, 3))
      color2.setFill()
      oval2Path.fill()
      
      
      //// Oval 3 Drawing
      let oval3Path = UIBezierPath(ovalInRect: CGRectMake(23, 6.5, 3, 3))
      color2.setFill()
      oval3Path.fill()
    })
  }
  
}
