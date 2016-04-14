//
//  PeekTapGestureRecognizer.swift
//  Peek
//
//  Created by Shaps Mohsenin on 09/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

final class PeekTapGestureRecognizer: UITapGestureRecognizer {
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event!)
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
      if self.state != .Recognized {
        self.state = .Failed
      }
    }
  }
  
}
