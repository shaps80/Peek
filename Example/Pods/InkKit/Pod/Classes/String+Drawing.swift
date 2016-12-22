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
      return NSAttributedString(string: self, attributes: attributes).boundingRectWithSize(size, options: .UsesLineFragmentOrigin, context: nil).size
    }
    
    return NSAttributedString(string: self, attributes: attributes).size()
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