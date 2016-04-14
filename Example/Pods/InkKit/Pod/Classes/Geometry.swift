//
//  Geometry.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 06/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

/**
 Returns a valid rect, given a start and end point. This rectangle can be considered reversible and is useful for dragging operations
 
 - parameter fromPoint: The from point
 - parameter toPoint:   The to point
 
 - returns: The resulting rect
 */
public func reversibleRect(fromPoint fromPoint: CGPoint, toPoint: CGPoint) -> CGRect {
  var rect = CGRectZero
  
  if fromPoint.x < toPoint.x {
    rect.origin.x = fromPoint.x
    rect.size.width = toPoint.x - fromPoint.x
  } else {
    rect.origin.x = toPoint.x
    rect.size.width = fromPoint.x - toPoint.x
  }
  
  if fromPoint.y < toPoint.y {
    rect.origin.y = fromPoint.y
    rect.size.height = toPoint.y - fromPoint.y
  } else {
    rect.origin.y = toPoint.y
    rect.size.height = fromPoint.y - toPoint.y
  }
  
  return rect
}

extension CGRect {
  
  /**
   Returns two rects, divided by a delta where 0 is the min value and 1 is the max value, from the specified edge
   
   - parameter delta:  The delta to split (e.g. 0.5 represents the center)
   - parameter edge:   The edge to calculate this delta from
   - parameter margin: A margin to add between each rect
   
   - returns: The resulting rects
   */
  public func divide(atDelta delta: CGFloat, fromEdge edge: CGRectEdge, margin: CGFloat = 0) -> (slice: CGRect, remainder: CGRect) {
    var (rect1, rect2) = divide(width * delta, fromEdge: edge)
    rect1.size.width -= margin / 2
    rect2.size.width -= margin / 2
    rect2.origin.x += margin / 2
    return (rect1, rect2)
  }
  
  /**
   Insets the rect using the specified edge insets
   
   - parameter edgeInsets: The edge insets to use for determing each edge's inset
   
   - returns: The resulting rect
   */
  public func insetBy(edgeInsets: EdgeInsets) -> CGRect {
    var rect = self
    rect.insetInPlace(edgeInsets)
    return rect
  }
  
  /**
   Insets this rect using the specified edge insets
   
   - parameter edgeInsets: The edge insets to use for determing each edge's inset
   */
  public mutating func insetInPlace(edgeInsets: EdgeInsets) {
    size.width -= (edgeInsets.right + edgeInsets.left)
    size.height -= (edgeInsets.bottom + edgeInsets.top)
    origin.x += edgeInsets.left
    origin.y += edgeInsets.top
  }
  
  /**
   Returns a new rect, aligned to the specified rect
   
   - parameter rect:       The rect to align to
   - parameter horizontal: The horizontal alignment
   - parameter vertical:   The vertical alignment
   
   - returns: The resulting rect
   */
  public func alignedTo(rect: CGRect, horizontal: HorizontalAlignment, vertical: VerticalAlignment) -> CGRect {
    var x: CGFloat, y: CGFloat
    
    switch horizontal {
    case .Center:
      x = rect.minX - (self.width - rect.width) / 2
    case .Left:
      x = rect.minX
    case .Right:
      x = rect.maxX - self.width
    }
    
    switch vertical {
    case .Middle:
      y = rect.minY - (self.height - rect.height) / 2
    case .Top:
      y = rect.minY
    case .Bottom:
      y = rect.maxY - self.height
    }
    
    return CGRectMake(x, y, self.width, self.height)
  }
  
  /**
   Returns a new rect, scaled to the specified rect
   
   - parameter rect: The rect to scale to
   - parameter mode: The scale mode
   
   - returns: The resulting rect
   */
  public func scaledTo(rect: CGRect, scaleMode mode: ScaleMode) -> CGRect {
    var x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat
    
    switch mode {
    case .ScaleToFill:
      w = rect.width
      h = rect.height
    case .ScaleAspectFit:
      let scaledSize = self.size.scaledTo(rect.size, scaleMode: mode)
      w = scaledSize.width
      h = scaledSize.height
    case .ScaleAspectFill:
      let newSize = self.size.scaledTo(rect.size, scaleMode: mode)
      w = newSize.width
      h = newSize.height
    case .Center:
      w = size.width
      h = size.height
      break
    }
    
    x = rect.minX - (w - rect.width) / 2
    y = rect.minY - (h - rect.width) / 2
    
    return CGRectMake(x, y, w, h)
  }
  
}

extension CGSize {
  
  /**
   Returns the start and end points for a gradient, using the specified angle
   
   - parameter angle: The angle (in degrees)
   
   - returns: The start and end points correlating to this angle
   */
  public func gradientPoints(forAngleInDegrees angle: CGFloat) -> (start: CGPoint, end: CGPoint) {
    let degree = radians(fromDegrees: angle)
    
    let center = CGPointMake(width / 2, height / 2)
    let start = CGPointMake(center.x - cos(degree) * width / 2, center.y - sin(degree) * height / 2)
    let end = CGPointMake(center.x + cos(degree) * width / 2, center.y + sin(degree) * height / 2)
    
    return (start, end)
  }
  
  /**
   Returns a new size, scaled to the specified size using the given scale mode
   
   - parameter size: The size to scale to
   - parameter mode: The scale mode
   
   - returns: The resulting size
   */
  public func scaledTo(size: CGSize, scaleMode mode: ScaleMode) -> CGSize {
    var w: CGFloat, h: CGFloat
    
    switch mode {
    case .ScaleToFill:
      w = size.width
      h = size.height
    case .ScaleAspectFit:
      let mW = size.width / self.width
      let mH = size.height / self.height
      
      if mH < mW {
        w = mH * self.width
        h = size.height
      } else {
        h = mW * self.height
        w = size.width
      }
    case .ScaleAspectFill:
      let mW = size.width / self.width
      let mH = size.height / self.height
      
      if mH > mW {
        w = mH * self.width
        h = size.height
      } else {
        h = mW * self.height
        w = size.width
      }
    case .Center:
      w = self.height
      h = self.width
    }
    
    return CGSizeMake(w, h)
  }
  
}


