//
//  MultipleViews+Pinning.swift
//  SwiftLayout
//
//  Created by Shaps Mohsenin on 21/06/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

extension Array where Element: View {
  
  /**
   Pins the edges of these views to the associated view
   
   - parameter edges:    The edges to pin
   - parameter view:     The view to pin to
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter margins:  The margins for each edge
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  @discardableResult public func pin(edges: EdgeMask, to view: View, relation: NSLayoutRelation = .equal, margins: EdgeMargins = EdgeMargins(), priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    forEach { constraints.append(contentsOf: $0.pin(edges: edges, of: view, relation: relation, margins: margins, priority: priority)) }
    return constraints
  }
  
  /**
   Pins the edge of the specified views to an edge of the associated view
   
   - parameter edge:       The edge of the views to pin
   - parameter otherEdge:  The other edge to pin to
   - parameter view:       The view to pin to
   - parameter relation:   The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter margin:     The margins for this edge
   - parameter priority:   The priority for this constraint
   
   - returns: The applied constraints
   */
  @discardableResult public func pin(edge: Edge, to otherEdge: Edge, of view: View, relation: NSLayoutRelation = .equal, margin: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    forEach { constraints.append($0.pin(edge: edge, to: otherEdge, of: view, relation: relation, margin: margin, priority: priority)) }
    return constraints
  }

}
