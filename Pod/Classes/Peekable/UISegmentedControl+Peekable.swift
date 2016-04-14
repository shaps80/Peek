//
//  UISegmentedControl+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 10/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

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

