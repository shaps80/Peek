//
//  Types.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 06/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

#if os(OSX)
  
  import AppKit
  
  public typealias Color = NSColor
  public typealias Image = NSImage
  public typealias EdgeInsets = NSEdgeInsets
  public typealias BezierPath = NSBezierPath
  public typealias Screen = NSScreen
  public typealias Font = NSFont
  
  func UIGraphicsGetCurrentContext() -> CGContext? {
    return NSGraphicsContext.currentContext()!.CGContext
  }
  
#else
  
  import UIKit
  public typealias Color = UIColor
  public typealias Image = UIImage
  public typealias EdgeInsets = UIEdgeInsets
  public typealias BezierPath = UIBezierPath
  public typealias Screen = UIScreen
  public typealias Font = UIFont
  
#endif


/**
 Returns the radian angle value for the specified degrees
 
 - parameter degrees: The angle in degrees to convert
 
 - returns: The angle in radians
 */
public func radians(fromDegrees degrees: CGFloat) -> CGFloat {
  return degrees * CGFloat(M_PI) / 180
}

#if os(OSX)
  
  extension NSScreen {
    
    public var scale: CGFloat {
      return backingScaleFactor
    }
    
    public static func currentScreen() -> Screen {
      return NSScreen.mainScreen()!
    }
    
  }
  
#else
  
  extension UIScreen {
   
    public static func currentScreen() -> Screen {
      return UIScreen.mainScreen()
    }
    
  }
  
#endif


/// Defines a drawing block
public typealias DrawingBlock = (context: CGContext, rect: CGRect, attributes: DrawingAttributes) -> Void

/// Defines an attributes configuration block
public typealias AttributesBlock = (attributes: DrawingAttributes) -> Void

/**
 Defines content scaling
 
 - ScaleToFill:     Content is scaled to fill its container
 - ScaleAspectFit:  Content is scaled to fit its container, maintaining its current aspect ratio
 - ScaleAspectFill: Content is scaled to fill its container, maintaining its current aspect ratio
 - Center:          Content is centered inside its container, maintaining its current size and aspect ratio
 */
public enum ScaleMode: Int {
  
  case ScaleToFill
  case ScaleAspectFit
  case ScaleAspectFill
  case Center
  
}

/**
 Defines content vertical alignment
 
 - Middle: Content is aligned vertically centered
 - Top:    Content is aligned vertically to the top
 - Bottom: Content is aligned vertically to the bottom
 */
public enum VerticalAlignment : Int {
  
  case Middle
  case Top
  case Bottom
  
}

/**
 Defines content horizontal alignment
 
 - Center: Content is aligned horizontally centered
 - Left:   Content is aligned horizontally to the left
 - Right:  Content is aligned horizontally to the right
 */
public enum HorizontalAlignment : Int {
  
  case Center
  case Left
  case Right
  
}

/// Defines a set of drawing attributes to apply to a drawing operation
public final class DrawingAttributes {
 
  /// The stroke color
  public var strokeColor: Color?
  
  /// The fill color
  public var fillColor: Color?
  
  /// The line width (defaults to 1/scale)
  public var lineWidth: CGFloat = 1 / Screen.currentScreen().scale
  
  /// The line cap style (defaults to .Round)
  public var lineCap: CGLineCap = .Round
  
  /// The line join style (defaults to .Round)
  public var lineJoin: CGLineJoin = .Round
  
  /// The line dash pattern
  public var dashPattern: [CGFloat]? = nil
  
  public func apply(context: CGContext) {
    if let pattern = dashPattern {
      CGContextSetLineDash(context, 0, pattern, pattern.count)
    }
    
    if let fillColor = fillColor {
      fillColor.setFill()
    }
    
    if let strokeColor = strokeColor {
      strokeColor.setStroke()
    }
    
    CGContextSetLineCap(context, lineCap)
    CGContextSetLineJoin(context, lineJoin)
    CGContextSetLineWidth(context, lineWidth)
  }
  
  public func apply(path: BezierPath) {
    if let pattern = dashPattern {
      path.setLineDash(pattern, count: pattern.count, phase: 0)
    }
    
    if let fillColor = fillColor {
      fillColor.setFill()
    }
    
    if let strokeColor = strokeColor {
      strokeColor.setStroke()
    }
    
//    path.lineCapStyle = lineCap
//    path.lineJoinStyle = lineJoin
    path.lineWidth = lineWidth
  }
  
}

/// Defines a Draw class -- extensions are used to populate this class with static methods -- its provided purely for namespacing
public class Draw { }
