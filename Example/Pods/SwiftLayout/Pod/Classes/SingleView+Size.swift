//
//  SingleView+Size.swift
//  SwiftLayout
//
//  Created by Shaps Mohsenin on 21/06/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

extension View {
  
  /**
   Sizes this view
   
   - parameter axis:     The axis to size
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter size:     The size to set
   
   - returns: The constraint that was added
   */
  @discardableResult public func size(axis: Axis, relation: LayoutRelation, size: CGFloat, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.firstAttribute = sizeAttribute(for: axis)
    constraint.secondAttribute = sizeAttribute(for: axis)
    constraint.relation = relation
    constraint.constant = size
    constraint.priority = priority
    
    let layout = constraint.constraint()
    layout.isActive = true
    return layout
  }
  
  /**
   Sizes this view's axis relative to another view axis. Note: The axis for each view doesn't have to be the same
   
   - parameter axis:      The axis to size
   - parameter otherAxis: The other axis to use for sizing
   - parameter view:      The second view to reference
   - parameter ratio:     The ratio to apply to this sizing. (e.g. 0.5 would size this view by 50% of the second view's edge)
   
   - returns: The constraint that was added
   */
  @discardableResult public func size(axis: Axis, to otherAxis: Axis, of view: View, ratio: CGFloat = 1, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.secondView = view
    constraint.firstAttribute = sizeAttribute(for: axis)
    constraint.secondAttribute = sizeAttribute(for: otherAxis)
    constraint.multiplier = ratio
    constraint.priority = priority
    
    let layout = constraint.constraint()
    layout.isActive = true
    return layout
  }
  
  /**
   Sizes the view to the specified width and height
   
   - parameter width:  The width
   - parameter height: The height
   
   - returns: The constraint that was added
   */
  @discardableResult public func size(width: CGFloat, height: CGFloat, relation: LayoutRelation = .equal, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    let horizontal = size(axis: .horizontal, relation: relation, size: width, priority: priority)
    let vertical = size(axis: .vertical, relation: relation, size: height, priority: priority)
    return [horizontal, vertical]
  }
  
}
