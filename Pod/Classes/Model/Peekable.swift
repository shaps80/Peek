/*
 Copyright © 23/04/2016 Shaps
 
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

/**
 Defines a view or object that Peek can provide inspectors for
 Represents a type that can be inspected by Peek.
 
 @note
 Currently this requires conformance to NSObjectProtocol since
 KVC is heavily used by Peek Inspectors.
 */
@objc public protocol Peekable: NSObjectProtocol {
    
    /// Overide this in your NSObject subclass to provide custom attributes for Peek to inspect.
    ///
    /// - Parameter coordinator: The coordinator is your interface into Peek's running instance.
    func preparePeek(with coordinator: Coordinator)
    
    /**
     @see `NSObject` `classForCoder` documentation
     */
    var classForCoder: AnyClass { get }
    
    /**
     @see `NSObject` `value(forKeyPath:)` documentation
    */
    func value(forKeyPath: String) -> Any?
}

@objc internal protocol InternalPeekable: Peekable {
    
    /**
     This value is used to determine where nested inspection is possible.
     Common examples are fonts, colors, constraints, etc...
     To enable nested inspection of a new type, override this value and return true.
     */
    var isLeaf: Bool { get }
    
    /**
     Some views contain other views, for example a button or slider.
     When inspecting your UI its often simpler to reveal only the button
     and then perform deeper inspection via Peek's Inspectors.
     To enable this behaviour, override this value and return true.
     */
    var isComponent: Bool { get }
    
    /**
     This value will be used to populate the title of your report for the
     selected view.
     
     @note
     This value may be a concatenation of similar titles
     to indicate the path of the current value.
     
     @example
     `TimelineViewController ▹ Button ▹ TintColor`
     */
    var reportTitle: String { get }
    
    /// Return true if this object should be visible in Peek's overlay selector
    ///
    /// - Parameter options: The current options for Peek
    /// - Returns: True if this object should be visible in Peek's overlay. False otherwise.
//    func isVisibleInOverlay(options: PeekOptions) -> Bool
    
}

extension CALayer { override var isLeaf: Bool { return false } }
extension UIView { override var isLeaf: Bool { return false } }
extension UIColor { override var isLeaf: Bool { return false } }
extension UIImage { override var isLeaf: Bool { return false } }
extension UIFont { override var isLeaf: Bool { return false } }
extension UIFontDescriptor { override var isLeaf: Bool { return false } }
extension UIBarButtonItem { override var isLeaf: Bool { return false } }
extension NSLayoutConstraint { override var isLeaf: Bool { return false } }
extension NSAttributedString { override var isLeaf: Bool { return false } }
extension UIViewController { override var isLeaf: Bool { return false } }
extension UIScreen { override var isLeaf: Bool { return false } }
extension UIDevice { override var isLeaf: Bool { return false } }
extension UIApplication { override var isLeaf: Bool { return false } }
extension Bundle { override var isLeaf: Bool { return false } }
extension NSShadow { override var isLeaf: Bool { return false } }

extension UISwitch { override var isComponent: Bool { return true } }
extension UISlider { override var isComponent: Bool { return true } }
extension UIButton { override var isComponent: Bool { return true } }
extension UIStepper { override var isComponent: Bool { return true } }
extension UITextField { override var isComponent: Bool { return true } }
extension UITextView { override var isComponent: Bool { return true } }
extension UIPageControl { override var isComponent: Bool { return true } }
extension UIProgressView { override var isComponent: Bool { return true } }
extension UIActivityIndicatorView { override var isComponent: Bool { return true } }
extension UISegmentedControl { override var isComponent: Bool { return true } }
extension UIDatePicker { override var isComponent: Bool { return true } }

extension NSObject: InternalPeekable {
    
    @objc internal var isLeaf: Bool { return true }
    @objc internal var isComponent: Bool { return false }
    @objc open func preparePeek(with coordinator: Coordinator) { }
    
    @objc internal var reportTitle: String {
        if let view = self as? UIView {
            return "\(String(describing: view.owningViewController()!.classForCoder)) ▹ \(String(describing: classForCoder))"
        } else {
            return "\(String(describing: classForCoder))"
        }
    }
    
    @objc internal func isVisibleInOverlay(options: PeekOptions) -> Bool { return false }
    
    /**
     Determines if Peek should ignore this type when parsing it into a model
     
     - parameter peek: The Peek instance
     
     - returns: Returns true if Peek should ignore this type, false otherwise
     */
    @available(*, obsoleted: 5.0.1, message: "Overriding this method no longer has any impact on Peek's inspection")
    @objc public func shouldIgnore(options: PeekOptions) -> Bool { return false }
}
