/*
 Copyright © 23/04/2016 Shaps
 
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

import UIKit

extension UIButton {
    
    @objc var normalTitle: String? {
        return title(for: UIControlState())
    }
    
    @objc var selectedTitle: String? {
        return title(for: .selected)
    }
    
    @objc var highlightedTitle: String? {
        return title(for: .highlighted)
    }
    
    @objc var disabledTitle: String? {
        return title(for: .disabled)
    }
    
    @objc var normalAttributedTitle: NSAttributedString? {
        return attributedTitle(for: UIControlState())
    }
    
    @objc var selectedAttributedTitle: NSAttributedString? {
        return attributedTitle(for: .selected)
    }
    
    @objc var highlightedAttributedTitle: NSAttributedString? {
        return attributedTitle(for: .highlighted)
    }
    
    @objc var disabledAttributedTitle: NSAttributedString? {
        return attributedTitle(for: .disabled)
    }
    
    @objc var normalTitleColor: UIColor? {
        return titleColor(for: UIControlState())
    }
    
    @objc var selectedTitleColor: UIColor? {
        return titleColor(for: .selected)
    }
    
    @objc var highlightedTitleColor: UIColor? {
        return titleColor(for: .highlighted)
    }
    
    @objc var disabledTitleColor: UIColor? {
        return titleColor(for: .disabled)
    }
    
    open override func preparePeek(with coordinator: Coordinator) {
        coordinator.appendTransformed(keyPaths: ["buttonType"], valueTransformer: { value in
            guard let rawValue = value as? Int, let buttonType = UIButtonType(rawValue: rawValue) else { return nil }
            return buttonType.description
        }, forModel: self, in: .appearance)
        
        coordinator.appendDynamic(keyPaths: [
            "contentEdgeInsets",
            "titleEdgeInsets",
            "imageEdgeInsets"
        ], forModel: self, in: .layout)
        
        coordinator.appendDynamic(keyPaths: [
            "showsTouchWhenHighlighted",
            "adjustsImageWhenDisabled",
            "adjustsImageWhenHighlighted"
        ], forModel: self, in: .behaviour)
        
        coordinator.appendDynamic(keyPaths: [
            "normalTitle", "selectedTitle", "highlightedTitle", "disabledTitle",
            "normalAttributedTitle", "selectedAttributedTitle", "highlightedAttributedTitle", "disabledAttributedTitle",
            "normalTitleColor", "selectedTitleColor", "highlightedTitleColor", "disabledTitleColor"
        ], forModel: self, in: .states)
        
        for target in self.allTargets {
            for action in self.actions(forTarget: target, forControlEvent: .touchUpInside) ?? [] {
                var detail: String = ""
                
                if let model = target as? Peekable {
                    detail = String(describing: model.classForCoder)
                }
                
                coordinator.appendStatic(keyPath: action, title: action, detail: detail, value: target, in: .actions)
            }
        }
        
        super.preparePeek(with: coordinator)
    }
    
}
