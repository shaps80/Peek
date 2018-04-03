/*
  Copyright © 03/10/2016 Snippex Ltd

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

import Foundation

/**
 *  Represents an image renderer format
 */
internal final class ImageRendererFormat: RendererFormat {

    /**
     Returns a default format, configured for this device. On OSX, this will flip the context to match iOS drawing.
     
     - returns: A new format
     */
    internal static func `default`() -> ImageRendererFormat {
        #if os(OSX)
            return ImageRendererFormat(flipped: true)
        #else
            return ImageRendererFormat(flipped: false)
        #endif
    }
    
    /// Returns the bounds for this format
    internal var bounds: CGRect
    
    /// Get/set whether or not the resulting image should be opaque
    internal var opaque: Bool
    
    /// Get/set the scale of the resulting image
    internal var scale: CGFloat
    
    /// Get/set whether or not the context should be flipped while drawing
    internal var isFlipped: Bool
    
    /**
     Creates a new format with the specified bounds
     
     - parameter bounds: The bounds of this format
     - parameter opaque: Whether or not the resulting image should be opaque
     - parameter scale:  The scale of the resulting image
     
     - returns: A new format
     */
    internal init(bounds: CGRect, opaque: Bool = false, scale: CGFloat = Screen.main.scale, flipped: Bool) {
        self.bounds = bounds
        self.opaque = opaque
        self.scale = scale
        self.isFlipped = flipped
    }
    
    internal init(opaque: Bool = false, scale: CGFloat = Screen.main.scale, flipped: Bool) {
        self.bounds = .zero
        self.scale = scale
        self.isFlipped = flipped
        self.opaque = opaque
    }
}

/**
 *  Represents a new renderer context
 */
internal final class ImageRendererContext: RendererContext {
    
    /// The associated format
    internal let format: ImageRendererFormat
    
    /// The associated CGContext
    internal let cgContext: CGContext
    
    /// Returns a UIImage representing the current state of the renderer's CGContext
    internal var currentImage: Image {
        #if os(OSX)
            let cgImage = CGContext.current!.makeImage()!
            return NSImage(cgImage: cgImage, size: format.bounds.size)
        #else
            return UIGraphicsGetImageFromCurrentImageContext()!
        #endif
    }
    
    /**
     Creates a new renderer context
     
     - parameter format:    The format for this context
     - parameter cgContext: The associated CGContext to use for all drawing
     
     - returns: A new renderer context
     */
    internal init(format: ImageRendererFormat, cgContext: CGContext) {
        self.format = format
        self.cgContext = cgContext
    }
    
}

extension ImageRenderer {
    internal convenience init(bounds: CGRect) {
        self.init(size: bounds.size, format: nil)
    }
}

/**
 *  Represents an image renderer used for drawing into a UIImage
 */
internal final class ImageRenderer: Renderer {
    
    /// The associated context type
    internal typealias Context = ImageRendererContext
    
    /// Returns true
    internal let allowsImageOutput: Bool = true
    
    /// Returns the format for this renderer
    internal let format: ImageRendererFormat
    
    /**
     Creates a new renderer with the specified size and format
     
     - parameter size:   The size of the resulting image
     - parameter format: The format, provides additional options for this renderer
     
     - returns: A new image renderer
     */
    internal init(size: CGSize, format: ImageRendererFormat? = nil) {
        guard size != .zero else { fatalError("size cannot be zero") }
        
        let bounds = CGRect(origin: .zero, size: size)
        let opaque = format?.opaque ?? false
        let scale = format?.scale ?? Screen.main.scale
        
        self.format = ImageRendererFormat(bounds: bounds, opaque: opaque, scale: scale, flipped: format?.isFlipped ?? false)
    }

    /**
     Returns a new image with the specified drawing actions applied
     
     - parameter actions: The drawing actions to apply
     
     - returns: A new image
     */
    internal func image(actions: (Context) -> Void) -> Image {
        var image: Image?
        
        try? runDrawingActions(actions) { context in
            image = context.currentImage
        }
        
        return image ?? UIImage()
    }
    
    /**
     Returns a PNG data representation of the resulting image
     
     - parameter actions: The drawing actions to apply
     
     - returns: A PNG data representation
     */
    internal func pngData(actions: (Context) -> Void) -> Data {
        let image = self.image(actions: actions)
        return image.pngRepresentation()!
    }
    
    /**
     Returns a JPEG data representation of the resulting image
     
     - parameter actions: The drawing actions to apply
     
     - returns: A JPEG data representation
     */
    internal func jpegData(withCompressionQuality compressionQuality: CGFloat, actions: (Context) -> Void) -> Data {
        let image = self.image(actions: actions)
        return image.jpgRepresentation(quality: compressionQuality)!
    }
    
    private func runDrawingActions(_ drawingActions: (Context) -> Void, completionActions: ((Context) -> Void)? = nil) throws {
        #if os(OSX)
            let bitmap = NSImage(size: format.bounds.size)
            bitmap.lockFocusFlipped(format.isFlipped)
            let cgContext = CGContext.current!
            let context = Context(format: format, cgContext: cgContext)
            drawingActions(context)
            completionActions?(context)
            bitmap.unlockFocus()
        #endif
        
        #if os(iOS)
            UIGraphicsBeginImageContextWithOptions(format.bounds.size, format.opaque, format.scale)
            guard let cgContext = CGContext.current else { return }
            
            if format.isFlipped {
                let transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: format.bounds.height)
                cgContext.concatenate(transform)
            }
            
            let context = Context(format: format, cgContext: cgContext)
            drawingActions(context)
            completionActions?(context)
            UIGraphicsEndImageContext()
        #endif
    }
}
