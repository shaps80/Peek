//
//  CGRect+Resize.swift
//  Peek
//
//  Created by Shaps Benkau on 20/03/2018.
//

import CoreGraphics

internal enum ScaleMode: Int {
    
    case scaleToFill
    case scaleAspectFit
    case scaleAspectFill
    case center
    
}

extension CGSize {
    
    /**
     Returns a new size, scaled to the specified size using the given scale mode
     
     - parameter size: The size to scale to
     - parameter mode: The scale mode
     
     - returns: The resulting size
     */
    internal func scaledTo(size: CGSize, scaleMode mode: ScaleMode) -> CGSize {
        var w: CGFloat, h: CGFloat
        
        switch mode {
        case .scaleToFill:
            w = size.width
            h = size.height
        case .scaleAspectFit:
            let mW = size.width / self.width
            let mH = size.height / self.height
            
            if mH < mW {
                w = mH * self.width
                h = size.height
            } else {
                h = mW * self.height
                w = size.width
            }
        case .scaleAspectFill:
            let mW = size.width / self.width
            let mH = size.height / self.height
            
            if mH > mW {
                w = mH * self.width
                h = size.height
            } else {
                h = mW * self.height
                w = size.width
            }
        case .center:
            w = self.height
            h = self.width
        }
        
        return CGSize(width: w, height: h)
    }
    
}
