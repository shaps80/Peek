//
//  SingleView+Align.swift
//  SwiftLayout
//
//  Created by Shaps Mohsenin on 21/06/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

extension View {
  
  /**
   Aligns this views center to another view
   
   - parameter axis:   The axis to align
   - parameter view:   The second view to align to
   - parameter offset: The offset to apply to this alignment
   
   - returns: The constraint that was added
   */
  @discardableResult public func align(axis: Axis, to view: View, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.secondView = view
    constraint.firstAttribute = centerAttribute(for: axis)
    constraint.secondAttribute = centerAttribute(for: axis)
    constraint.constant = offset
    constraint.priority = priority
    
    let layout = constraint.constraint()
    layout.isActive = true
    return layout
  }
  
}
