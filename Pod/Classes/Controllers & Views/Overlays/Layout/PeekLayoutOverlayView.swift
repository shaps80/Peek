//
//  PeekLayoutView.swift
//  Peek
//
//  Created by Shaps Benkau on 12/03/2018.
//

import UIKit

internal final class PeekLayoutOverlayView: PeekOverlayView {
    
    private lazy var layoutView: PeekLayoutView = {
        let view = PeekLayoutView(overlayView: self, borderColor: UIColor(white: 1, alpha: 0.5), borderWidth: 1, dashed: true)
        view.layer.zPosition = 0
        addSubview(view)
        return view
    }()
    
    internal override init() {
        super.init()
        allowsMultipleSelection = true
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func refresh() {
        super.refresh()
        layoutView.setNeedsDisplay()
    }
    
    override func updateHighlights(animated: Bool) {
        super.updateHighlights(animated: animated)
        
        guard indexesForSelectedItems.count > 1,
            let first = indexesForSelectedItems.first,
            let second = indexesForSelectedItems.last else {
                return
        }
        
        let primary = viewModels[first]
        let secondary = viewModels[second]
        
        layoutView.frame = primary.frameInPeek(self).union(secondary.frameInPeek(self))
        layoutView.primaryView = primary
        layoutView.secondaryView = secondary
        layoutView.setNeedsDisplay()
    }
    
}
