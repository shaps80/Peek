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

/// This accessory view is used in Peek to show a 'rect' representing the underlying CGRect value
final class RectAccessoryView: UIView {
  
  fileprivate let value: CGRect
  
  init(value: CGRect) {
    self.value = value
    super.init(frame: CGRect.zero)
    backgroundColor = UIColor.clear
    prepare()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func prepare() {    
    let attributes = [ NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)!, NSForegroundColorAttributeName: UIColor.white ]
    let originString = "Origin:\t\(value.origin.x), \(value.origin.y)"
    let sizeString = "Size:\t\(value.width), \(value.height)"
    
    let originLabel = UILabel()
    originLabel.attributedText = NSAttributedString(string: originString, attributes: attributes)
    
    let sizeLabel = UILabel()
    sizeLabel.attributedText = NSAttributedString(string: sizeString, attributes: attributes)
    
    addSubview(originLabel)
    addSubview(sizeLabel)
    
    originLabel.pin(edges: [ .leftAndRight, .top ], to: self)
    sizeLabel.pin(edges: [ .leftAndRight, .bottom ], to: self)
    sizeLabel.pin(edge: .top, to: .bottom, of: originLabel, margin: 7)
  }
  
}
