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
    
    internal private(set) var sections: [Section]
    
    internal init(coordinator: PeekCoordinator) {
        let groups = Group.all
        
        sections = groups.flatMap { group in
            guard let peekGroup = coordinator.groupsMapping[group] else { return nil }
            
            let items = peekGroup.attributes
                .map { Item(title: $0.title, attribute: $0) }
            
            return Section(title: peekGroup.title, items: items, isExpanded: peekGroup.isExpandedByDefault)
        }
    }
    
    internal func attribute(at indexPath: IndexPath) -> Attribute {
        return sections[indexPath.section].items[indexPath.item].attribute
    }
    
    internal func setExpanded(_ expanded: Bool, for section: Int) {
        sections[section].isExpanded = expanded
    }
    
    internal func toggleVisibility(forSection section: Int) {
        sections[section].isExpanded = !sections[section].isExpanded
    }
    
}
