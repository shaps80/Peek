/*
 Copyright © 18/10/2017 Shaps
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

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
