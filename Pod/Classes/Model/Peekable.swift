/*
  Copyright © 23/04/2016 Snippex

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

public protocol Peekable: NSObjectProtocol {
  var classForCoder: AnyClass { get }
  
  func preparePeek(context: Context)
  func shouldIgnore(inPeek peek: Peek) -> Bool
}

extension NSObject: Peekable {
  public func preparePeek(context: Context) { }
}

extension Peekable {
  
  public func shouldIgnore(inPeek peek: Peek) -> Bool {
    return false
  }
  
}

extension UIView {
  
  public func shouldIgnore(inPeek peek: Peek) -> Bool {
    let isContainer = isMemberOfClass(UIView) && subviews.count > 0
    if isContainer && peek.options.shouldIgnoreContainers { return true }
    
    let isInvisible = hidden || alpha == 0 || CGRectEqualToRect(frame, CGRectZero)
    if isInvisible { return true }
    
    let isTableViewOrCell = isMemberOfClass(UITableViewCell) || isMemberOfClass(UITableView)
    if isTableViewOrCell { return true }
    
    let isCollectionView = isMemberOfClass(UICollectionView)
    if isCollectionView { return true }
    
    let isFullScreen = CGRectEqualToRect(frame, window?.bounds ?? UIScreen.mainScreen().bounds)
    if isFullScreen { return true }
    
    let isInternalSuperviewClass = self.superview?.ObjClassName().hasPrefix("_") ?? false
    if isInternalSuperviewClass { return true }
    
    let blacklist = [ "UINavigationItemView", "UIPickerTableView", "UIPickerColumnView" ]
    let isInternalClass = ObjClassName().hasPrefix("_") || blacklist.contains(ObjClassName())
    if isInternalClass { return true }
    
    let invalidContainerClassNames = [ "UINavigationButton" ]
    var superview = self.superview
    
    while superview != nil {
      if superview is PeekContainer {
        return true
      }
      
      // also need to check private internal classes
      for className in invalidContainerClassNames {
        if let klass = NSClassFromString(className) {
          if superview?.isMemberOfClass(klass) ?? false {
            return true
          }
        }
      }
      
      superview = superview?.superview
    }
    
    return false
  }
  
}

public protocol PeekSubPropertiesSupporting {
  var hasProperties: Bool { get }
}

extension PeekSubPropertiesSupporting {
  public var hasProperties: Bool { return true }
}

extension Array: PeekSubPropertiesSupporting {
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
extension Segment: PeekSubPropertiesSupporting { }

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