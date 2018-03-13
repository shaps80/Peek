//
//  PeekTextOverlay.swift
//  Peek
//
//  Created by Shaps Benkau on 13/03/2018.
//

import UIKit

internal final class PeekTextOverlayView: PeekOverlayView {
    
    private var textView: UITextView?

    internal init(textView: UITextView) {
        self.textView = textView
        super.init()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
