//
//  Image+Drawing.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 06/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

extension Image {
  
  /**
   Returns an image representing a cirle. To modify its color, stroke, etc... use the attributesBlock
   
   - parameter radius:          The radius of the cirle to draw
   - parameter attributesBlock: The attributes configuration block
   
   - returns: An image of a circle
   */
  public static func circle(radius radius: CGFloat, attributes attributesBlock: AttributesBlock) -> Image {
    return Image.draw(width: radius * 2, height: radius * 2, attributes: attributesBlock, drawing: { (context, rect, attributes) in
      let path = BezierPath(ovalInRect: rect.insetBy(dx: 1, dy: 1))
      attributes.apply(path)
      path.fill()
      path.stroke()
    })
  }
  
  /**
   Draws the current image, aligned to the specified rect
   
   - parameter rect:       The rect to align to
   - parameter horizontal: The horizontal alignment
   - parameter vertical:   The vertical alignment
   - parameter blendMode:  The blend mode to apply to this drawing
   - parameter alpha:      The alpha to apply to this drawing
   */
  public func drawAlignedTo(rect: CGRect, horizontal: HorizontalAlignment = .Center, vertical: VerticalAlignment = .Middle, blendMode: CGBlendMode = .Normal, alpha: CGFloat = 1) {
    let alignedRect = CGRectMake(0, 0, size.width, size.height).alignedTo(rect, horizontal: horizontal, vertical: vertical)
    ink_drawInRect(alignedRect, blendMode: blendMode, alpha: alpha)
  }
  
  /**
   Draws the current image, scaled to the specified rect
   
   - parameter rect:      The rect to scale to
   - parameter mode:      The scale mode to use
   - parameter blendMode: The blend mode to apply to this drawing
   - parameter alpha:     The alpha to apply to this drawing
   */
  public func drawScaledTo(rect: CGRect, scaleMode mode: ScaleMode, blendMode: CGBlendMode = .Normal, alpha: CGFloat = 1) {
    let scaledRect = CGRectMake(0, 0, size.width, size.height).scaledTo(rect, scaleMode: mode)
    ink_drawInRect(scaledRect, blendMode: blendMode, alpha: alpha)
  }
  
  private func ink_drawInRect(rect: CGRect, blendMode mode: CGBlendMode, alpha: CGFloat) {
    #if os(iOS)
      drawInRect(rect, blendMode: mode, alpha: alpha)
    #else
      drawInRect(rect, fromRect: rect, operation: NSCompositingOperation(rawValue: UInt(mode.rawValue))!, fraction: alpha)
    #endif
  }
  
}

extension Image {
  
  /**
   Returns an image using the drawingBlock provided
   
   - parameter width:   The width of the image to return
   - parameter height:  The height of the image to return
   - parameter scale:   The scale of the image to return
   - parameter attributesBlock: The attributes configuration block
   - parameter drawing: The drawing operations to perform on this image
   
   - returns: A new image
   */
  public static func draw(width width: CGFloat, height: CGFloat, scale: CGFloat = Screen.currentScreen().scale, attributes attributesBlock: AttributesBlock?, drawing: DrawingBlock) -> Image {
    return draw(size: CGSizeMake(width, height), attributes: attributesBlock, drawing: drawing)
  }
  
  /**
   Returns an image using the drawingBlock provided
   
   - parameter size:    The size of the image to return
   - parameter scale:   The scale of the image to return
   - parameter attributesBlock: The attributes configuration block
   - parameter drawing: The drawing operations to perform on this image
   
   - returns: A new image
   */
  public static func draw(size size: CGSize, scale: CGFloat = Screen.currentScreen().scale, attributes attributesBlock: AttributesBlock?, drawing: DrawingBlock) -> Image {
    let rect = CGRectMake(0, 0, size.width, size.height)
    
    #if os(OSX)
      let image = Image(size: size)
      image.lockFocus()
      UIGraphicsGetCurrentContext()?.draw(inRect: rect, attributes: attributesBlock, drawing: drawing)
      image.unlockFocus()
      return image
    #else
      UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), false, scale)
      UIGraphicsGetCurrentContext()?.draw(inRect: rect, attributes: attributesBlock, drawing: drawing)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return image
    #endif
  }
  
}
