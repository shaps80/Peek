//
//  MultipleViews.swift
//  SwiftLayout
//
//  Created by Shaps Mohsenin on 01/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

extension View {
  
  /**
   Pins the edges of the specified views to the associated veiw
   
   - parameter edges:    The edges to pin
   - parameter views:    The views to pin
   - parameter view:     The view to pin to
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter margins:  The margins for each edge
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  public static func pin(edges: EdgeMask, ofViews views: [View], toView view: View, relation: NSLayoutRelation = .Equal, margins: EdgeMargins = EdgeMargins(), priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.appendContentsOf($0.pin(edges, toView: view, relation: relation, margins: margins, priority: priority)) }
    return constraints
  }
  
  /**
   Pins the edge of the specified views to an edge of the associated view
   
   - parameter edge:     The edge of the views to pin
   - parameter views:    The views to pin
   - parameter toEdge:   The other edge to pin to
   - parameter view:     The view to pin to
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter margin:   The margins for this edge
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  public static func pin(edge: Edge, ofViews views: [View], toEdge: Edge, ofView view: View, relation: NSLayoutRelation = .Equal, margin: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append($0.pin(edge, toEdge: toEdge, toView: view, relation: relation, margin: margin, priority: priority)) }
    return constraints
  }
  
  /**
   Aligns the specified views to the axis of the associated view
   
   - parameter axis:     Axis to align
   - parameter views:    The views to align
   - parameter view:     The view to align to
   - parameter offset:   The offset to apply
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  public static func align(axis: Axis, ofViews views: [View], toView view: View, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append($0.align(axis, toView: view, offset: offset, priority: priority)) }
    return constraints
  }
  
  /**
   Sizes the specified view
   
   - parameter axis:     The axis to size
   - parameter views:    The views to size
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter size:     The size to apply
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  public static func size(axis: Axis, ofViews views: [View], relatedBy relation: NSLayoutRelation, size: CGFloat, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append($0.size(axis, relatedBy: relation, size: size, priority: priority)) }
    return constraints
  }
  
  /**
   Sizes the specified views
   
   - parameter axis:      The axis to size
   - parameter views:     The views to size
   - parameter otherAxis: The other axis to use for sizing
   - parameter view:      The view to use for sizing
   - parameter ratio:     The ratio to apply to this sizing
   - parameter priority:  The priority for this constraint
   
   - returns: The appled constraints
   */
  public static func size(axis: Axis, ofViews views: [View], relativeTo otherAxis: Axis, ofView view: View, ratio: CGFloat = 1, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append($0.size(axis, toAxis: axis, ofView: view, ratio: ratio, priority: priority)) }
    return constraints
  }
  
  /**
   Distributes the specified views evenly across the given axis
   
   - parameter views:         The views to distribute
   - parameter alignmentView: the view to align to
   - parameter axis:          The axis distribute across
   - parameter offset:        The offset to apply (optional)
   - parameter priority:      The priority to apply to these constraints
   
   - returns: The constraints that were added
   */
  public static func distribute(views: [UIView], inView alignmentView: UIView, alongAxis axis: Axis, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityRequired) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    for (index, view) in views.enumerate() {
      var constraint = Constraint(view: view)
      
      constraint.secondView = alignmentView
      constraint.firstAttribute = centerAttribute(axis)
      constraint.secondAttribute = edgeAttribute(axis == .Horizontal ? .Right : .Bottom)
      constraint.constant = offset
      constraint.multiplier = (CGFloat(index) + 1) / (CGFloat(views.count) + 1)
      constraint.priority = priority
      
      let layoutConstraint = constraint.constraint()
      constraints.append(layoutConstraint)
    }
    
    NSLayoutConstraint.activateConstraints(constraints)
    return constraints
  }
  
}

extension View {
  
  /**
   Sizes the specified views
   
   - parameter width:    The width of the views
   - parameter height:   The height of the views
   - parameter views:    The views to size
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  public static func size(width width: CGFloat, height: CGFloat, ofViews views: [View], relation: NSLayoutRelation = .Equal, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.appendContentsOf($0.size(width: width, height: height, relation: relation, priority: priority)) }
    return constraints
  }
  
  /**
   Pins the edges of the specified views
   
   - parameter edges: The edges to pin
   - parameter views: The views to pin
   - parameter view:  The view to pin to
   
   - returns: The applied constraints
   */
  public static func pinEdges(edges: EdgeMask, ofViews views: [View], toView view: View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.appendContentsOf($0.pinEdges(edges, toView: view)) }
    return constraints
  }
  
  /**
   Pins the top edge of the specified views
   
   - parameter views: The views to pin
   - parameter view:  The view to pin to
   
   - returns: The applied constraints
   */
  public static func pinTop(ofViews views: [View], toView view: View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append($0.pinTop(view)) }
    return constraints
  }
  
  /**
   pins the left edge of the specified views
   
   - parameter views: The views to pin
   - parameter view:  The view to pin to
   
   - returns: The applied constraints
   */
  public static func pinLeft(ofViews views: [View], toView view: View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append($0.pinLeft(view)) }
    return constraints
  }
  
  /**
   Pins the bottom edge of the specified views
   
   - parameter views: The views to pin
   - parameter view:  The view to pin to
   
   - returns: The applied constraints
   */
  public static func pinBottom(ofViews views: [View], toView view: View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append($0.pinBottom(view)) }
    return constraints
  }
  
  /**
   Pins the right edge of the specified views
   
   - parameter views: The views to pin
   - parameter view:  The view to pin to
   
   - returns: The applied constraints
   */
  public static func pinRight(ofViews views: [View], toView view: View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append($0.pinRight(view)) }
    return constraints
  }
  
  /**
   Aligns the specified views horizontally
   
   - parameter views: The view to align
   - parameter view:  The view to align to
   
   - returns: The applied constraints
   */
  public static func alignHorizontally(ofViews views: [View], toView view: View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append($0.alignHorizontally(view)) }
    return constraints
  }
  
  /**
   Aligns the specified views vertically
   
   - parameter views: The view to align
   - parameter view:  The view to align to
   
   - returns: The applied constraints
   */
  public static func alignVertically(ofViews views: [View], toView view: View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append($0.alignVertically(view)) }
    return constraints
  }
  
}


