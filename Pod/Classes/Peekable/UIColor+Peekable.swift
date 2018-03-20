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
import GraphicsRenderer

extension UIColor: Model {
    
    @objc var peek_alpha: CGFloat {
        return CGFloat(Color(systemColor: self)?.rgba.alpha ?? 0)
    }
    
    @objc var peek_HEX: String {
        if let hex = Color(systemColor: self)?.toHex(withAlpha: false) {
            return "#\(hex)"
        } else {
            return "Unknown"
        }
    }
    
    @objc var peek_HSL: String {
        return "\(Int(hslComponents.hue * 360)), \(Int(hslComponents.saturation * 100)), \(Int(hslComponents.brightness * 100))"
    }
    
    @objc var peek_RGB: String {
        return "\(Int(rgbComponents.red * 255)), \(Int(rgbComponents.green * 255)), \(Int(rgbComponents.blue * 255))"
    }
    
    @available(iOS 10.0, *)
    @objc var colorSpace: String {
        return (cgColor.colorSpace?.name as? String) ?? "Unknown"
    }
    
    open override func preparePeek(with coordinator: Coordinator) {
        if cgColor.pattern != nil || (self != .clear && rgbComponents.alpha != 0) {
            let width = UIScreen.main.nativeBounds.width / UIScreen.main.nativeScale
            let image = ImageRenderer(size: CGSize(width: width, height: 88)).image { context in
                let rect = context.format.bounds
                setFill()
                UIRectFill(rect)
            }
            
            coordinator.appendPreview(image: image, forModel: self)
        }
        
        if #available(iOS 10.0, *) {
            coordinator.appendDynamic(keyPaths: ["colorSpace"], forModel: self, in: .general)
        }
        
        guard cgColor.pattern == nil else {
            coordinator.appendStatic(keyPath: "cgColor.pattern", title: "Color", detail: nil, value: "Pattern", in: .general)
            return
        }
        
        guard self != .clear else {
            coordinator.appendStatic(keyPath: "self", title: "Color", detail: nil, value: "Clear", in: .general)
            return
        }
        
        coordinator.appendDynamic(keyPathToName: [
            ["peek_HEX": "HEX"],
            ["peek_RGB": "RGB"],
            ["peek_HSL": "HSL"],
            ["peek_alpha": "Alpha"],
        ], forModel: self, in: .general)
        
        super.preparePeek(with: coordinator)
    }
    
}
