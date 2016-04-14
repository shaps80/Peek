//
//  NSNumber+Extensions.swift
//  Peek
//
//  Created by Shaps Mohsenin on 09/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import Foundation

extension NSNumber {
  
  func isBool() -> Bool
  {
    let boolID = CFBooleanGetTypeID()
    let numID = CFGetTypeID(self)
    return numID == boolID
  }
  
  func isFloat() -> Bool {
    switch CFNumberGetType(self) {
    case .CGFloatType, .DoubleType, .Float32Type, .Float64Type, .FloatType:
      return true
    default:
      return false
    }
  }
  
}

