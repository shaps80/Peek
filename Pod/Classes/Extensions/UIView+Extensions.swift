//
//  UIView+Extensions.swift
//  Peek
//
//  Created by Shaps Mohsenin on 09/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIView {
  
  func owningViewController() -> UIViewController? {
    var responder: UIResponder? = self
    
    while !(responder is UIViewController) {
      if let next = responder?.nextResponder() {
        responder = next
      }
    }
    
    return responder as? UIViewController
  }
  
  func frameInPeek(view: UIView) -> CGRect {
    return convertRect(bounds, toView: view)
  }
  
  func frameInPeekWithoutTransform(view: UIView) -> CGRect {
    let center = self.center
    let size = self.bounds.size
    let rect = CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height)
    
    if let superview = self.superview {
      return superview.convertRect(rect, toView: view)
    }
    
    return CGRectZero
  }
  
}

