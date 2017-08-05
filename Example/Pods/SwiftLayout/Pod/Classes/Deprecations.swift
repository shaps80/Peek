//
//  Deprecations.swift
//  SwiftLayout
//
//  Created by Shaps Mohsenin on 21/06/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

@available(*, unavailable, renamed: "sizeAttribute(for:)")
public func sizeAttribute(_ axis: Axis) -> LayoutAttribute {
    return sizeAttribute(for: axis)
}

@available(*, unavailable, renamed: "sizeAttribute(for:)")
public func centerAttribute(_ axis: Axis) -> LayoutAttribute {
    return sizeAttribute(for: axis)
}

@available(*, unavailable, renamed: "edgeAttribute(for:)")
public func edgeAttribute(_ edge: Edge) -> LayoutAttribute {
    return edgeAttribute(for: edge)
}

@available(*, unavailable, deprecated: 2.0.0)
extension ConstraintDefinition { }

@available(*, unavailable, deprecated: 2.0.0)
extension ConstraintsTraitMask { }

@available(*, unavailable, deprecated: 2.0.0)
extension Constraint { }

extension View {
  
  // Multiple View
  
  @available(*, unavailable, message: "This method has been moved to Array<View>")
  public static func pin(_ edges: EdgeMask, ofViews views: [View], toView view: View, relation: LayoutRelation = .equal, margins: EdgeMargins = EdgeMargins(), priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    return views.pin(edges: edges, to: view, relation: relation, margins: margins, priority: priority)
  }
  
  @available(*, unavailable, message: "This method has been moved to Array<View>")
  public static func pin(_ edge: Edge, ofViews views: [View], toEdge: Edge, ofView view: View, relation: LayoutRelation = .equal, margin: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    return views.pin(edge: edge, to: toEdge, of: view, relation: relation, margin: margin, priority: priority)
  }
  
  @available(*, unavailable, message: "This method has been moved to Array<View>")
  public static func align(_ axis: Axis, ofViews views: [View], toView view: View, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    return views.align(axis: axis, to: view, offset: offset, priority: priority)
  }
  
  @available(*, unavailable, message: "This method has been moved to Array<View>")
  public static func size(_ axis: Axis, ofViews views: [View], relatedBy relation: LayoutRelation, size: CGFloat, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    return views.size(axis: axis, relation: relation, size: size, priority: priority)
  }
  
  @available(*, unavailable, message: "This method has been moved to Array<View>")
  public static func size(_ axis: Axis, ofViews views: [View], relativeTo otherAxis: Axis, ofView view: View, ratio: CGFloat = 1, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    return views.size(axis: axis, to: otherAxis, of: view, ratio: ratio, priority: priority)
  }
  
  public static func distribute(_ views: [View], inView alignmentView: View, alongAxis axis: Axis, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityRequired) -> [NSLayoutConstraint] {
    return views.distribute(along: axis, in: alignmentView, offset: offset, priority: priority)
  }
  
  /**
   Sizes the specified views
   
   - parameter width:    The width of the views
   - parameter height:   The height of the views
   - parameter views:    The views to size
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter priority: The priority for this constraint
   
   - returns: The applied constraints
   */
  public static func size(width: CGFloat, height: CGFloat, ofViews views: [View], relation: LayoutRelation = .equal, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append(contentsOf: $0.size(width: width, height: height, relation: relation, priority: priority)) }
    return constraints
  }
  
  /**
   Pins the edges of the specified views
   
   - parameter edges: The edges to pin
   - parameter views: The views to pin
   - parameter view:  The view to pin to
   
   - returns: The applied constraints
   */
  public static func pinEdges(_ edges: EdgeMask, ofViews views: [View], toView view: View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    views.forEach { constraints.append(contentsOf: $0.pin(edges: edges, to: view)) }
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
    views.forEach { constraints.append($0.pin(edge: .top, to: .top, of: view)) }
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
    views.forEach { constraints.append($0.pin(edge: .left, to: .left, of: view)) }
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
    views.forEach { constraints.append($0.pin(edge: .bottom, to: .bottom, of: view)) }
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
    views.forEach { constraints.append($0.pin(edge: .right, to: .right, of: view)) }
    return constraints
  }
  
  /**
   Aligns the specified views horizontally
   
   - parameter views: The view to align
   - parameter view:  The view to align to
   
   - returns: The applied constraints
   */
  public static func alignHorizontally(ofViews views: [View], toView view: View) -> [NSLayoutConstraint] {
    return views.align(axis: .horizontal, to: view)
  }
  
  /**
   Aligns the specified views vertically
   
   - parameter views: The view to align
   - parameter view:  The view to align to
   
   - returns: The applied constraints
   */
  public static func alignVertically(ofViews views: [View], toView view: View) -> [NSLayoutConstraint] {
    return views.align(axis: .vertical, to: view)
  }
  
  // Single View

  @available(*, unavailable, deprecated: 2.0.0)
  public func constraints(for trait: ConstraintsTraitMask) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    for constraint in self.constraints {
      if constraint.trait == trait {
        constraints.append(constraint)
      }
    }
    
    if let superviewConstraints = self.superview?.constraints {
      for constraint in superviewConstraints {
        if constraint.firstItem as? View != self && constraint.secondItem as? View != self {
          continue
        }
        
        if trait.contains(constraint.trait) {
          constraints.append(constraint)
        }
      }
    }
    
    return constraints
  }
  
  @available(*, unavailable, deprecated: 2.0.0)
  public func contains(_ trait: ConstraintsTraitMask) -> Bool {
    fatalError("This has been removed!")
  }
  
  @available(*, unavailable, message: "Use pin(edge:to:of:) instead")
  public func pinTop(_ toView: View) -> NSLayoutConstraint {
    return pin(edge: .top, to: .top, of: toView)
  }
  
  @available(*, unavailable, message: "Use pin(edge:to:of:) instead")
  public func pinLeft(_ toView: View) -> NSLayoutConstraint {
    return pin(edge: .left, to: .left, of: toView)
  }
  
  @available(*, unavailable, message: "Use pin(edge:to:of:) instead")
  public func pinBottom(_ toView: View) -> NSLayoutConstraint {
    return pin(edge: .bottom, to: .bottom, of: toView)
  }
  
  @available(*, unavailable, message: "Use pin(edge:to:of:) instead")
  public func pinRight(_ toView: View) -> NSLayoutConstraint {
    return pin(edge: .right, to: .right, of: toView)
  }
  
  @available(*, unavailable, message: "Use align(axis:to:) instead")
  public func alignHorizontally(_ toView: View) -> NSLayoutConstraint {
    return align(axis: .horizontal, to: toView)
  }
  
  @available(*, unavailable, message: "Use align(axis:to:) instead")
  public func alignVertically(_ toView: View) -> NSLayoutConstraint {
    return align(axis: .vertical, to: toView)
  }
  
  @available(*, unavailable, message: "Use pin(edges:to:) instead")
  public func pinEdges(_ edges: EdgeMask, toView: View) -> [NSLayoutConstraint] {
    return pin(edges: edges, to: toView)
  }
  
}
