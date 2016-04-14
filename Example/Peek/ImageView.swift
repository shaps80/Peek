//
//  ImageView.swift
//  Track
//
//  Created by Shaps Mohsenin on 09/02/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class ImageView: UIImageView {
  
  var topView: UIView!
  var bottomView: UIView!
  var placeholderView: UIImageView?
  
  @IBInspectable var placeholder: UIImage? {
    didSet {
      placeholderView?.image = placeholder
    }
  }
  
  override var image: UIImage? {
    didSet {
      if image == nil {
        placeholderView?.hidden = false
      } else {
        placeholderView?.hidden = true
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configurePlaceholder()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configurePlaceholder()
  }
  
  func configurePlaceholder() {
    placeholderView = UIImageView(image: placeholder)
    placeholderView?.contentMode = .Center
    placeholderView?.frame = bounds
    placeholderView?.autoresizingMask = [ .FlexibleHeight, .FlexibleWidth ]
    addSubview(placeholderView!)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let effect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
    effect.minimumRelativeValue = -10
    effect.maximumRelativeValue = 10
    
    addMotionEffect(effect)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)
    
    let animation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    animation.springBounciness = 20
    animation.toValue = NSValue(CGPoint: CGPointMake(0.95, 0.95))
    pop_addAnimation(animation, forKey: "pop")
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesEnded(touches, withEvent: event)
    
    let animation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    animation.springBounciness = 20
    animation.toValue = NSValue(CGPoint: CGPointMake(1, 1))
    pop_addAnimation(animation, forKey: "pop")
  }
  
  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    super.touchesCancelled(touches, withEvent: event)
    
    let animation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    animation.springBounciness = 20
    animation.toValue = NSValue(CGPoint: CGPointMake(1, 1))
    pop_addAnimation(animation, forKey: "pop")
  }
  
}

