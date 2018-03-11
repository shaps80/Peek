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

/// An overlay view is used to show layout information in Peek
class OverlayView: UIView {
    
    fileprivate weak var peek: Peek!
    internal var isDragging = false
    
    var selectedModels: [UIView] = [] {
        didSet { reload() }
    }
    
    fileprivate lazy var boundingView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 2
        view.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        view.layer.borderWidth = 1
        view.layer.zPosition = 0
        
        return view
    }()
    
    fileprivate(set) lazy var primaryView: HighlightView = {
        let view = HighlightView(color: .primaryTint)
        view.layer.zPosition = 20
        return view
    }()
    
    fileprivate lazy var secondaryView: HighlightView = {
        let view = HighlightView(color: .neutral)
        view.layer.zPosition = 10
        return view
    }()
    
    func reload() {
        if let model = selectedModels.last {
            updateHighlightView(highlightView: primaryView, withModel: model)
        } else {
            secondaryView.removeFromSuperview()
        }
        
        if let model = selectedModels.first, selectedModels.count > 1 {
            updateHighlightView(highlightView: secondaryView, withModel: model)
        }
    }
    
    fileprivate func updateHighlightView(highlightView view: HighlightView, withModel model: UIView) {
        guard let superview = model.superview else { return }
        
        let viewFrame = model.frameInPeek(self)
        let superviewFrame = superview.frameInPeek(self)
        let initialFrame = selectedModels.first?.frameInPeek(self) ?? superviewFrame
        
        let boundingRect = selectedModels.count == 1
            ? superviewFrame
            : selectedModels.reduce(initialFrame) { $0.union($1.frameInPeek(self)) }
        
        if view.superview == nil {
            view.frame = viewFrame
            boundingView.frame = boundingRect
            
            if view == primaryView {
                view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            
            addHighlightView(view)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.1, options: .beginFromCurrentState, animations: {
            view.transform = .identity
            view.frame = viewFrame
            self.boundingView.frame = boundingRect
         
            guard view == self.secondaryView else { return }
            
            let alternate = self.selectedModels.count > 0 ? self.selectedModels.last ?? self.boundingView : self.boundingView
            let first = model.frameInPeek(self)
            let second = alternate.frameInPeek(self)
            
            let top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat
            
            if first.maxY < second.minY {
                top = 0
                bottom = second.minY - first.maxY
            } else {
                top = second.minY - first.minY
                bottom = second.maxY - first.maxY
            }
            
            left = 0
            right = 0
            
            let metrics = Metrics(top: top, left: left, bottom: bottom, right: right)
            view.setMetrics(metrics)
        }, completion: nil)
    }
    
    fileprivate func addHighlightView(_ view: HighlightView) {
        addSubview(boundingView)
        addSubview(view)
    }
    
    init(peek: Peek) {
        super.init(frame: CGRect.zero)
        self.peek = peek
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
