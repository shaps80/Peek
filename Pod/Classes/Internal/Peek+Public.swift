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

struct ContextAssociationKey {
  static var Inspectors: UInt8 = 1
}

@objc public enum InspectorSet: Int {
  case Primary = 1
  case Secondary = 2
}

extension InspectorSet {
  
  func inspectors() -> [Inspector] {
    if self == .Primary {
      return [ .Attributes, .View, .Layer, .Layout, .Controller ]
    } else {
      return [ .Application, .Device, .Screen ]
    }
  }
  
}

@objc public enum Inspector: Int {
  case Attributes
  case View
  case Layer
  case Layout
  case Controller
  
  case Application
  case Device
  case Screen
}

extension Inspector: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Attributes: return "Attributes"
    case .View: return "View"
    case .Layer: return "Layer"
    case .Layout: return "Layout"
    case .Controller: return "Controller"
      
    case .Application: return "Application"
    case .Device: return "Device"
    case .Screen: return "Screen"
    }
  }
  
}

extension Inspector {
  
  public var image: UIImage? {
    return Images.inspectorImage(self)
  }
  
}

@objc public protocol Configuration: class {
  func addProperties(keyPaths: [String]) -> [Property]
  func addProperty(keyPath: String, displayName: String?, cellConfiguration: PropertyCellConfiguration) -> Property
  func addProperty(value value: AnyObject?, displayName: String?, cellConfiguration: PropertyCellConfiguration) -> Property
}

@objc public protocol Context: class {
  var properties: [Property] { get }
  func configure(inspector: Inspector, _ category: String, @noescape configuration: (config: Configuration) -> Void)
}

public typealias PropertyCellConfiguration = ((cell: UITableViewCell, object: AnyObject, value: AnyObject) -> Void)?

@objc public protocol Property: class {
  
  weak var value: AnyObject? { get set }
  var keyPath: String { get }
  var displayName: String { get }
  var category: String { get }
  var inspector: Inspector { get }
  var configurationBlock: PropertyCellConfiguration { get }
  var cellHeight: CGFloat { get set }
  
  init(keyPath: String, displayName: String?, value: AnyObject?, category: String, inspector: Inspector, configuration: PropertyCellConfiguration)
  
  func value(forModel model: AnyObject) -> AnyObject?
  
}