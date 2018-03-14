//
//  PeekSelectionView.swift
//  Peek
//
//  Created by Shaps Benkau on 12/03/2018.
//

import UIKit

internal class PeekSelectionView: UIView {
    
    private let borderWidth: CGFloat
    private let borderColor: UIColor
    private let dashed: Bool
    
    internal init(borderColor: UIColor?, borderWidth: CGFloat, dashed: Bool = false) {
        self.borderColor = borderColor ?? .white
        self.borderWidth = borderWidth
        self.dashed = dashed
        
        super.init(frame: .zero)
        
        backgroundColor = .clear
        layer.zPosition = 20
        
        guard !dashed else { return }
        
        layer.borderWidth = borderWidth
        layer.borderColor = self.borderColor.cgColor
        layer.cornerRadius = borderWidth * 2
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard dashed else { return }
        
        let inset = borderWidth / 2
        let path = UIBezierPath(roundedRect: rect.insetBy(dx: inset, dy: inset), cornerRadius: borderWidth * 2)
        
        if dashed {
            path.setLineDash([4, 4], count: 2, phase: 0)
        }
        
        borderColor.setStroke()
        path.stroke()
    }
    
}
