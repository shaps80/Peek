//
//  Draw.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 06/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

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
    attributesBlock?(attributes: attributes)
    
    CGContextSaveGState(self)
    attributes.apply(self)
    drawingBlock(context: self, rect: rect, attributes: attributes)
    CGContextRestoreGState(self)
  }
  
}

