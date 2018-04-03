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

extension UIImage {
    
    open override func preparePeek(with coordinator: Coordinator) {
        let preview = renderingMode != .alwaysOriginal ? withRenderingMode(.alwaysTemplate) : self
        coordinator.appendPreview(image: preview, forModel: self)
        
        (coordinator as? SwiftCoordinator)?
            .appendEnum(keyPath: "renderingMode", into: UIImageRenderingMode.self, forModel: self, group: .appearance)
            .appendEnum(keyPath: "resizingMode", into: UIImageResizingMode.self, forModel: self, group: .appearance)
            .appendEnum(keyPath: "imageOrientation", into: UIImageOrientation.self, forModel: self, group: .appearance)
        
        coordinator.appendDynamic(keyPaths: [
            "scale", "size", "capInsets", "alignmentRectInsets"
        ], forModel: self, in: .layout)
        
        super.preparePeek(with: coordinator)
    }
    
}
