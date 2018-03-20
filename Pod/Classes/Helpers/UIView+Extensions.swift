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

extension UIView {
    
    /**
     Returns the UIViewController that owns this view
     
     - returns: The owning view controller
     */
    @objc internal func owningViewController() -> UIViewController? {
        var responder: UIResponder? = self
        
        while !(responder is UIViewController) && superview != nil {
            if let next = responder?.next {
                responder = next
            }
        }
        
        return responder as? UIViewController
    }
    
    /**
     Returns the CGRect representing this view, within the coordinates of Peek's overlay view
     
     - parameter view: The view to translate
     
     - returns: A CGRect in the coordinate space of Peek's overlay view
     */
    func frameInPeek(_ view: UIView) -> CGRect {
        return convert(bounds, to: view)
    }
    
    /**
     Returns the CGRect representing this view, excluding the current CGAffineTransform being applied to it
     
     - parameter view: The view to translate
     
     - returns: A CGRect in the coordinator space of Peek's overlay view
     */
    func frameInPeekWithoutTransform(_ view: UIView) -> CGRect {
        let center = self.center
        let size = self.bounds.size
        let rect = CGRect(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
        
        if let superview = self.superview {
            return superview.convert(rect, to: view)
        }
        
        return CGRect.zero
    }
    
}
