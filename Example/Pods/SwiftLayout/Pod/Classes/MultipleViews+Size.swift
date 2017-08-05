//
//  MultipleViews+Sizing.swift
//  SwiftLayout
//
//  Created by Shaps Mohsenin on 21/06/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

extension Array where Element: View {
  
  /**
   Sizes the specified view
   
   - parameter axis:     The axis to size
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter size:     The size to apply
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  @discardableResult public func size(axis: Axis, relation: LayoutRelation = .equal, size: CGFloat, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    forEach { constraints.append($0.size(axis: axis, relation: relation, size: size, priority: priority)) }
    
    return constraints
  }
  
  /**
   Sizes the specified views
   
   - parameter axis:      The axis to size
   - parameter otherAxis: The other axis to use for sizing
   - parameter view:      The view to use for sizing
   - parameter ratio:     The ratio to apply to this sizing
   - parameter priority:  The priority for this constraint
   
   - returns: The appled constraints
   */
  @discardableResult public func size(axis: Axis, to otherAxis: Axis, of view: View, ratio: CGFloat = 1, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    forEach { constraints.append($0.size(axis: axis, to: otherAxis, of: view, ratio: ratio, priority: priority)) }
    return constraints
  }
  
  /**
   Sizes the specified views
   
   - parameter width:    The width of the views
   - parameter height:   The height of the views
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  @discardableResult public func size(width: CGFloat, height: CGFloat, relation: LayoutRelation = .equal, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    forEach { constraints.append(contentsOf: $0.size(width: width, height: height, relation: relation, priority: priority)) }
    return constraints
  }
  
  /**
   Sizes the specified views
   
   - parameter axis:     The axis to align to
   - parameter view:     The view to align to
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  @discardableResult public func align(axis: Axis, to view: View, relation: LayoutRelation, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    forEach { constraints.append($0.align(axis: axis, to: view)) }
    return constraints
  }
  
}
