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

extension NSLayoutConstraint {
    
    open override var description: String {
        var name = "\(perform(Selector(("asciiArtDescription"))))".components(separatedBy: ": ").last
        
        if name == "nil" {
            name = super.description
        }
        
        return name ?? super.description
    }
    
    @objc var peek_firstItem: String {
        guard let item = firstItem else { return "nil" }
        return "\(item.classForCoder!)"
    }
    
    @objc var peek_secondItem: String {
        guard let item = secondItem else { return "nil" }
        return "\(item.classForCoder!)"
    }
    
    open override func preparePeek(with coordinator: Coordinator) {
        coordinator.appendDynamic(keyPaths: [
            "active",
            "shouldBeArchived"
        ], forModel: self, in: .behaviour)
        
        coordinator.appendTransformed(keyPaths: ["secondAttribute"], valueTransformer: { value in
            guard let rawValue = value as? Int, let attribute = NSLayoutAttribute(rawValue: rawValue) else { return nil }
            return attribute.description
        }, forModel: self, in: .general)
        
        coordinator.appendDynamic(keyPaths: ["peek_secondItem"], forModel: self, in: .general)
        
        coordinator.appendTransformed(keyPaths: ["firstAttribute"], valueTransformer: { value in
            guard let rawValue = value as? Int, let attribute = NSLayoutAttribute(rawValue: rawValue) else { return nil }
            return attribute.description
        }, forModel: self, in: .general)
        
        coordinator.appendDynamic(keyPaths: ["peek_firstItem"], forModel: self, in: .general)
        
        coordinator.appendDynamic(keyPaths: [
            "constant", "multiplier", "priority"
        ], forModel: self, in: .layout)
        
        coordinator.appendTransformed(keyPaths: ["relation"], valueTransformer: { value in
            guard let rawValue = value as? Int, let relation = NSLayoutRelation(rawValue: rawValue) else { return nil }
            return relation.description
        }, forModel: self, in: .layout)
        
        super.preparePeek(with: coordinator)
    }
    
}
