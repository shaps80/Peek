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
    var classForCoder: AnyClass { get }
    
    func shouldIgnore(options: PeekOptions) -> Bool
    func preparePeek(with coordinator: Coordinator)
    func titleForPeekReport() -> String
}

@objc public protocol PeekableContainer: Peekable { }

extension CALayer: PeekableContainer { }
extension UIView: PeekableContainer { }
extension UIColor: PeekableContainer { }
extension UIImage: PeekableContainer { }
extension UIFont: PeekableContainer { }
extension UIFontDescriptor: PeekableContainer { }
extension UIBarButtonItem: PeekableContainer { }
extension NSLayoutConstraint: PeekableContainer { }
extension NSAttributedString: PeekableContainer { }
extension UIViewController: PeekableContainer { }
extension UIScreen: PeekableContainer { }
extension UIDevice: PeekableContainer { }
extension UIApplication: PeekableContainer { }
extension Bundle: PeekableContainer { }
extension NSShadow: PeekableContainer { }
extension NSString: PeekContainer { }

extension NSObject: Peekable {
    
    /**
     Gives the caller an opportunity to configure Peek with additional attributes
     
     - parameter coordinator: The coordinator to prepare
     */
    @objc open func preparePeek(with coordinator: Coordinator) { }
    
    @objc public func titleForPeekReport() -> String {
        if let view = self as? UIView {
            return "\(String(describing: view.owningViewController()!.classForCoder)) > \(String(describing: classForCoder))"
        } else {
            return "\(String(describing: classForCoder))"
        }
    }
    
    /**
     Determines if Peek should ignore this type when parsing it into a model
     
     - parameter peek: The Peek instance
     
     - returns: Returns true if Peek should ignore this type, false otherwise
     */
    public func shouldIgnore(options: PeekOptions) -> Bool {
        return false
    }
}

extension UIView {
    
    /**
     Determines if Peek should ignore this view when parsing it into a model
     
     - parameter peek: The Peek instance
     
     - returns: Returns true if Peek should ignore this view, false otherwise
     */
    public override func shouldIgnore(options: PeekOptions) -> Bool {
        let isContainer = isMember(of: UIView.self) && subviews.count > 0
        if isContainer && options.ignoresContainerViews { return true }
        
        let isInvisible = isHidden || alpha == 0 || frame.equalTo(CGRect.zero)
        if isInvisible { return true }
        
        let isTableViewOrCell = isMember(of: UITableViewCell.self) || isMember(of: UITableView.self)
        if isTableViewOrCell { return true }
        
        let isCollectionView = isMember(of: UICollectionView.self)
        if isCollectionView { return true }
        
        let isFullScreen = frame.equalTo(window?.bounds ?? UIScreen.main.bounds)
        if isFullScreen { return true }
        
        if let superview = self.superview, String(describing: superview.classForCoder).hasPrefix("_") {
            return true
        }
        
        let blacklist = [ "UINavigationItemView", "UIPickerTableView", "UIPickerColumnView", "UITableViewCellContentView" ]
        let isInternalClass = String(describing: classForCoder).hasPrefix("_") || blacklist.contains(String(describing: classForCoder))
        if isInternalClass {
            return true
        }
        
        let invalidContainerClassNames = [ "UINavigationButton" ]
        var superview = self.superview
        
        while superview != nil {
            if superview is PeekContainer {
                return true
            }
            
            // also need to check private internal classes
            for className in invalidContainerClassNames {
                if let klass = NSClassFromString(className) {
                    if superview?.isMember(of: klass) ?? false {
                        return true
                    }
                }
            }
            
            superview = superview?.superview
        }
        
        return false
    }
    
}

// This is a BAD name. What we really want to articulate here is that the scanner should stop at these views and not recurse deeper. Effectively treating these views as a leaf
public protocol PeekContainer { }

extension UISwitch: PeekContainer { }
extension UISlider: PeekContainer { }
extension UIButton: PeekContainer { }
extension UIStepper: PeekContainer { }
extension UITextField: PeekContainer { }
extension UITextView: PeekContainer { }
extension UIPageControl: PeekContainer { }
extension UIProgressView: PeekContainer { }
extension UIActivityIndicatorView: PeekContainer { }
extension UISegmentedControl: PeekContainer { }
extension UIDatePicker: PeekContainer { }
