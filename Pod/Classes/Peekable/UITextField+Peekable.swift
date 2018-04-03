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

extension UITextField {
    
    open override func preparePeek(with coordinator: Coordinator) {
        coordinator.appendDynamic(keyPaths: [
            "leftView", "rightView"
        ], forModel: self, in: .views)
        
        coordinator.appendDynamic(keyPaths: [
            "allowsEditingTextAttributes",
            "clearsOnBeginEditing",
            "clearsOnInsertion"
        ], forModel: self, in: .behaviour)
        
        coordinator.appendDynamic(keyPaths: [
            "editing"
        ], forModel: self, in: .states)
        
        coordinator.appendDynamic(keyPaths: [
            "text",
            "attributedText",
            "placeholder",
            "attributedPlaceholder",
        ], forModel: self, in: .typography)
        
        (coordinator as? SwiftCoordinator)?
            .appendEnum(keyPath: "indicatorStyle", into: UIScrollViewIndicatorStyle.self, forModel: self, group: .appearance)
            .appendEnum(keyPath: "indicatorStyle", into: UIScrollViewIndicatorStyle.self, forModel: self, group: .appearance)
            .appendEnum(keyPath: "borderStyle", into: UITextBorderStyle.self, forModel: self, group: .appearance)
            .appendEnum(keyPath: "clearButtonMode", "leftViewMode", "rightViewMode", into: UITextFieldViewMode.self, forModel: self, group: .appearance)
            .appendEnum(keyPath: "textAlignment", into: NSTextAlignment.self, forModel: self, group: .typography)
        
        coordinator.appendDynamic(keyPaths: [
            "textColor",
            "font",
            "minimumFontSize",
            "adjustsFontSizeToFitWidth",
        ], forModel: self, in: .typography)
        
        super.preparePeek(with: coordinator)
    }
    
}
