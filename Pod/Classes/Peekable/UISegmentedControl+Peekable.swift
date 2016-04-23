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

class Segment: NSObject {
  
  override var description: String {
    return title ?? super.description
  }
  
  @objc var enabled: Bool = false
  @objc var title: String?
  @objc var width: CGFloat = 0
  @objc var image: UIImage?
  @objc var contentOffset: CGSize = CGSizeZero
  
  override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "General") { (config) in
      config.addProperties([ "enabled", "title", "width", "image", "contentOffset" ])
    }
  }
  
}

extension UISegmentedControl {
  
  var segments: [Segment]? {
    var segments = [Segment]()
    
    for index in 0..<numberOfSegments {
      let segment = Segment()
      segment.enabled = isEnabledForSegmentAtIndex(index)
      segment.title = titleForSegmentAtIndex(index)
      segment.width = widthForSegmentAtIndex(index)
      segment.contentOffset = contentOffsetForSegmentAtIndex(index)
      segment.image = imageForSegmentAtIndex(index)
      segments.append(segment)
    }
    
    return segments
  }
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "momentary" ])
      config.addProperty("apportionsSegmentWidthsByContent", displayName: "Auto Size Width", cellConfiguration: nil)
    }
    
    context.configure(.Attributes, "General") { (config) in
      config.addProperties([ "selectedSegmentIndex", "segments" ])
    }
    
  }
  
}