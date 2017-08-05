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
  Pins the edges of 2 associated views
  
  - parameter edges:  The edges (bitmask) to pin
  - parameter view:   The second view to pin to
  - parameter margins: The margins to apply for each applicable edge
  
  - returns: The constaints that were added to this view
  */
  @discardableResult public func pin(edges: EdgeMask, of view: View, relation: LayoutRelation = .equal, margins: EdgeMargins = EdgeMargins(), priority: LayoutPriority = LayoutPriorityDefaultHigh) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    if edges.contains(.top) {
      constraints.append(pin(edge: .top, to: .top, of: view, relation: relation, margin: margins.top, priority: priority))
    }
    
    if edges.contains(.bottom) {
      constraints.append(pin(edge: .bottom, to: .bottom, of: view, relation: relation, margin: margins.bottom, priority: priority))
    }
    
    if edges.contains(.left) {
constraints.append(pin(edge: .left, to: .left, of: view, relation: relation, margin: margins.left, priority: priority))
    }
    
    if edges.contains(.right) {
      constraints.append(pin(edge: .right, to: .right, of: view, relation: relation, margin: margins.right, priority: priority))
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
  @discardableResult public func pin(edge: Edge, to otherEdge: Edge, of view: View, relation: LayoutRelation = .equal, margin: CGFloat = 0, priority: LayoutPriority = LayoutPriorityDefaultHigh) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.secondView = view
    constraint.firstAttribute = edgeAttribute(for: edge)
    constraint.secondAttribute = edgeAttribute(for: otherEdge)
    constraint.constant = (edge == .right && otherEdge == .left) || (edge == .bottom && otherEdge == .top) ? -1 * margin : margin
    constraint.relation = relation
    constraint.priority = priority
    
    let layout = constraint.constraint()
    layout.isActive = true
    return layout
  }

  
  @discardableResult public func pin(edges: EdgeMask, to view: View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    if edges.contains(.left) {
      constraints.append(pin(edge: .left, to: .left, of: view))
    }
    
    if edges.contains(.right) {
      constraints.append(pin(edge: .right, to: .right, of: view))
    }
    
    if edges.contains(.top) {
      constraints.append(pin(edge: .top, to: .top, of: view))
    }
    
    if edges.contains(.bottom) {
      constraints.append(pin(edge: .bottom, to: .bottom, of: view))
    }
    
    return constraints
  }
  
}

