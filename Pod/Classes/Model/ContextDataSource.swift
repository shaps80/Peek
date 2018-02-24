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
internal final class ContextDataSource {
    
    private let inspectorType: Inspector
    internal private(set) var sections: [Section]
    
    internal init(context: Context, inspector: Inspector) {
        inspectorType = inspector
        
        let properties = context.properties
        let categories = Array(Set(properties
            .filter { $0.inspector == inspector }
            .map { $0.category }))
            .sorted()
        
        sections = categories.map { category in
            let items = properties
                .filter { $0.category == category }
                .sorted(by: { $0.displayName < $1.displayName })
                .map { Item(title: $0.displayName, property: $0) }
            
            return Section(title: category, items: items, isExpanded: true)
        }
    }
    
    internal func property(at indexPath: IndexPath) -> Property {
        return sections[indexPath.section].items[indexPath.item].property
    }
    
    internal func setExpanded(_ expanded: Bool, for section: Int) {
        sections[section].isExpanded = expanded
    }
    
    internal func toggleVisibility(forSection section: Int) {
        sections[section].isExpanded = !sections[section].isExpanded
    }
    
}
