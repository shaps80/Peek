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

import Foundation

/// Provides a data-source for representing properties in a Context -- used by InspectorViewController 
final class ContextDataSource {
    
    let inspectorType: Inspector
    fileprivate var categories: [String]
    fileprivate var properties: [Property]
    fileprivate var categoryProperties = [[Property]]()
    
    init(context: Context, inspector: Inspector) {
        inspectorType = inspector
        properties = context.properties.filter { $0.inspector == inspector }
        categories = Array(Set(properties
            .map { $0.category }))
            .sorted()
        
        categories.forEach { category in
            categoryProperties.append(
                properties
                    .filter { $0.category == category }
//                    .sorted { return $0.displayName < $1.displayName }
            )
        }
    }
    
    func propertyForIndexPath(_ indexPath: IndexPath) -> Property {
        return categoryProperties[indexPath.section][indexPath.item]
    }
    
    func numberOfCategories() -> Int {
        return categoryProperties.count
    }
    
    func numberOfProperties(inCategory category: Int) -> Int {
        return categoryProperties[category].count
    }
    
    func titleForCategory(_ category: Int) -> String {
        return categories[category]
    }
    
}
