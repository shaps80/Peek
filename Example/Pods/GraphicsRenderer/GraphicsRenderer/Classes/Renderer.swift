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
 Represents a Renderer error
 
 - missingContext:     The context could not be found or created
 */
public enum RendererError: Error {
    case missingContext
    case invalidURL
}

/**
 *  Defines a renderer format
 */
public protocol RendererFormat: class {
    
    /**
     Returns a default instance, configured for the current device
     
     - returns: A new renderer format
     */
    static func `default`() -> Self
    
    /// Returns the drawable bounds
    var bounds: CGRect { get }
    
}


/**
 *  Represents a drawable -- used to add drawing support to CGContext, RendererContext and UIGraphicsImageRendererContext
 */
public protocol RendererDrawable {
    
    var cgContext: CGContext { get }
    func fill(_ rect: CGRect)
    func fill(_ rect: CGRect, blendMode: CGBlendMode)
    func stroke(_ rect: CGRect)
    func stroke(_ rect: CGRect, blendMode: CGBlendMode)
    func clip(to rect: CGRect)
}


/**
 *  Represents a renderer context, which provides additional drawing methods as well as access to the underlying CGContext
 */
public protocol RendererContext: class, RendererDrawable {
    associatedtype Format: RendererFormat
    var format: Format { get }
}

extension CGContext: RendererDrawable {
    public var cgContext: CGContext {
        return self
    }
}

#if os(iOS) || os(tvOS)
@available(iOS 10.0, *)
extension UIGraphicsImageRendererContext: RendererDrawable { }
#endif


/**
 *  Represents a renderer
 */
public protocol Renderer: class {
    
    /// The associated context type this renderer will use
    associatedtype Context: RendererContext
    
    /// Returns the format associated with this renderer
    var format: Context.Format { get }
    
    /// Returns true if this renderer may be used to generate CGImageRefs
    var allowsImageOutput: Bool { get }
    
    init(bounds: CGRect)
}

extension Renderer {
    
    /// Default implementation returns false
    public var allowsImageOutput: Bool {
        return false
    }
    
    /**
     Default implementation returns false
     */
    public static func context(with format: RendererFormat) -> CGContext? {
        return nil
    }
    
}
