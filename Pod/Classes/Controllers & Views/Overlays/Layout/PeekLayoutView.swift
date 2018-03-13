//
//  PeekLayoutView.swift
//  Peek
//
//  Created by Shaps Benkau on 12/03/2018.
//

import UIKit

internal final class PeekLayoutView: PeekSelectionView {
    
    internal var primaryFrame: CGRect = .zero
    internal var secondaryFrame: CGRect = .zero
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        var bounds = primaryFrame.intersection(secondaryFrame)
        
        if bounds == .null {
            bounds = rect
        }
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: secondaryFrame.minX, y: bounds.midY))
        path.addLine(to: CGPoint(x: primaryFrame.maxX, y: bounds.midY))
        
        UIColor(white: 1, alpha: 0.5).setStroke()
        path.stroke()
    }
    
}
