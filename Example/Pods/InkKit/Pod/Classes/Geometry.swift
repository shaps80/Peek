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

/**
 Returns a valid rect, given a start and end point. This rectangle can be considered reversible and is useful for dragging operations
 
 - parameter fromPoint: The from point
 - parameter toPoint:   The to point
 
 - returns: The resulting rect
 */
public func reversibleRect(fromPoint: CGPoint, toPoint: CGPoint) -> CGRect {
  var rect = CGRect.zero
  
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
  public func divided(atDelta delta: CGFloat, from edge: CGRectEdge, margin: CGFloat = 0) -> (slice: CGRect, remainder: CGRect) {
    let edges: [CGRectEdge] = [.minXEdge, .maxXEdge]
    let isHorizontal = edges.contains(edge)
    var (rect1, rect2): (CGRect, CGRect)
    
    if isHorizontal {
      (rect1, rect2) = divided(atDistance: width * delta, from: edge)
      rect1.size.width -= margin / 2
      rect2.size.width -= margin / 2
      rect2.origin.x += margin / 2
    } else {
      (rect1, rect2) = divided(atDistance: height * delta, from: edge)
      rect1.size.height -= margin / 2
      rect2.size.height -= margin / 2
      rect2.origin.y += margin / 2
    }
    
    return (rect1, rect2)
  }
  
  /**
   Insets the rect using the specified edge insets
   
   - parameter edgeInsets: The edge insets to use for determing each edge's inset
   
   - returns: The resulting rect
   */
  public func insetBy(insets: EdgeInsets) -> CGRect {
    var rect = self
    rect.insetInPlace(insets: insets)
    return rect
  }
  
  /**
   Insets this rect using the specified edge insets
   
   - parameter edgeInsets: The edge insets to use for determing each edge's inset
   */
  public mutating func insetInPlace(insets: EdgeInsets) {
    size.width -= (insets.right + insets.left)
    size.height -= (insets.bottom + insets.top)
    origin.x += insets.left
    origin.y += insets.top
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
    case .center:
      x = rect.minX - (self.width - rect.width) / 2
    case .left:
      x = rect.minX
    case .right:
      x = rect.maxX - self.width
    }
    
    switch vertical {
    case .middle:
      y = rect.minY - (self.height - rect.height) / 2
    case .top:
      y = rect.minY
    case .bottom:
      y = rect.maxY - self.height
    }
    
    return CGRect(x: x, y: y, width: self.width, height: self.height)
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
    case .scaleToFill:
      w = rect.width
      h = rect.height
    case .scaleAspectFit:
      let scaledSize = self.size.scaledTo(size: rect.size, scaleMode: mode)
      w = scaledSize.width
      h = scaledSize.height
    case .scaleAspectFill:
      let newSize = self.size.scaledTo(size: rect.size, scaleMode: mode)
      w = newSize.width
      h = newSize.height
    case .center:
      w = size.width
      h = size.height
      break
    }
    
    x = rect.minX - (w - rect.width) / 2
    y = rect.minY - (h - rect.width) / 2
    
    return CGRect(x: x, y: y, width: w, height: h)
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
    
    let center = CGPoint(x: width / 2, y: height / 2)
    let start = CGPoint(x: center.x - cos(degree) * width / 2, y: center.y - sin(degree) * height / 2)
    let end = CGPoint(x: center.x + cos(degree) * width / 2, y: center.y + sin(degree) * height / 2)
    
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
    case .scaleToFill:
      w = size.width
      h = size.height
    case .scaleAspectFit:
      let mW = size.width / self.width
      let mH = size.height / self.height
      
      if mH < mW {
        w = mH * self.width
        h = size.height
      } else {
        h = mW * self.height
        w = size.width
      }
    case .scaleAspectFill:
      let mW = size.width / self.width
      let mH = size.height / self.height
      
      if mH > mW {
        w = mH * self.width
        h = size.height
      } else {
        h = mW * self.height
        w = size.width
      }
    case .center:
      w = self.height
      h = self.width
    }
    
    return CGSize(width: w, height: h)
  }
  
}
