//
//  BezierPath+Corners.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 29/08/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

#if os(iOS)
  import UIKit
#else
  import AppKit
#endif

/**
 Defines available corner styles
 
 - none:    The corner will appear as a normal rect corner
 - convex:  The corner will appear externally rounded
 - concave: The corner will appear internally rounded
 - line:    The corner will appear with a flat line
 */
public enum RectCornerStyle {
  case none
  case convex(radius: CGFloat)
  case concave(radius: CGFloat)
  case line(radius: CGFloat)
}

/**
 *  Defines a struct for defining a paths corner styles
 */
public struct RectCorners {
  /// The corner style for the top left corner
  public var topLeft: RectCornerStyle
  /// The corner style for the top right corner
  public var topRight: RectCornerStyle
  /// The corner style for the bottom right corner
  public var bottomRight: RectCornerStyle
  /// The corner style for the bottom left corner
  public var bottomLeft: RectCornerStyle
}

extension RectCorners {
  
  /**
   Initializes and configures all corners with the same style
   
   - parameter all: The style to apply for all corners
   
   - returns: A new corners struct
   */
  public init(allCorners all: RectCornerStyle) {
    topLeft = all
    topRight = all
    bottomLeft = all
    bottomRight = all
  }
  
  /**
   Initializes and configures the top corners style. The bottom corners will have a style of .none
   
   - parameter top: The top corners style
   
   - returns: A new corners struct
   */
  public init(topCorners top: RectCornerStyle) {
    topLeft = top
    topRight = top
    bottomLeft = .none
    bottomRight = .none
  }
  
  /**
   Initializes and configures the bottom corners style. The top corners will have a style of .none
   
   - parameter bottom: The bottom corners style
   
   - returns: A new corners struct
   */
  public init(bottomCorners bottom: RectCornerStyle) {
    topLeft = .none
    topRight = .none
    bottomLeft = bottom
    bottomRight = bottom
  }
  
  /**
   Initializes and configures the left corners style. The right corners will have a style of .none
   
   - parameter left: The left corners style
   
   - returns: A new corners struct
   */
  public init(leftCorners left: RectCornerStyle) {
    topLeft = left
    bottomLeft = left
    topRight = .none
    bottomRight = .none
  }
  
  /**
   Initializes and configures the right corners style. The left corners will have a style of .none
   
   - parameter right: The right corners style
   
   - returns: A new corners struct
   */
  public init(rightCorners right: RectCornerStyle) {
    topLeft = .none
    bottomLeft = .none
    topRight = right
    bottomRight = right
  }
  
}

extension BezierPath {
  
  /**
   Initializes a new path with the specified corner styles
   
   - parameter rect:    The rect to use for this path
   - parameter corners: The corner styles to apply for this path
   
   - returns: A new path
   */
  public convenience init(rect: CGRect, corners: RectCorners) {
    self.init()
    addTopLeftCorner(rect: rect, style: corners.topLeft)
    addTopRightCorner(rect: rect, style: corners.topRight)
    addBottomRightCorner(rect: rect, style: corners.bottomRight)
    addBottomLeftCorner(rect: rect, style: corners.bottomLeft)
    close()
  }
  
  fileprivate func radiusForCornerStyle(style: RectCornerStyle) -> CGFloat {
    switch style {
    case .concave(let radius): return radius
    case .convex(let radius): return radius
    case .line(let radius): return radius
    case .none: return 0
    }
  }
  
  fileprivate func addTopLeftCorner(rect: CGRect, style: RectCornerStyle) {
    let radius = radiusForCornerStyle(style: style)
    let point1 = CGPoint(x: rect.minX, y: rect.minY + radius)
    move(to: point1)
    
    switch style {
    case .convex(let radius):
      addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.minY + radius), radius: radius, startAngle: CGFloat(Double.pi), endAngle: -CGFloat(Double.pi / 2), clockwise: true)
    case .concave(let radius):
      addArc(withCenter: CGPoint(x: rect.minX, y: rect.minY), radius: radius, startAngle: CGFloat(Double.pi / 2), endAngle: 0, clockwise: false)
    case .line(let radius):
      addLine(to: CGPoint(x: rect.minX + radius, y: rect.minY))
    case .none:
      addLine(to: CGPoint(x: rect.minX, y: rect.minY))
    }
  }
  
  fileprivate func addTopRightCorner(rect: CGRect, style: RectCornerStyle) {
    let radius = radiusForCornerStyle(style: style)
    let point1 = CGPoint(x: rect.maxX - radius, y: rect.minY)
    addLine(to: point1)
    
    switch style {
    case .convex(let radius):
      addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle: -CGFloat(Double.pi / 2), endAngle: 0, clockwise: true)
    case .concave(let radius):
      addArc(withCenter: CGPoint(x: rect.maxX, y: rect.minY), radius: radius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi / 2), clockwise: false)
    case .line(let radius):
      addLine(to: CGPoint(x: rect.maxX, y: rect.minY + radius))
    case .none:
      addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    }
  }
  
  fileprivate func addBottomRightCorner(rect: CGRect, style: RectCornerStyle) {
    let radius = radiusForCornerStyle(style: style)
    let point1 = CGPoint(x: rect.maxX, y: rect.maxY - radius)
    addLine(to: point1)
    
    switch style {
    case .convex(let radius):
      addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
    case .concave(let radius):
      addArc(withCenter: CGPoint(x: rect.maxX, y: rect.maxY), radius: radius, startAngle: CGFloat(Double.pi / 2) * 3, endAngle: CGFloat(Double.pi), clockwise: false)
    case .line(let radius):
      addLine(to: CGPoint(x: rect.maxX - radius, y: rect.maxY))
    case .none:
      addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    }
  }
  
  fileprivate func addBottomLeftCorner(rect: CGRect, style: RectCornerStyle) {
    let radius = radiusForCornerStyle(style: style)
    let point1 = CGPoint(x: rect.minX + radius, y: rect.maxY)
    addLine(to: point1)
    
    switch style {
    case .convex(let radius):
      addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: true)
    case .concave(let radius):
      addArc(withCenter: CGPoint(x: rect.minX, y: rect.maxY), radius: radius, startAngle: 0, endAngle: -CGFloat(Double.pi / 2), clockwise: false)
    case .line(let radius):
      addLine(to: CGPoint(x: rect.minX, y: rect.maxY - radius))
    case .none:
      addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    }
  }
  
}

#if os(OSX)
  
  extension BezierPath {
    
    open func addLine(to point: CGPoint) {
      line(to: point)
    }
    
    open func addCurve(to endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
      curve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }
    
    open func addArc(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
      appendArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }
    
  }
  
#endif

