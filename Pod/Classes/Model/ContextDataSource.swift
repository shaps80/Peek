//
//  Context+DataSource.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import Foundation

final class ContextDataSource {
  
  let inspectorType: Inspector
  private var categories: [String]
  private var properties: [Property]
  private var categoryProperties = [[Property]]()
  
  init(context: Context, inspector: Inspector) {
    inspectorType = inspector
    properties = context.properties.filter { $0.inspector == inspector }
    categories = Array(Set(properties
      .map { $0.category }))
      .sort()
    
    categories.forEach { category in
      categoryProperties.append(
        properties
          .filter { $0.category == category }
          .sort { return $0.displayName < $1.displayName }
      )
    }
  }
  
  func propertyForIndexPath(indexPath: NSIndexPath) -> Property {
    return categoryProperties[indexPath.section][indexPath.item]
  }
  
  func numberOfCategories() -> Int {
    return categoryProperties.count
  }
  
  func numberOfProperties(inCategory category: Int) -> Int {
    return categoryProperties[category].count
  }
  
  func titleForCategory(category: Int) -> String {
    return categories[category]
  }
  
}
