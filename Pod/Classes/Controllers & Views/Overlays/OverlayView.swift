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
import SwiftLayout

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


enum OverlayMode {
  case single
  case multiple
}

/// An overlay view is used to show layout information in Peek
class OverlayView: UIView {
  
  fileprivate weak var peek: Peek!
  var isDragging = false {
    didSet {
      UIView.animate(withDuration: 0.3, animations: {
        self.superviewHighlightView.alpha = self.isDragging ? 0 : 1
      }) 
    }
  }
  
  var selectedModels: [UIView]? {
    didSet {
      reload()
    }
  }
  
  fileprivate lazy var superviewHighlightView: UIView = {
    let view = UIView()
    
    view.layer.cornerRadius = 2
    view.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
    view.layer.borderWidth = 1
    
    return view
  }()
  
  fileprivate(set) lazy var primaryView: HighlightView = {
    HighlightView(color: UIColor.primaryColor())
  }()
  
  fileprivate lazy var secondaryView: HighlightView = {
    let view = HighlightView(color: UIColor.secondaryColor())
    view.layer.zPosition = -1
    return view
  }()
  
  func reload() {
    if let model = selectedModels?.last {
      updateHighlightView(highlightView: primaryView, withModel: model)
    }
    
    if let model = selectedModels?.first, selectedModels?.count > 1 {
      _ = model.frameInPeek(self)
      updateHighlightView(highlightView: secondaryView, withModel: model)
    } else {
      secondaryView.removeFromSuperview()
    }
  }
  
  fileprivate func updateHighlightView(highlightView view: HighlightView, withModel model: UIView) {
    guard let superview = model.superview else {
      return
    }
    
    let viewFrame = model.frameInPeek(self)
    let superviewFrame = superview.frameInPeek(self)
    
    if view.superview == nil {
      view.frame = viewFrame
      superviewHighlightView.frame = superviewFrame
      superviewHighlightView.alpha = 0

      if view != secondaryView {
        view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
      }
      
      addHighlightView(view)
    }
    
    UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.1, options: .beginFromCurrentState, animations: { () -> Void in
      self.superviewHighlightView.alpha = self.isDragging ? 0 : 1
      view.transform = CGAffineTransform.identity
      view.frame = viewFrame
      self.superviewHighlightView.frame = superviewFrame
      view.setMetrics(Metrics(top: model.frame.origin.y, left: model.frame.origin.x, bottom: superview.bounds.maxY - model.frame.maxY, right: superview.bounds.maxX - model.frame.maxX))
    }, completion: nil)
  }
  
  fileprivate func addHighlightView(_ view: HighlightView) {
    addSubview(superviewHighlightView)
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
