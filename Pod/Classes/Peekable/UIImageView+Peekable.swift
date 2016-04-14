//
//  UIImageView+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIImageView {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Images") { (config) in
      config.addProperties([ "highlightedImage", "image" ])
    }
    
    context.configure(.Attributes, "State") { (config) in
      config.addProperties([ "highlighted", "isAnimating" ])
    }
    
    context.configure(.Attributes, "Animation") { (config) in
      config.addProperties([ "animationDuration", "animationRepeatCount" ])
    }
  }
  
}



