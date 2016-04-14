//
//  String+Drawing.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 06/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

extension String {
  
  /**
   Draws the current string, aligned to the specified rect
   
   - parameter rect:            The rect to align to
   - parameter horizontal:      The horizontal alignment
   - parameter vertical:        The vertical alignment
   - parameter attributes:      The attributes to apply to this drawing
   - parameter constrainedSize: The constrained size, use this to get back a multi-line string
   */
  public func drawAlignedTo(rect: CGRect, horizontal: HorizontalAlignment = .Center, vertical: VerticalAlignment = .Middle, attributes: [String: AnyObject]?, constrainedSize: CGSize? = nil) {
    let size = sizeWithAttributes(attributes, constrainedSize: constrainedSize)
    let alignmentRect = CGRectMake(0, 0, size.width, size.height).alignedTo(rect, horizontal: horizontal, vertical: vertical)
    drawInRect(alignmentRect, withAttributes: attributes)
  }
  
  /**
   Returns the size of the current string
   
   - parameter attributes:      The attributes used to measure this string
   - parameter constrainedSize: The constrained size, use this to get back a multi-line string
   
   - returns: The size of this string
   */
  public func sizeWithAttributes(attributes: [String : AnyObject]?, constrainedSize: CGSize? = nil) -> CGSize {
    if let size = constrainedSize {
      return NSAttributedString(string: self, attributes: attributes).boundingRectWithSize(size, options: [.TruncatesLastVisibleLine, .UsesLineFragmentOrigin], context: nil).size
    }
    
    return (self as NSString).sizeWithAttributes(attributes) ?? CGSizeZero
  }
  
  /**
   Draws the current string at the specified point
   
   - parameter point:      The point representing the origin of this string
   - parameter attributes: The attributes for this string
   */
  public func drawAtPoint(point: CGPoint, withAttributes attributes: [String : AnyObject]?) {
    (self as NSString).drawAtPoint(point, withAttributes: attributes)
  }
  
  /**
   Draws the current string inside the specified rect
   
   - parameter rect:       The rect to draw into
   - parameter attributes: The attributes for this string
   */
  public func drawInRect(rect: CGRect, withAttributes attributes: [String : AnyObject]?) {
    (self as NSString).drawInRect(rect, withAttributes: attributes)
  }

}

