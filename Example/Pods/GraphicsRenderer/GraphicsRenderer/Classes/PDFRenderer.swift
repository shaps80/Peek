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

/**
 *  Represents a PDF renderer format
 */
public final class PDFRendererFormat: RendererFormat {
    
    /**
     Returns a default format, configured for this device
     
     - returns: A new format
     */
    public static func `default`() -> PDFRendererFormat {
        let bounds = CGRect(x: 0, y: 0, width: 612, height: 792)
        return PDFRendererFormat(bounds: bounds, documentInfo: [:], flipped: false)
    }
    
    /// Returns the bounds for this format
    public let bounds: CGRect
    
    /// Returns the associated document info
    public var documentInfo: [String: Any]
    
    public var isFlipped: Bool
    
    /**
     Creates a new format with the specified bounds and pageInfo
     
     - parameter bounds:       The bounds for each page in the PDF
     - parameter documentInfo: The info associated with this PDF
     
     - returns: A new PDF renderer format
     */
    internal init(bounds: CGRect, documentInfo: [String: Any], flipped: Bool) {
        self.bounds = bounds
        self.documentInfo = documentInfo
        self.isFlipped = flipped
    }
    
    /// Creates a new format with the specified document info and whether or not the context should be flipped
    ///
    /// - Parameters:
    ///   - documentInfo: The associated PSD document info
    ///   - flipped: If true, the context drawing will be flipped
    public init(documentInfo: [String: Any], flipped: Bool) {
        self.bounds = .zero
        self.documentInfo = documentInfo
        self.isFlipped = flipped
    }
    
}


/// Represents a PDF renderer context
public final class PDFRendererContext: RendererContext {
    
    /// The underlying CGContext
    public let cgContext: CGContext
    
    /// The format for this context
    public let format: PDFRendererFormat
    
    /// The PDF context bounds
    public let pdfContextBounds: CGRect
    
    // Internal variable for auto-closing pages
    private var hasOpenPage: Bool = false
    
    /// Creates a new context. If an existing page is open, this will also close it for you.
    ///
    /// - Parameters:
    ///   - format: The format for this context
    ///   - cgContext: The underlying CGContext to associate with this context
    ///   - bounds: The bounds to use for this context
    internal init(format: PDFRendererFormat, cgContext: CGContext, bounds: CGRect) {
        self.format = format
        self.cgContext = cgContext
        self.pdfContextBounds = bounds
    }
    
    /// Creates a new PDF page. The bounds will be the same as specified by the document
    public func beginPage() {
        beginPage(withBounds: format.bounds, pageInfo: [:])
    }
    
    /// Creates a new PDF page. If an existing page is open, this will also close it for you.
    ///
    /// - Parameters:
    ///   - bounds: The bounds to use for this page
    ///   - pageInfo: The pageInfo associated to be associated with this page
    public func beginPage(withBounds bounds: CGRect, pageInfo: [String : Any]) {
        var info = pageInfo
        info[kCGPDFContextMediaBox as String] = bounds
        
        let pageInfo = info as CFDictionary
        
        endPageIfOpen()
        cgContext.beginPDFPage(pageInfo)
        hasOpenPage = true
        
        if format.isFlipped {
            let transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: format.bounds.height)
            cgContext.concatenate(transform)
        }
    }
    
    /// Set the URL associated with `rect' to `url' in the PDF context `context'.
    ///
    /// - Parameters:
    ///   - url: The url to link to
    ///   - rect: The rect representing the link
    public func setURL(_ url: URL, for rect: CGRect) {
        let url = url as CFURL
        cgContext.setURL(url, for: rect)
    }
    
    /// Create a PDF destination named `name' at `point' in the current page of the PDF context `context'.
    ///
    /// - Parameters:
    ///   - name: A destination name
    ///   - point: A location in the current page
    public func addDestination(withName name: String, at point: CGPoint) {
        let name = name as CFString
        cgContext.addDestination(name, at: point)
    }
    
    /// Specify a destination named `name' to jump to when clicking in `rect' of the current page of the PDF context `context'.
    ///
    /// - Parameters:
    ///   - name: A destination name
    ///   - rect: A rect in the current page
    public func setDestinationWithName(_ name: String, for rect: CGRect) {
        let name = name as CFString
        cgContext.setDestination(name, for: rect)
    }
    
    // If a page is currently opened, this will close it. Otherwise it does nothing
    fileprivate func endPageIfOpen() {
        guard hasOpenPage else { return }
        cgContext.endPDFPage()
    }
}

extension PDFRenderer {
    public convenience init(bounds: CGRect) {
        self.init(bounds: bounds, format: nil)
    }
}

/// Represents a PDF renderer
public final class PDFRenderer: Renderer {
    
    /// The associated context type
    public typealias Context = PDFRendererContext
    
    /// Returns the format for this renderer
    public let format: PDFRendererFormat
    
    /// Creates a new PDF renderer with the specified bounds
    ///
    /// - Parameters:
    ///   - bounds: The bounds of the PDF
    ///   - format: The format to use for this PDF
    public init(bounds: CGRect, format: PDFRendererFormat? = nil) {
        guard bounds.size != .zero else { fatalError("size cannot be zero") }
        
        let info = format?.documentInfo ?? [:]
        self.format = PDFRendererFormat(bounds: bounds, documentInfo: info, flipped: format?.isFlipped ?? true)
    }
    
    /// Draws the PDF and writes is to the specified URL
    ///
    /// - Parameters:
    ///   - url: The url to write tp
    ///   - actions: The drawing actions to perform
    /// - Throws: May throw
    public func writePDF(to url: URL, withActions actions: (PDFRendererContext) -> Void) throws {
        var rect = format.bounds
        let consumer = CGDataConsumer(url: url as CFURL)!
        let context = CGContext(consumer: consumer, mediaBox: &rect, format.documentInfo as CFDictionary?)!
        try? runDrawingActions(forContext: context, drawingActions: actions, completionActions: nil)
    }
    
    /// Draws the PDF and returns the associated Data representation
    ///
    /// - Parameter actions: The drawing actions to perform
    /// - Returns: The PDF data
    public func pdfData(actions: (PDFRendererContext) -> Void) -> Data {
        var rect = format.bounds
        let data = NSMutableData()
        let consumer = CGDataConsumer(data: data)!
        let context = CGContext(consumer: consumer, mediaBox: &rect, format.documentInfo as CFDictionary?)!
        try? runDrawingActions(forContext: context, drawingActions: actions, completionActions: nil)
        return data as Data
    }
    
    private func runDrawingActions(forContext cgContext: CGContext, drawingActions: (Context) -> Void, completionActions: ((Context) -> Void)? = nil) throws {
        let context = PDFRendererContext(format: format, cgContext: cgContext, bounds: format.bounds)
        
        #if os(OSX)
            let previousContext = NSGraphicsContext.current()
            NSGraphicsContext.setCurrent(NSGraphicsContext(cgContext: context.cgContext, flipped: format.isFlipped))
        #else
            UIGraphicsPushContext(context.cgContext)
        #endif
        
        drawingActions(context)
        completionActions?(context)
        
        context.endPageIfOpen()
        context.cgContext.closePDF()
        
        #if os(OSX)
            NSGraphicsContext.setCurrent(previousContext)
        #else
            UIGraphicsPopContext()
        #endif
    }

}
