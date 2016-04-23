/*
  Copyright © 23/04/2016 Snippex

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