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
import pop

protocol ButtonDelegate: class {
    func button(_ button: Button, didChangeValue value: Double?)
}

@IBDesignable
class Button: UIControl, UITextFieldDelegate {
    
    weak var delegate: ButtonDelegate?
    private var highlightedColor: UIColor?
    
    var tapGesture: UITapGestureRecognizer!
    @IBOutlet var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        highlightedColor = tintColor
        backgroundColor = .clear
        tintColor = .clear
        
        textField.isEnabled = false
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(Button.handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        switch gesture.state {
        case .ended:
            textField.isEnabled = true
            textField.becomeFirstResponder()
            
            let animation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            animation?.springBounciness = 20
            animation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
            pop_add(animation, forKey: "pop")
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if textField.isFirstResponder {
            return
        }
        
        let animation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        animation?.springBounciness = 20
        animation?.toValue = NSValue(cgPoint: CGPoint(x: 0.8, y: 0.8))
        pop_add(animation, forKey: "pop")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let animation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        animation?.springBounciness = 20
        animation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        pop_add(animation, forKey: "pop")
    }
    
    override var tintColor: UIColor! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderSpacing: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isEnabled = false
        
        if textField.text?.lengthOfBytes(using: String.Encoding.utf8) == 0 {
            delegate?.button(self, didChangeValue: nil)
        } else {
            delegate?.button(self, didChangeValue: NSString(string: textField.text!).doubleValue)
        }
    }
    
    static let formatter = NumberFormatter()
    
    func setValue(_ value: Double?, animated: Bool) {
        
        Button.formatter.minimumFractionDigits = 0
        Button.formatter.maximumFractionDigits = 1
        
        let fade = CATransition()
        fade.type = kCATransitionFade
        fade.duration = animated ? 0.2 : 0
        
        textField.layer.add(fade, forKey: "fade")
        
        if let value = value {
            let animation = POPBasicAnimation(propertyNamed: kPOPViewTintColor)
            
            animation?.duration = animated ? 0.3 : 0
            animation?.toValue = highlightedColor
            
            pop_add(animation, forKey: "color")
            
            textField.text = Button.formatter.string(from: NSNumber(value: value))
        } else {
            let animation = POPBasicAnimation(propertyNamed: kPOPViewTintColor)
            
            animation?.duration = animated ? 0.3 : 0
            animation?.toValue = UIColor(white: 1, alpha: 0.6)
            
            pop_add(animation, forKey: "color")
            
            textField.text = nil
        }
        
        let animation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        
        animation?.springBounciness = 15
        animation?.springSpeed = 10
        animation?.toValue = NSValue(cgPoint: CGPoint(x: 1.1, y: 1.1))
        
        if !animated {
            return
        }
        
        pop_add(animation, forKey: "pop")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            let animation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            
            animation?.springBounciness = 15
            animation?.springSpeed = 20
            animation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
            
            self.pop_add(animation, forKey: "pop")
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        tintColor.set()
        context.setLineWidth(borderWidth)
        
        var frame = rect.insetBy(dx: 2, dy: 2)
        var path = UIBezierPath(roundedRect: frame, cornerRadius: frame.width / 2)
        path.lineWidth = borderWidth
        path.stroke()
        
        frame = rect.insetBy(dx: borderWidth + borderSpacing, dy: borderWidth + borderSpacing)
        path = UIBezierPath(roundedRect: frame, cornerRadius: frame.width / 2)
        path.fill()
    }
    
}
