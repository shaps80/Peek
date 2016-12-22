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

#if os(OSX)
  
  import AppKit
  
  public typealias Color = NSColor
  public typealias Image = NSImage
  public typealias EdgeInsets = NSEdgeInsets
  public typealias BezierPath = NSBezierPath
  public typealias Screen = NSScreen
  public typealias Font = NSFont
  
  func GraphicsContext() -> CGContext? {
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
  
  func GraphicsContext() -> CGContext? {
    return UIGraphicsGetCurrentContext()
  }
  
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
  
  /// The line width -- defaults to 1
  public var lineWidth: CGFloat = 1
  
  /// The line cap style (defaults to .Round)
  public var lineCap: CGLineCap = .Round
  
  /// The line join style (defaults to .Round)
  public var lineJoin: CGLineJoin = .Round
  
  /// The line dash pattern
  public var dashPattern: [CGFloat]? = nil
  
  /**
   Applies the attributes to the specified CGContext
   
   - parameter context: The context to apply
   */
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
  
  /**
   Applies the attributes to the specified Bezier Path
   
   - parameter path: The path to apply
   */
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
    
    path.lineWidth = lineWidth
    
    #if os(iOS)
      path.lineCapStyle = lineCap
      path.lineJoinStyle = lineJoin
    #else
      path.lineCapStyle = NSLineCapStyle(rawValue: UInt(lineCap.rawValue))!
      path.lineJoinStyle = NSLineJoinStyle(rawValue: UInt(lineJoin.rawValue))!
    #endif
  }
  
}

/// Defines a Draw class -- extensions are used to populate this class with static methods -- its provided purely for namespacing
public class Draw { }

@available(*, unavailable, renamed="Grid")
public struct Table { }

@available(*, unavailable, renamed="GridComponents")
public struct TableComponents { }