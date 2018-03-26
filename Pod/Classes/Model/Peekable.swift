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
 *  Defines a view or object that Peek can provide inspectors for
 */
@objc public protocol Peekable: NSObjectProtocol {
    func shouldIgnore(options: PeekOptions) -> Bool
    func preparePeek(with coordinator: Coordinator)
    
    var classForCoder: AnyClass { get }
    func value(forKeyPath: String) -> Any?
}

@objc internal protocol InternalPeekable: Peekable {
    var isLeaf: Bool { get }
    var isComponent: Bool { get }
    var reportTitle: String { get }
}

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
    
    /**
     Determines if Peek should ignore this type when parsing it into a model
     
     - parameter peek: The Peek instance
     
     - returns: Returns true if Peek should ignore this type, false otherwise
     */
    @objc open func shouldIgnore(options: PeekOptions) -> Bool {
        return false
    }
}
