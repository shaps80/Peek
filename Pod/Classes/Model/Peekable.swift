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
@objc public protocol Peekable: class {
  var classForCoder: AnyClass { get }
  func preparePeek(_ context: Context)
  func shouldIgnore(options: PeekOptions) -> Bool
}

//extension NSObject: Peekable {
//  
//  /**
//   Gives the caller an opportunity to configure Peek's current context
//   
//   - parameter context: The context to configure
//   */
//  public func preparePeek(_ context: Context) { }
//}

extension Peekable {
  
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
  public func shouldIgnore(options: PeekOptions) -> Bool {
    let isContainer = isMember(of: UIView.self) && subviews.count > 0
    if isContainer && options.shouldIgnoreContainers { return true }
    
    let isInvisible = isHidden || alpha == 0 || frame.equalTo(CGRect.zero)
    if isInvisible { return true }
    
    let isTableViewOrCell = isMember(of: UITableViewCell.self) || isMember(of: UITableView.self)
    if isTableViewOrCell { return true }
    
    let isCollectionView = isMember(of: UICollectionView.self)
    if isCollectionView { return true }
    
    let isFullScreen = frame.equalTo(window?.bounds ?? UIScreen.main.bounds)
    if isFullScreen { return true }
    
    let isInternalSuperviewClass = self.superview?.ObjClassName().hasPrefix("_") ?? false
    if isInternalSuperviewClass {
        return true	
    }
    
    let blacklist = [ "UINavigationItemView", "UIPickerTableView", "UIPickerColumnView" ]
    let isInternalClass = ObjClassName().hasPrefix("_") || blacklist.contains(ObjClassName())
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

/**
 *  Defines a Peek type that supports sub-properties -- this allows Peek to determine when nested properties should be used
 */
public protocol PeekSubPropertiesSupporting {
  var hasProperties: Bool { get }
}

extension PeekSubPropertiesSupporting {
  
    /// Returns true when this type contains sub-properties
  public var hasProperties: Bool { return true }
  
}

extension Array: PeekSubPropertiesSupporting {
  
    /// Returns true when this array's count > 0
  public var hasProperties: Bool {
    return count > 0
  }
  
}

extension NSArray: PeekSubPropertiesSupporting { }
extension CGColor: PeekSubPropertiesSupporting { }
extension UIColor: PeekSubPropertiesSupporting { }
extension UIButton: PeekSubPropertiesSupporting { }
extension UIImage: PeekSubPropertiesSupporting { }
extension UIImageView: PeekSubPropertiesSupporting { }
extension UIFont: PeekSubPropertiesSupporting { }
extension UISegmentedControl: PeekSubPropertiesSupporting { }
extension UILabel: PeekSubPropertiesSupporting { }
extension UIBarButtonItem: PeekSubPropertiesSupporting { }
extension NSLayoutConstraint: PeekSubPropertiesSupporting { }
//extension Segment: PeekSubPropertiesSupporting { }
extension NSAttributedString: PeekSubPropertiesSupporting { }
extension NSShadow: PeekSubPropertiesSupporting { }



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
