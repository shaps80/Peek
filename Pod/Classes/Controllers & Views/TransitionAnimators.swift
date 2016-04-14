//
//  PeekViewController.swift
//  Pods
//
//  Created by Shaps Mohsenin on 06/02/2016.
//
//

import UIKit

final class TransitionFadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  private unowned let peek: Peek
  private let operation: UINavigationControllerOperation
  
  init(peek: Peek, operation: UINavigationControllerOperation) {
    self.peek = peek
    self.operation = operation
  }
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 0.25
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
    let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
    
    transitionContext.containerView()?.addSubview(toController.view)
    toController.view.alpha = 0
    toController.navigationController?.setNavigationBarHidden(self.operation == .Pop, animated: true)
    
    UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
      fromController.view.alpha = 0
      toController.view.alpha = 1
    }) { (finished) in
      transitionContext.completeTransition(finished)
    }
  }
  
}
