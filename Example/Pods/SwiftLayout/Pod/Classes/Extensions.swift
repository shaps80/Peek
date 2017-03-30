//
//  Extensions.swift
//  SwiftLayout
//
//  Created by Shaps Mohsenin on 21/06/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

extension View {
  
  /**
   Resests all constraints for this view (similar to Xcode)
   */
  public func resetConstraints() {
    removeConstraints(constraints)
  }
  
  /**
   Resets all constraints for this views subviews (similar to Xcode)
   */
  public func resetSubViewConstraints() {
    for constraint: NSLayoutConstraint in self.constraints {
      let item = constraint.firstItem as? View
      if item != self {
        removeConstraint(constraint)
      }
    }
  }
  
}

import ObjectiveC

struct ArrayAssociation {
  static var _active: UInt8 = 1
}

extension Array where Element: NSLayoutConstraint {
  
  /**
   Activates or deactivates all constraints in the array regardless of their current state
   */
  public func activateConstraints(_ activate: Bool) {
    forEach { $0.isActive = activate }
  }
  
}
