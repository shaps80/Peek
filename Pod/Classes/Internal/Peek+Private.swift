//
//  Internal.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

let PeekPropertyDefaultCellHeight: CGFloat = 36

final class PeekContext: Context {
  
  @objc private(set) var properties = [Property]()
  
  @objc func configure(inspector: Inspector, _ category: String, @noescape configuration: (config: Configuration) -> Void) {
    let config = PeekConfiguration(category: category, inspector: inspector)
    configuration(config: config)
    properties.appendContentsOf(config.properties)
  }
  
}

final class PeekConfiguration: Configuration {
  
  private var category: String
  private var inspector: Inspector
  private(set) var properties = [Property]()
  
  init(category: String, inspector: Inspector) {
    self.category = category
    self.inspector = inspector
  }
  
  @objc func addProperty(keyPath: String, displayName: String? = nil, cellConfiguration: PropertyCellConfiguration = nil) -> Property {
    let property = PeekProperty(keyPath: keyPath, displayName: displayName, category: category, inspector: inspector, configuration: cellConfiguration)
    properties.append(property)
    return property
  }
  
  @objc func addProperty(value value: AnyObject?, displayName: String?, cellConfiguration: PropertyCellConfiguration) -> Property {
    let property = PeekProperty(keyPath: "", displayName: displayName, value: value, category: category, inspector: inspector, configuration: cellConfiguration)
    properties.append(property)
    return property
  }
  
  @objc func addProperties(keyPaths: [String]) -> [Property] {
    var properties = [Property]()
    keyPaths.forEach { properties.append(addProperty($0)) }
    return properties
  }
  
}

final class PeekProperty: Property, CustomStringConvertible, Equatable {
  
  @objc weak var value: AnyObject?
  @objc let keyPath: String
  @objc let displayName: String
  @objc let category: String
  @objc let inspector: Inspector
  @objc var configurationBlock: PropertyCellConfiguration
  @objc var cellHeight: CGFloat = 0
  
  var description: String {
    return "keyPath: \(keyPath)"
  }
  
  @objc init(keyPath: String, displayName: String?, value: AnyObject? = nil, category: String, inspector: Inspector, configuration: PropertyCellConfiguration = nil) {
    self.value = value
    self.keyPath = keyPath
    self.displayName = displayName ?? String.capitalized(keyPath)
    self.category = category
    self.inspector = inspector
    self.configurationBlock = configuration
  }
  
  @objc func value(forModel model: AnyObject) -> AnyObject? {
    if let value = self.value {
      return value
    } else {
      return model.valueForKeyPath(keyPath)
    }
  }
  
}

func ==(lhs: PeekProperty, rhs: PeekProperty) -> Bool {
  return lhs.keyPath == rhs.keyPath && lhs.category == rhs.category && lhs.inspector == rhs.inspector
}
