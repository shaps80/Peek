//
//  NSString+Peekable.swift
//  Peek
//
//  Created by Shaps Benkau on 10/03/2018.
//

import Foundation
import GraphicsRenderer

extension NSString {
    
    internal var peek_preview: UIImage {
        let textView = UITextView()
        
        textView.layoutManager.showsInvisibleCharacters = true
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textColor = .white
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.backgroundColor = .clear
        textView.text = self as String
        textView.frame.size = CGSize(width: 320, height: 150)
        
        return ImageRenderer(size: textView.bounds.size).image { context in
            textView.drawHierarchy(in: context.format.bounds, afterScreenUpdates: true)
        }
    }
    
    open override func preparePeek(with coordinator: Coordinator) {
        coordinator.appendPreview(image: peek_preview, forModel: self)
        
        super.preparePeek(with: coordinator)
    }
    
}
