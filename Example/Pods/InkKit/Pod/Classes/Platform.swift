//
//  CGContext+Extension.swift
//  InkKit
//
//  Created by Shaps Benkau on 03/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

#if os(OSX)
    import AppKit
    public typealias Image = NSImage
    public typealias BezierPath = NSBezierPath
    public typealias Screen = NSScreen
    public typealias Font = NSFont
    
    extension NSImage {
        public func pngRepresentation() -> Data? {
            return NSBitmapImageRep(data: tiffRepresentation!)?.representation(using: .PNG, properties: [:])
        }
        
        public func jpgRepresentation(quality: CGFloat) -> Data? {
            return NSBitmapImageRep(data: tiffRepresentation!)?.representation(using: .JPEG, properties: [NSImageCompressionFactor: quality])
        }
    }
#else
    import UIKit
    public typealias Image = UIImage
    public typealias EdgeInsets = UIEdgeInsets
    public typealias BezierPath = UIBezierPath
    public typealias Screen = UIScreen
    public typealias Font = UIFont
    
    extension UIImage {
        public func pngRepresentation() -> Data? {
            return UIImagePNGRepresentation(self)
        }
        
        public func jpgRepresentation(quality: CGFloat) -> Data? {
            return UIImageJPEGRepresentation(self, quality)
        }
    }
#endif

extension CGContext {
    
    public static var current: CGContext? {
        #if os(OSX)
            return NSGraphicsContext.current()!.cgContext
        #else
            return UIGraphicsGetCurrentContext()
        #endif
    }
    
}
