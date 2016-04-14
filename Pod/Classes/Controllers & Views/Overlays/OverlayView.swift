//
//  OverlayView.swift
//  Pods
//
//  Created by Shaps Mohsenin on 07/02/2016.
//
//

import UIKit
import SwiftLayout

enum OverlayMode {
  case Single
  case Multiple
}

class OverlayView: UIView {
  
  private weak var peek: Peek!
  var isDragging = false {
    didSet {
      UIView.animateWithDuration(0.3) {
        self.superviewHighlightView.alpha = self.isDragging ? 0 : 1
      }
    }
  }
  
  var selectedModels: [UIView]? {
    didSet {
      reload()
    }
  }
  
  private lazy var superviewHighlightView: UIView = {
    let view = UIView()
    
    view.layer.cornerRadius = 2
    view.layer.borderColor = UIColor(white: 1, alpha: 0.3).CGColor
    view.layer.borderWidth = 1
    
    return view
  }()
  
  private(set) lazy var primaryView: HighlightView = {
    HighlightView(color: UIColor.primaryColor())
  }()
  
  private lazy var secondaryView: HighlightView = {
    let view = HighlightView(color: UIColor.secondaryColor())
    view.layer.zPosition = -1
    return view
  }()
  
  func reload() {
    if let model = selectedModels?.last {
      updateHighlightView(highlightView: primaryView, withModel: model)
    }
    
    if let model = selectedModels?.first where selectedModels?.count > 1 {
      _ = model.frameInPeek(self)
      updateHighlightView(highlightView: secondaryView, withModel: model)
    } else {
      secondaryView.removeFromSuperview()
    }
  }
  
  private func updateHighlightView(highlightView view: HighlightView, withModel model: UIView) {
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
        view.transform = CGAffineTransformMakeScale(1.1, 1.1)
      }
      
      addHighlightView(view)
    }
    
    UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.1, options: .BeginFromCurrentState, animations: { () -> Void in
      self.superviewHighlightView.alpha = self.isDragging ? 0 : 1
      view.transform = CGAffineTransformIdentity
      view.frame = viewFrame
      self.superviewHighlightView.frame = superviewFrame
      view.setMetrics(Metrics(top: model.frame.origin.y, left: model.frame.origin.x, bottom: superview.bounds.maxY - model.frame.maxY, right: superview.bounds.maxX - model.frame.maxX))
    }, completion: nil)
  }
  
  private func addHighlightView(view: HighlightView) {
    addSubview(superviewHighlightView)
    addSubview(view)
  }
  
  init(peek: Peek) {
    super.init(frame: CGRectZero)
    self.peek = peek
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

}
