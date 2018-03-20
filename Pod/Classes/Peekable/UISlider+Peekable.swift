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

extension UISlider {
    
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
            "minimumTrackTintColor",
            "maximumTrackTintColor",
            "currentThumbImage",
            "currentMinimumTrackImage",
            "currentMaximumTrackImage",
            "minimumValueImage",
            "maximumValueImage",
        ], forModel: self, in: .appearance)
        
        coordinator.appendDynamic(keyPaths: [
            "value",
            "minimumValue",
            "maximumValue"
        ], forModel: self, in: .general)
        
        coordinator.appendDynamic(keyPaths: [
            "continuous"
        ], forModel: self, in: .behaviour)
        
        super.preparePeek(with: coordinator)
    }
    
}
