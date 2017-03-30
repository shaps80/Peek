//
//  MultipleViews+Aligning.swift
//  SwiftLayout
//
//  Created by Shaps Mohsenin on 21/06/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

extension Array where Element: View {
  
  /**
   Aligns the specified views to the axis of the associated view
   
   - parameter axis:     Axis to align
   - parameter views:    The views to align
   - parameter view:     The view to align to
   - parameter offset:   The offset to apply
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  @discardableResult public func align(axis: Axis, to view: View, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    forEach { constraints.append($0.align(axis: axis, to: view, offset: offset, priority: priority)) }
    return constraints
  }
  
  /**
   Distributes the specified views evenly across the given axis
   
   - parameter axis:          The axis distribute across
   - parameter view:          The view to align to
   - parameter offset:        The offset to apply (optional)
   - parameter priority:      The priority to apply to these constraints
   
   - returns: The constraints that were added
   */
  @discardableResult public func distribute(along axis: Axis, in view: View, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    for (index, innerView) in enumerated() {
      var constraint = Constraint(view: innerView)
      
      constraint.secondView = view
      constraint.firstAttribute = centerAttribute(for: axis)
      constraint.secondAttribute = edgeAttribute(for: axis == .horizontal ? .right : .bottom)
      constraint.constant = offset
      constraint.multiplier = (CGFloat(index) + 1) / (CGFloat(count) + 1)
      constraint.priority = priority
      
      constraints.append(constraint.constraint())
    }
    
    constraints.activateConstraints(true)
    return constraints
  }
  
  // MARK: Convenience Methods 
  
  
  
}
