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
import SPXMasking
import pop

class WeekCell: UICollectionViewCell {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var separatorView: UIView!
  
  var lightColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.00)
  var darkColor = UIColor(red: 0.118, green: 0.122, blue: 0.129, alpha: 1.00)
  
  override var isSelected: Bool {
    didSet {
      update()
    }
  }
  
  override var isHighlighted: Bool {
    didSet {
      update()      
    }
  }
  
  fileprivate func update() {
    if self.isSelected || self.isHighlighted {
      self.titleLabel.textColor = self.darkColor
      self.imageView.tintColor = self.darkColor
    } else {
      self.titleLabel.textColor = self.lightColor
      self.imageView.tintColor = self.lightColor
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    
    let view = UIView()
    view.backgroundColor = lightColor
    selectedBackgroundView = view
    
    let radius: CGFloat = 15
    selectedBackgroundView!.layer.cornerRadii = SPXCornerRadiiMake(0, radius, radius, 0)
  }
  
}
