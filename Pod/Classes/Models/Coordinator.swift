//
//  Coordinator.swift
//  Peek
//
//  Created by Shaps Benkau on 24/02/2018.
//

import Foundation

@objc public protocol Coordinator: class {
    func append(keyPaths: [String], forModel model: Model, in group: Group)
    func append(keyPathToName mapping: [[String: String]], forModel model: Model, in group: Group)
    func append(displayName: String, value: Any?, in group: Group)
}

internal final class PeekCoordinator: Coordinator, CustomStringConvertible {
    
    internal private(set) var groups: [Group: PeekGroup] = [:]
    
    internal func append(keyPaths: [String], forModel model: Model, in group: Group) {
        let peekGroup = groups[group] ?? PeekGroup.make(from: group)
        groups[group] = peekGroup
        
        peekGroup.attributes.append(contentsOf: keyPaths.map {
            DynamicAttribute(displayName: String.capitalized($0), keyPath: $0, model: model)
        })
    }
    
    internal func append(keyPathToName mapping: [[String : String]], forModel model: Model, in group: Group) {
        let peekGroup = groups[group] ?? PeekGroup.make(from: group)
        groups[group] = peekGroup
        
        peekGroup.attributes.append(contentsOf: mapping.map {
            DynamicAttribute(displayName: $0.values.first!, keyPath: $0.keys.first!, model: model)
        })
    }
    
    internal func append(displayName: String, value: Any?, in group: Group) {
        let peekGroup = groups[group] ?? PeekGroup.make(from: group)
        groups[group] = peekGroup
        
        let attribute = StaticAttribute(displayName: displayName, value: value)
        peekGroup.attributes.append(attribute)
    }
    
    internal var description: String {
        return """
        \(type(of: self))
        \(groups.map { "▹ \($0)" }.joined(separator: "\n"))
        """
    }
    
}
