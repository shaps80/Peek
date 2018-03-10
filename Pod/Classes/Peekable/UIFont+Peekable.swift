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

extension UIFont {
    
    open override func preparePeek(with coordinator: Coordinator) {
        coordinator.appendDynamic(keyPaths: [
            "familyName",
            "fontName",
            "pointSize",
        ], forModel: self, in: .general)
        
        coordinator.appendStatic(keyPath: "fontDescriptor", title: "Font Descriptor", detail: fontDescriptor.postscriptName, value: fontDescriptor, in: .general)
                
        coordinator.appendDynamic(keyPaths: [
            "descender",
            "capHeight",
            "xHeight",
            "lineHeight",
            "leading"
        ], forModel: self, in: .layout)
        
        super.preparePeek(with: coordinator)
    }
    
    @objc internal var peek_textStyle: String? {
        return (fontDescriptor.fontAttributes[.textStyle] as? UIFontTextStyle)?.rawValue
    }
    
}

extension UIFontDescriptor {
    
    open override func preparePeek(with coordinator: Coordinator) {
        if let value = fontAttributes[.textStyle] as? UIFontTextStyle {
            coordinator.appendStatic(keyPath: "textStyle", title: "Text Style", detail: value.rawValue, value: nil, in: .general)
        }
        
        if let value = fontAttributes[.family] as? String {
            coordinator.appendStatic(keyPath: "family", title: "Family", detail: value, value: nil, in: .general)
        }
        
        coordinator.appendDynamic(keyPaths: ["postscriptName"], forModel: self, in: .general)
        
        if let value = fontAttributes[.name] as? String {
            coordinator.appendStatic(keyPath: " name", title: "Name", detail: value, value: nil, in: .general)
        }
        
        if let value = fontAttributes[.face] as? String {
            coordinator.appendStatic(keyPath: "face", title: "Face", detail: value, value: nil, in: .general)
        }
        
        if let value = fontAttributes[.visibleName] as? String {
            coordinator.appendStatic(keyPath: "visibleName", title: "Visible Name", detail: value, value: nil, in: .general)
        }
        
        super.preparePeek(with: coordinator)
    }
    
}
