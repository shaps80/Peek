//
//  PeekLayoutView.swift
//  Peek
//
//  Created by Shaps Benkau on 12/03/2018.
//

import UIKit

extension CGRect {
    internal static func distance(from: CGRect, to: CGRect) -> Metrics {
        let leading =  from.minX <= to.minX ? from : to
        let trailing = to.minX <= from.minX ? from : to
        let upper = from.minY <= to.minY ? from : to
        let lower = to.minY <= from.minY ? from : to
        
        let left: CGFloat, right: CGFloat
        
        if leading.maxX < trailing.minX {
            left = trailing.minX - leading.maxX
        } else if leading.minX > trailing.minX {
            left = leading.minX - trailing.minX
        } else if trailing.minX > leading.minX {
            left = trailing.minX - leading.minX
        } else {
            left = 0
        }
        
        let top: CGFloat, bottom: CGFloat
        
        if upper.maxY < lower.minY {
            top = lower.minY - upper.maxY
        } else if upper.minY > lower.minY {
            top = upper.minY - lower.minY
        } else if lower.minY > upper.minY {
            top = lower.minY - upper.minY
        } else {
            top = 0
        }
        
        right = 0
        bottom = 0
        
        return Metrics(top: top, left: left, bottom: 0, right: right)
    }
}

internal final class PeekLayoutView: PeekSelectionView {
    
    internal var primaryFrame: CGRect = .zero
    internal var secondaryFrame: CGRect = .zero
    
    override init(borderColor: UIColor?, borderWidth: CGFloat, dashed: Bool) {
        super.init(borderColor: borderColor, borderWidth: borderWidth, dashed: dashed)
        clipsToBounds = false
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        
        let distance = CGRect.distance(from: secondaryFrame, to: primaryFrame)
        print(distance)
        
        UIColor(white: 1, alpha: 0.5).setStroke()
        path.setLineDash([1, 2], count: 2, phase: 0)
        path.stroke()
    }
    
}
