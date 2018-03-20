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

extension UIStepper {
    
    @objc var normalIncrementImage: UIImage? {
        return incrementImage(for: UIControlState())
    }
    
    @objc var disabledIncrementImage: UIImage? {
        return incrementImage(for: .disabled)
    }
    
    @objc var highlightedIncrementImage: UIImage? {
        return incrementImage(for: .highlighted)
    }
    
    @objc var selectedIncrementImage: UIImage? {
        return incrementImage(for: .selected)
    }
    
    @objc var normalDecrementImage: UIImage? {
        return decrementImage(for: UIControlState())
    }
    
    @objc var disabledDecrementImage: UIImage? {
        return decrementImage(for: .disabled)
    }
    
    @objc var highlightedDecrementImage: UIImage? {
        return decrementImage(for: .highlighted)
    }
    
    @objc var selectedDecrementImage: UIImage? {
        return decrementImage(for: .selected)
    }
    
    open override func preparePeek(with coordinator: Coordinator) {
        for target in self.allTargets {
            for action in self.actions(forTarget: target, forControlEvent: .valueChanged) ?? [] {
                var detail: String = ""
                
                if let model = target as? Peekable {
                    detail = String(describing: model.classForCoder)
                }
                
                coordinator.appendStatic(keyPath: action, title: action, detail: detail, value: target, in: .actions)
            }
        }
        
        coordinator.appendDynamic(keyPaths: [
            "autorepeat", "continuous", "wraps"
        ], forModel: self, in: .behaviour)
        
        coordinator.appendDynamic(keyPaths: [
            "normalIncrementImage",
            "disabledIncrementImage",
            "highlightedIncrementImage",
            "selectedIncrementImage",
            
            "normalDecrementImage",
            "disabledDecrementImage",
            "highlightedDecrementImage",
            "selectedDecrementImage"
        ], forModel: self, in: .states)
        
        coordinator.appendDynamic(keyPaths: [
            "stepValue", "value", "minimumValue", "maximumValue"
        ], forModel: self, in: .general)
        
        super.preparePeek(with: coordinator)
    }
    
}
