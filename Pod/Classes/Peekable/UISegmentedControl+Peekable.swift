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

internal final class Segment: NSObject, PeekInspectorNestable {
    
    override var description: String {
        return title ?? ""
    }
    
    @objc var enabled: Bool = false
    @objc var title: String?
    @objc var width: CGFloat = 0
    @objc var image: UIImage?
    @objc var contentOffset: CGSize = CGSize.zero
    
    override func preparePeek(with coordinator: Coordinator) {
        if let image = image {
            coordinator.appendPreview(image: image, forModel: self)
        }
        
        coordinator.appendDynamic(keyPaths: [
            "title", "image"
        ], forModel: self, in: .appearance)
        
        coordinator.appendDynamic(keyPaths: [
            "contentOffset", "width"
        ], forModel: self, in: .layout)
        
        coordinator.appendDynamic(keyPaths: [
            "enabled"
        ], forModel: self, in: .states)
        
        super.preparePeek(with: coordinator)
    }
    
}

extension UISegmentedControl {
    
    var segments: [Segment]? {
        var segments = [Segment]()
        
        for index in 0..<numberOfSegments {
            let segment = Segment()
            segment.enabled = isEnabledForSegment(at: index)
            segment.title = titleForSegment(at: index)
            segment.width = widthForSegment(at: index)
            segment.contentOffset = contentOffsetForSegment(at: index)
            segment.image = imageForSegment(at: index)
            segments.append(segment)
        }
        
        return segments
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
        
        for segment in segments ?? [] {
            coordinator.appendStatic(keyPath: "segments", title: "Segment", detail: segment.title, value: segment, in: .appearance)
        }
        
        coordinator.appendDynamic(keyPaths: [
            "selectedSegmentIndex"
        ], forModel: self, in: .states)
        
        coordinator.appendDynamic(keyPaths: [
            "momentary"
        ], forModel: self, in: .behaviour)
        
        coordinator.appendDynamic(keyPathToName: [
            ["apportionsSegmentWidthsByContent": "Auto Sizes Width"]
        ], forModel: self, in: .layout)
        
        super.preparePeek(with: coordinator)
    }
    
}
