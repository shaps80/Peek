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
  
  private let value: UIColor?
  private let size = CGSizeMake(24, 14)
  
  init(value: UIColor?) {
    self.value = value
    super.init(frame: CGRectMake(0, 0, size.width, size.height))
    opaque = true
    backgroundColor = value
    
    layer.cornerRadius = size.height / 2
    layer.borderColor = UIColor(white: 1, alpha: 0.5).CGColor
    layer.borderWidth = 1
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func intrinsicContentSize() -> CGSize {
    return CGSizeMake(size.width, size.height)
  }
  
}