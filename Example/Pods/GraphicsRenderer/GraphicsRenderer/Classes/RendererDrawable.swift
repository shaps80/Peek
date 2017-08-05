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

extension RendererDrawable {
    
    /// Fills the specified rect
    ///
    /// - Parameter rect: The rect to fill
    public func fill(_ rect: CGRect) {
        fill(rect, blendMode: .normal)
    }
    
    /// Fills the specified rect with the given blend mode
    ///
    /// - Parameters:
    ///   - rect: The rect to fill
    ///   - blendMode: The blend mode to apply to this fill
    public func fill(_ rect: CGRect, blendMode: CGBlendMode) {
        cgContext.saveGState()
        cgContext.setBlendMode(blendMode)
        cgContext.fill(rect)
        cgContext.restoreGState()
    }
    
    /// Strokes the specified rect
    ///
    /// - Parameter rect: The rect to stroke
    public func stroke(_ rect: CGRect) {
        stroke(rect, blendMode: .normal)
    }
    
    /// Strokes the specified rect with the given blend mode
    ///
    /// - Parameters:
    ///   - rect: The rect to stroke
    ///   - blendMode: The blend more to apply to this stroke
    public func stroke(_ rect: CGRect, blendMode: CGBlendMode) {
        cgContext.saveGState()
        cgContext.setBlendMode(blendMode)
        cgContext.stroke(rect.insetBy(dx: 0.5, dy: 0.5))
        cgContext.restoreGState()
    }
    
    /// Clips the context to the specified rect
    ///
    /// - Parameter rect: The rect to clip to
    public func clip(to rect: CGRect) {
        cgContext.saveGState()
        cgContext.clip(to: rect)
        cgContext.restoreGState()
    }
}