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

extension CGContext {
  
  /**
   Provides a convenience method for drawing into a context
   
   - parameter rect:            The rect to draw into
   - parameter attributesBlock: An optional attributes block for providing additional drawing options
   - parameter drawingBlock:    The drawing block to perform execute for performing all drawing operations
   */
  public func draw(inRect rect: CGRect, attributes attributesBlock: AttributesBlock?, drawing drawingBlock: DrawingBlock) {
    let attributes = DrawingAttributes()
    attributesBlock?(attributes)
    
    self.saveGState()
    attributes.apply(to: self)
    drawingBlock(self, rect, attributes)
    self.restoreGState()
  }
  
}
