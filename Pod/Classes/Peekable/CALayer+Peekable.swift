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

extension CALayer {
    
    @objc var peek_borderColor: UIColor? {
        if let color = borderColor {
            return UIColor(cgColor: color)
        }
        
        return nil
    }
    
    @objc var peek_shadowColor: UIColor? {
        if let color = shadowColor {
            return UIColor(cgColor: color)
        }
        
        return nil
    }
    
    @objc var peek_backgroundColor: UIColor? {
        if let color = backgroundColor {
            return UIColor(cgColor: color)
        }
        
        return nil
    }
    
    open override func preparePeek(with coordinator: Coordinator) {
        coordinator.appendDynamic(keyPaths: [
            "doubleSided",
            "allowsGroupOpacity",
            "shouldRasterize",
            "rasterizationScale",
        ], forModel: self, in: .appearance)
        
        coordinator.appendDynamic(keyPaths: [
            "peek_shadowColor",
            "shadowOpacity",
            "shadowRadius",
            "shadowOffset",
        ], forModel: self, in: .shadow)
        
        coordinator.appendDynamic(keyPaths: [
            "peek_borderColor",
            "borderWidth"
        ], forModel: self, in: .border)
        
        coordinator.appendDynamic(keyPaths: [
            "contentsRect",
            "contentsCenter",
            "contentsScale",
            "contentsGravity",
            "geometryFlipped",
            "anchorPointZ",
            "position",
            "anchorPoint",
            "zPosition",
        ], forModel: self, in: .layout)
        
        var current = classForCoder
        coordinator.appendStatic(keyPath: "classForCoder", title: String(describing: current), detail: nil, value: "", in: .classes)
        
        while let next = current.superclass() {
            coordinator.appendStatic(keyPath: "classForCoder", title: String(describing: next), detail: nil, value: "", in: .classes)
            current = next
        }
        
        for layer in sublayers ?? [] {
            coordinator.appendStatic(keyPath: "layer.classForCoder", title: String(describing: layer.classForCoder), detail: "", value: layer, in: .layers)
        }
        
        super.preparePeek(with: coordinator)
    }
    
}
