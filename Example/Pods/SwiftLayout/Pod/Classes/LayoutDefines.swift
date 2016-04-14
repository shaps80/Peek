/*
  Copyright © 2015 Shaps Mohsenin. All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

  THIS SOFTWARE IS PROVIDED BY FRANCESCO PETRUNGARO `AS IS' AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
  EVENT SHALL FRANCESCO PETRUNGARO OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#if os(iOS)
  import UIKit
  public typealias View = UIView
#else
  import AppKit
  public typealias View = NSView
#endif

/**
Defines an axis used for horizontal and vertical based constraints

- Horizontal: Defines a horizontal axis
- Vertical:   Defines a vertical axis
*/
public enum Axis {
  case Horizontal
  case Vertical
}


/**
Defines an edge used for edge based constraints

- Top:    Defines a top edge
- Left:   Defines a left edge
- Bottom: Defines a bottom edge
- Right:  Defines a right edge
*/
public enum Edge {
  case Top
  case Left
  case Bottom
  case Right
}

/**
*  Defines edge (bitmask) options for use in edge based constraints
*/
public struct EdgeMask: OptionSetType {
  public let rawValue: Int
  public init(rawValue: Int) { self.rawValue = rawValue }
  
  /// Defines a top edge
  public static var Top: EdgeMask   { return EdgeMask(rawValue: 1 << 0) }
  
  /// Defines a left edge
  public static var Left: EdgeMask  { return EdgeMask(rawValue: 1 << 1) }
  
  /// Defines a bottom edge
  public static var Bottom: EdgeMask   { return EdgeMask(rawValue: 1 << 2) }
  
  /// Defines a right edge
  public static var Right: EdgeMask  { return EdgeMask(rawValue: 1 << 3) }
  
  /// Defines a top and left edge
  public static var TopLeft: EdgeMask { return [.Top, .Left] }
  
  /// Defines a top and right edge
  public static var TopRight: EdgeMask { return [.Top, .Right] }
  
  /// Defines a bottom and left edge
  public static var BottomLeft: EdgeMask { return [.Bottom, .Left] }
  
  /// Defines a bottom and right edge
  public static var BottomRight: EdgeMask { return [.Bottom, .Right] }
  
  /// Defines a left and right edge
  public static var LeftAndRight: EdgeMask  { return [.Left, .Right] }
  
  /// Defines a top and bottom edge
  public static var TopAndBottom: EdgeMask { return [.Top, .Bottom] }
  
  /// Defines all edges
  public static var All: EdgeMask { return [.Left, .Right, .Top, .Bottom] }
}

/**
*  Defines edge margins for use in edge based constraints
*/
public struct EdgeMargins {
  /// Defines a top edge marge
  public var top: CGFloat
  
  /// Defines a left edge margin
  public var left: CGFloat
  
  /// Defines a bottom edge margin
  public var bottom: CGFloat
  
  /// Defines a right edge margin
  public var right: CGFloat
  
  public init() {
    self.init(all: 0)
  }
  
  /**
  Initializes an instance with all edge margins defined with the same value
  
  - parameter all: The margin for each edge
  
  - returns: An EdgeMargins instance with its edges defined equally
  */
  public init(all: CGFloat) {
    self.init(top: all, left: all, bottom: all, right: all)
  }
  
  
  /**
  Initializes an instance with all edge margins defined
  
  - parameter top:    The top margin
  - parameter left:   The left margin
  - parameter bottom: The bottom margin
  - parameter right:  The right margin
  
  - returns: An EdgeMargins instance with its edges defined
  */
  public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
    self.top = top
    self.left = left
    self.bottom = bottom
    self.right = right
  }
}


/**
Converts an Axis to its associated sizing attribute

- parameter axis: The axis to convert

- returns: The associated NSLayoutAttribute
*/
public func sizeAttribute(axis: Axis) -> NSLayoutAttribute {
  switch axis {
  case .Horizontal:
    return .Width
  case .Vertical:
    return .Height
  }
}

/**
Converts an Axis to its associated alignment attribute

- parameter axis: The axis to convert

- returns: The associated NSLayoutAttribute
*/
public func centerAttribute(axis: Axis) -> NSLayoutAttribute {
  switch axis {
  case .Horizontal:
    return .CenterX
  case .Vertical:
    return .CenterY
  }
}

/**
Converts an Edge to its associated edge attribute

- parameter edge: The edge to convert

- returns: The associated NSLayoutAttribute
*/
public func edgeAttribute(edge: Edge) -> NSLayoutAttribute {
  switch edge {
  case .Top:
    return .Top
  case .Left:
    return .Left
  case .Bottom:
    return .Bottom
  case .Right:
    return .Right
  }
}



