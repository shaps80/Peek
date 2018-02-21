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
    
    fileprivate let value: UIColor?
    fileprivate let size = CGSize(width: 24, height: 14)
    private let margin: CGFloat = 8
    
    init(value: UIColor?) {
        self.value = value
        super.init(frame: CGRect(x: 0, y: 0, width: size.width + margin, height: size.height))
        
        backgroundColor = .clear
        
        let view = UIView(frame: CGRect(x: margin, y: 0, width: size.width, height: size.height))
        view.backgroundColor = value
        view.isOpaque = true
        
        view.layer.cornerRadius = size.height / 2
        view.layer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        view.layer.borderWidth = 1
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: size.width + margin, height: size.height)
    }
    
}
