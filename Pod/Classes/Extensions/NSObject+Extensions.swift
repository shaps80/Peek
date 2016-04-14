//
//  Extensions.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension NSObject {
  
  class func ObjClassName() -> String {
    return NSStringFromClass(self).componentsSeparatedByString(".").last!
  }
  
  func ObjClassName() -> String {
    return self.classForCoder.ObjClassName()
  }
  
}
