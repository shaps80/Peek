/*
  Copyright © 2015 Shaps Mohsenin. All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

  THIS SOFTWARE IS PROVIDED BY FRANCESCO PETRUNGARO `AS IS' AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
  EVENT SHALL FRANCESCO PETRUNGARO OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


// MARK: - Extends UI/NS View to provide better support for programmatic constraints
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
  
  /**
  Pins the edges of 2 associated views
  
  - parameter edges:  The edges (bitmask) to pin
  - parameter view:   The second view to pin to
  - parameter margins: The margins to apply for each applicable edge
  
  - returns: The constaints that were added to this view
  */
  public func pin(edges: EdgeMask, toView view: View, relation: NSLayoutRelation = .Equal, margins: EdgeMargins = EdgeMargins(), priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    if edges.contains(.Top) {
      constraints.append(pin(.Top, toEdge: .Top, toView: view, relation: relation, margin: margins.top, priority: priority))
    }
    
    if edges.contains(.Bottom) {
      constraints.append(pin(.Bottom, toEdge: .Bottom, toView: view, relation: relation, margin: margins.bottom, priority: priority))
    }
    
    if edges.contains(.Left) {
      constraints.append(pin(.Left, toEdge: .Left, toView: view, relation: relation, margin: margins.left, priority: priority))
    }
    
    if edges.contains(.Right) {
      constraints.append(pin(.Right, toEdge: .Right, toView: view, relation: relation, margin: margins.right, priority: priority))
    }
    
    return constraints
  }
  
  
  /**
  Pins a single edge to another views edge
  
  - parameter edge:   The edge of this view to pin
  - parameter toEdge: The edge of the second view to pin
  - parameter view:   The second view to pin to
  - parameter margin: The margin to apply to this constraint
  
  - returns: The constraint that was added
  */
  public func pin(edge: Edge, toEdge: Edge, toView view: View, relation: NSLayoutRelation = .Equal, margin: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.secondView = view
    constraint.firstAttribute = edgeAttribute(edge)
    constraint.secondAttribute = edgeAttribute(toEdge)
    constraint.constant = (edge == .Right && toEdge == .Left) || (edge == .Bottom && toEdge == .Top) ? -1 * margin : margin
    constraint.relation = relation
    constraint.priority = priority
    
    let layoutConstraint = constraint.constraint()
    NSLayoutConstraint.activateConstraints([layoutConstraint])
    return layoutConstraint
  }
  
  /**
  Aligns this views center to another view
  
  - parameter axis:   The axis to align
  - parameter view:   The second view to align to
  - parameter offset: The offset to apply to this alignment
  
  - returns: The constraint that was added
  */
  public func align(axis: Axis, toView view: View, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.secondView = view
    constraint.firstAttribute = centerAttribute(axis)
    constraint.secondAttribute = centerAttribute(axis)
    constraint.constant = offset
    constraint.priority = priority
    
    let layoutConstraint = constraint.constraint()
    NSLayoutConstraint.activateConstraints([layoutConstraint])
    return layoutConstraint
  }

  /**
  Sizes this view
  
  - parameter axis:     The axis to size
  - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
  - parameter size:     The size to set
  
  - returns: The constraint that was added
  */
  public func size(axis: Axis, relatedBy relation: NSLayoutRelation, size: CGFloat, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.firstAttribute = sizeAttribute(axis)
    constraint.secondAttribute = sizeAttribute(axis)
    constraint.relation = relation
    constraint.constant = size
    constraint.priority = priority
    
    let layoutConstraint = constraint.constraint()
    NSLayoutConstraint.activateConstraints([layoutConstraint])
    return layoutConstraint
  }
  
  /**
  Sizes this view's axis relative to another view axis. Note: The axis for each view doesn't have to be the same
  
  - parameter axis:      The axis to size
  - parameter otherAxis: The other axis to use for sizing
  - parameter view:      The second view to reference
  - parameter ratio:     The ratio to apply to this sizing. (e.g. 0.5 would size this view by 50% of the second view's edge)
  
  - returns: The constraint that was added
  */
  public func size(axis: Axis, toAxis otherAxis: Axis, ofView view: View, ratio: CGFloat = 1, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.secondView = view
    constraint.firstAttribute = sizeAttribute(axis)
    constraint.secondAttribute = sizeAttribute(otherAxis)
    constraint.multiplier = ratio
    constraint.priority = priority
    
    let layoutConstraint = constraint.constraint()
    NSLayoutConstraint.activateConstraints([layoutConstraint])
    return layoutConstraint
  }
  
}


// MARK: - Extends UI/NS View with some additional convenience methods
extension View {
  
  /**
   Sizes the view to the specified width and height
   
   - parameter width:  The width
   - parameter height: The height
   
   - returns: The constraint that was added
   */
  public func size(width width: CGFloat, height: CGFloat, relation: NSLayoutRelation = .Equal, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    let horizontal = size(.Horizontal, relatedBy: relation, size: width, priority: priority)
    let vertical = size(.Vertical, relatedBy: relation, size: height, priority: priority)
    return [horizontal, vertical]
  }
  
  public func pinEdges(edges: EdgeMask, toView: View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    if edges.contains(.Left) {
      constraints.append(pinLeft(toView))
    }
    
    if edges.contains(.Right) {
      constraints.append(pinRight(toView))
    }
    
    if edges.contains(.Top) {
      constraints.append(pinTop(toView))
    }
    
    if edges.contains(.Bottom) {
      constraints.append(pinBottom(toView))
    }
    
    return constraints
  }
  
  /**
  Pins the top edge of this view to the top of the specified view
  
  - parameter view: The reference view to pin to
  
  - returns: The constraint that was added
  */
  public func pinTop(toView: View) -> NSLayoutConstraint {
    return pin(.Top, toEdge: .Top, toView: toView, margin: frame.minY)
  }
  
  /**
  Pins the top edge of this view to the top of the specified view
  
  - parameter view: The reference view to pin to
  
  - returns: The constraint that was added
  */
  public func pinLeft(toView: View) -> NSLayoutConstraint {
    return pin(.Left, toEdge: .Left, toView: toView, margin: frame.minX)
  }
  
  /**
  Pins the top edge of this view to the top of the specified view
  
  - parameter view: The reference view to pin to
  
  - returns: The constraint that was added
  */
  public func pinBottom(toView: View) -> NSLayoutConstraint {
    return pin(.Bottom, toEdge: .Bottom, toView: toView, margin: toView.bounds.maxY - frame.maxY)
  }
  
  /**
  Pins the top edge of this view to the top of the specified view
  
  - parameter view: The reference view to pin to
  
  - returns: The constraint that was added
  */
  public func pinRight(toView: View) -> NSLayoutConstraint {
    return pin(.Right, toEdge: .Right, toView: toView, margin: toView.bounds.maxX - frame.maxX)
  }

  /**
   Aligns the center vertically to the specified view
   
   - parameter view: The reference view to align to
   
   - returns: The constraint that was added
   */
  public func alignHorizontally(toView: View) -> NSLayoutConstraint {
    return align(.Horizontal, toView: toView, offset: 0)
  }
  
  /**
   Aligns the center vertically to the specified view
   
   - parameter view: The reference view to align to
   
   - returns: The constraint that was added
   */
  public func alignVertically(toView: View) -> NSLayoutConstraint {
    return align(.Vertical, toView: toView, offset: 0)
  }
  
}

