//
//  Constraints.swift
//  Formula1
//
//  Created by Shaps Benkau on 18/10/2017.
//  Copyright © 2017 DigitasLBi. All rights reserved.
//

import UIKit

/// Defines a tuple of views that returns a constraint
public typealias Constraint = (UIView, UIView) -> NSLayoutConstraint

extension NSLayoutConstraint {
    
    /// Returns this constraint with its priority updated
    ///
    /// - Parameter priority: The new priority for this constraint
    /// - Returns: Returns self.
    func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
}

/// Returns a constraint for the specified anchor
///
/// - Parameters:
///   - keyPath: A keyPath to the source and destination anchor
///   - constant: The constant to apply to this constraint
///   - priority: The priority to apply to this constraint
/// - Returns: A newly configured constraint
public func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, constant: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return equal(keyPath, keyPath, constant: constant, priority: priority)
}

/// Returns a constraint for the specified anchors
///
/// - Parameters:
///   - keyPath: A keyPath to the source anchor
///   - to: A keyPath to the destination anchor
///   - constant: The constant to apply to this constraint
///   - priority: The priority to apply to this constraint
/// - Returns: A newly configured constraint
public func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, _ to: KeyPath<UIView, Anchor>, constant: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: keyPath].constraint(equalTo: parent[keyPath: to], constant: constant).with(priority: priority)
    }
}

public func sized<Anchor>(_ keyPath: KeyPath<UIView, Anchor>, constant: CGFloat, priority: UILayoutPriority = .defaultHigh) -> Constraint where Anchor: NSLayoutDimension {
    return { _, parent in
        parent[keyPath: keyPath].constraint(equalToConstant: constant).with(priority: priority)
    }
}

extension UIView {
    
    /// Adds view to otherView, and activates the associated constraints. This also ensures translatesAutoresizingMaskIntoConstraints is disabled.
    ///
    /// - Parameters:
    ///   - other: The other view this view will be added to
    ///   - constraints: The constraints to apply
    public func addSubview(_ other: UIView, below view: UIView? = nil, constraints: [Constraint]) {
        if let view = view {
            insertSubview(other, belowSubview: view)
        } else {
            addSubview(other)
        }
        
        other.translatesAutoresizingMaskIntoConstraints = false
        pin(to: other, constraints: constraints)
    }
    
    public func pin(to other: UIView, constraints: [Constraint]) {
        NSLayoutConstraint.activate(constraints.map { $0(self, other) })
    }
    
}
