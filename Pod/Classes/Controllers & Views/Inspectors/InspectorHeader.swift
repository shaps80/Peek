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
import InkKit
import SwiftLayout

final class InspectorHeader: UIView {
  
  init(image: UIImage, showBorder: Bool) {
    let width = min(280, image.size.width) + 20
    let height = min(100, image.size.height) + 20
    let rect = CGRect(x: 0, y: 0, width: width, height: height)
    
    var headerImage: UIImage?
    
    if image.renderingMode == .AlwaysTemplate {
      headerImage = image.imageWithRenderingMode(.AlwaysTemplate)
    } else {
      headerImage = image
    }
    
    let imageView = UIImageView(image: headerImage)
    imageView.backgroundColor = UIColor.clearColor()
    imageView.clipsToBounds = true
    imageView.frame = rect.insetBy(dx: 10, dy: 10)
    imageView.contentMode = imageView.bounds.width > 280 || imageView.bounds.width > height ? .ScaleAspectFit : .Center
    
    var frame = rect
    frame.size.height -= 20
    super.init(frame: frame)
    
    backgroundColor = UIColor.clearColor()
    clipsToBounds = true
    
    addSubview(imageView)
    imageView.size(width: imageView.bounds.width, height: imageView.bounds.height)
    imageView.alignVertically(self)
    imageView.alignHorizontally(self)

    if showBorder {
      let borderView = DashedBorderView(frame: rect)
      borderView.clipsToBounds = true
      borderView.backgroundColor = UIColor.clearColor()
      addSubview(borderView)
      
      borderView.pin(.All, toView: self)
    }
    
    self.size(width: rect.width, height: rect.height)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}

private class DashedBorderView: UIView {
  
  private override func layoutSubviews() {
    super.layoutSubviews()
    setNeedsDisplay()
  }
  
  private override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    let color = UIColor(white: 1, alpha: 0.3)
    let path = UIBezierPath(roundedRect: rect.insetBy(dx: 1, dy: 1), cornerRadius: 2)
    
    color.setStroke()
    path.setLineDash([2, 4], count: 2, phase: 0)
    path.lineWidth = 1
    path.stroke()
  }
  
}