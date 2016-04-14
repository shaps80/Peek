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

#if os(OSX)
  import AppKit
  public typealias LayoutPriority = NSLayoutPriority
#else
  import UIKit
  public typealias LayoutPriority = UILayoutPriority
#endif

public let LayoutPriorityRequired: LayoutPriority = 1000 // A required constraint.  Do not exceed this.
public let LayoutPriorityDefaultHigh: LayoutPriority = 750 // This is the priority level with which a button resists compressing its content.
public let LayoutPriorityDefaultLow: LayoutPriority = 250 // This is the priority level at which a button hugs its contents horizontally.



/**
*  The classes included in this file extend NSLayoutConstraints, provide Swift implementations and cross-platform support for iOS, OSX, Watch and Apple TV
*/


/**
*  Defines various constraint traits (bitmask) that define the type of constraints applied to a view.
*/
public struct ConstraintsTraitMask: OptionSetType {
  public let rawValue: Int
  public init(rawValue: Int) { self.rawValue = rawValue }

  
  /// No constraints applied
  public static var None: ConstraintsTraitMask   { return ConstraintsTraitMask(rawValue: 0) }
  
  
  /// A top margin constraint is applied
  public static var TopMargin: ConstraintsTraitMask   { return ConstraintsTraitMask(rawValue: 1 << 0) }
  
  /// A left margin constraint is applied
  public static var LeftMargin: ConstraintsTraitMask  { return ConstraintsTraitMask(rawValue: 1 << 1) }
  
  /// A right margin constraint is applied
  public static var RightMargin: ConstraintsTraitMask  { return ConstraintsTraitMask(rawValue: 1 << 2) }
  
  /// A bottom margin constraint is applied
  public static var BottomMargin: ConstraintsTraitMask   { return ConstraintsTraitMask(rawValue: 1 << 3) }
  
  /// A horitzontal alignment constraint is applied
  public static var HorizontalAlignment: ConstraintsTraitMask  { return ConstraintsTraitMask(rawValue: 1 << 4) }
  
  /// A vertical aligntment constraint is applied
  public static var VerticalAlignment: ConstraintsTraitMask  { return ConstraintsTraitMask(rawValue: 1 << 5) }
  
  /// A horizontal sizing constraint is applied
  public static var HorizontalSizing: ConstraintsTraitMask { return ConstraintsTraitMask(rawValue: 1 << 6) }
  
  /// A vertical sizing constraint is applied
  public static var VerticalSizing: ConstraintsTraitMask { return ConstraintsTraitMask(rawValue: 1 << 7) }
  
  /// Horizontal margin constraints are applied (Left and Right)
  public static var HorizontalMargins: ConstraintsTraitMask  { return LeftMargin.union(RightMargin) }
  
  /// Vertical margin constraints are applied (Top and Right)
  public static var VerticalMargins: ConstraintsTraitMask { return TopMargin.union(BottomMargin) }
}

// MARK: - This extends UI/NS View to provide additional constraints support
extension View {
  
  /// Returns all constraints relevant to this view
  public var viewConstraints: [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    for constraint in self.constraints {
      constraints.append(constraint)
    }
    
    if let superviewConstraints = self.superview?.constraints {
      for constraint in superviewConstraints {
        if constraint.firstItem as? View != self && constraint.secondItem as? View != self {
          continue
        }
        
        constraints.append(constraint)
      }
    }
    
    return constraints
  }
  
  /**
  Returns all constraints for this view that match the specified traits
  
  - parameter trait: The traits to lookup
  
  - returns: An array of constraints. If no constraints exist, an empty array is returned. This method never returns nil
  */
  public func constraintsForTrait(trait: ConstraintsTraitMask) -> [NSLayoutConstraint] {
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
  
  /**
  Returns true if at least one constraint with the specified trait exists
  
  - parameter trait: The trait to test
  
  - returns: True if a constrait exists, false otherwise
  */
  public func containsTraits(trait: ConstraintsTraitMask) -> Bool {
    var traits = ConstraintsTraitMask.None
    
    for constraint in constraintsForTrait(trait) {
      traits.insert(constraint.trait)
    }
    
    return traits.contains(trait)
  }
  
}


/**
Defines an abstract representation of a constraint
*/
public protocol ConstraintDefinition {
  var priority: LayoutPriority { get }
  var constant: CGFloat { get set }
  var multiplier: CGFloat { get }
  var relation: NSLayoutRelation { get }
  var firstAttribute: NSLayoutAttribute { get }
  var secondAttribute: NSLayoutAttribute { get }
  var trait: ConstraintsTraitMask { get }
}

/**
We extend the existing NSLayoutConstraint, as well as our own implementation ConstraintDefinition
*/
extension NSLayoutConstraint: ConstraintDefinition { }


/**
This extension provides a Swift value-type representation of NSLayoutConstraint
*/
extension ConstraintDefinition {
  public var trait: ConstraintsTraitMask {
    let left = self.firstAttribute == .Left || self.firstAttribute == .Leading
    let right = self.firstAttribute == .Right || self.firstAttribute == .Trailing
    let top = self.firstAttribute == .Top
    let bottom = self.firstAttribute == .Bottom
    
    let width = self.firstAttribute == .Width
    let height = self.firstAttribute == .Height
    
    let centerX = self.firstAttribute == .CenterX
    let centerY = self.firstAttribute == .CenterY
    
    if width { return .HorizontalSizing }
    if height { return .VerticalSizing }
    
    if centerX { return .HorizontalAlignment }
    if centerY { return .VerticalAlignment }
    
    if left { return .LeftMargin }
    if right { return .RightMargin }
    if top { return .TopMargin }
    if bottom { return .BottomMargin }
    
    return .None
  }
}


/**
*  A Swift value-type implementation of NSLayoutConstraint
*/
public struct Constraint: ConstraintDefinition {
  
  public internal(set) var priority: LayoutPriority
  public var constant: CGFloat
  public internal(set) var multiplier: CGFloat
  public internal(set) var relation: NSLayoutRelation
  public internal(set) var firstAttribute: NSLayoutAttribute
  public internal(set) var secondAttribute: NSLayoutAttribute
  
  private var _enabled = true
  public var enabled: Bool {
    get {
      return self._enabled
    }
    set {
      self._enabled = enabled
      
      if (self.enabled) {
        NSLayoutConstraint.activateConstraints([self.constraint()])
      } else {
        NSLayoutConstraint.deactivateConstraints([self.constraint()])
      }
    }
  }
  
  public unowned var firstView: View {
    didSet {
      precondition(firstView.superview != nil, "The first view MUST be inserted into a superview before constraints can be applied")
    }
  }
  
  public weak var secondView: View?
  
  private weak var _constraint: NSLayoutConstraint?
  
  public init(view: View) {
    self.firstView = view
    self.firstAttribute = .NotAnAttribute
    self.secondAttribute = .NotAnAttribute
    self.constant = 0
    self.multiplier = 1
    self.relation = .Equal
    self.priority = 250
    
    view.translatesAutoresizingMaskIntoConstraints = false
  }
  
  public mutating func constraint() -> NSLayoutConstraint {
    if self._constraint == nil {
      self._constraint = NSLayoutConstraint(
        item: self.firstView,
        attribute: firstAttribute,
        relatedBy: self.relation,
        toItem: self.secondView,
        attribute: self.secondAttribute,
        multiplier: self.multiplier,
        constant: self.constant)
    }
    
    return self._constraint!
  }
  
}
