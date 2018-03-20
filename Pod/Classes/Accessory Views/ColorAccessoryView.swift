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

/// This accessory view is used in Peek to show an icon representing the underlying UIColor value
final class ColorAccessoryView: UIView {
    
    fileprivate let color: UIColor?
    fileprivate let size = CGSize(width: 20, height: 20)
    private let margin: CGFloat = 8
    
    init(color: UIColor?) {
        self.color = color
        super.init(frame: CGRect(x: 0, y: 0, width: size.width + margin, height: size.height))
        backgroundColor = .clear
        
        if #available(iOS 11.0, *) {
            self.accessibilityIgnoresInvertColors = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let stroke = UIColor(white: 1, alpha: 0.1)
        let rect = CGRect(x: 8, y: 0, width: size.width, height: size.height).insetBy(dx: 1, dy: 1)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: size.height / 2)
        
        color?.setFill()
        
        UIColor(white: 1, alpha: 0.1).setStroke()
        path.lineWidth = 1
        path.fill()
        path.stroke()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: size.width + margin, height: size.height)
    }
    
}
