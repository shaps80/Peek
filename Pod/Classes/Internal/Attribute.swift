//
//  Attribute.swift
//  Peek
//
//  Created by Shaps Benkau on 21/02/2018.
//

import Foundation

@objc public enum Group: Int {
    case appearance
    case layout
    case classes
}

@objc public protocol Coordinator: class {
    func append(keyPaths: [String], forModel model: Model, in group: Group)
    func append(keyPathToName mapping: [[String: String]], forModel model: Model, in group: Group)
    func append(displayName: String, value: Any?, in group: Group)
}

internal final class PeekGroup: Hashable, CustomStringConvertible {
    
    internal let title: String
    internal var attributes: [Attribute]
    
    internal init(title: String) {
        self.title = title
        self.attributes = []
    }
    
    internal var hashValue: Int {
        return title.hashValue
    }
    
    internal static func ==(lhs: PeekGroup, rhs: PeekGroup) -> Bool {
        return lhs.title == rhs.title
    }
    
    public var description: String {
        return """
        \(title)
        \(attributes.map { "  ▹ \($0)" }.joined(separator: "\n"))
        """
    }
    
}

extension PeekGroup {
    
    public static var appearance = { PeekGroup(title: "Appearance") }
    public static var layout = { PeekGroup(title: "Layout") }
    public static var classes = { PeekGroup(title: "Classes") }
    
    public static func make(from group: Group) -> PeekGroup {
        switch group {
        case .appearance: return .appearance()
        case .layout: return .layout()
        case .classes: return .classes()
        }
    }
    
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

@objc internal protocol Attribute: class {
    var displayName: String { get }
    var value: Any? { get }
}

internal final class DynamicAttribute: Attribute, CustomStringConvertible, Equatable {
    
    internal let keyPath: String
    internal let displayName: String
    internal private(set) weak var model: Model?
    
    internal var value: Any? {
        return model?.value(forKeyPath: keyPath)
    }
    
    internal init(displayName: String?, keyPath: String, model: Model) {
        self.displayName = displayName ?? String.capitalized(keyPath)
        self.keyPath = keyPath
        self.model = model
    }
    
    internal var description: String {
        return "\(displayName) – \(keyPath) | \(value == nil ? "nil" : value!)"
    }
    
    internal static func ==(lhs: DynamicAttribute, rhs: DynamicAttribute) -> Bool {
        return lhs.model === rhs.model && lhs.keyPath == rhs.keyPath
    }
    
}

internal final class StaticAttribute: Attribute, CustomStringConvertible, Equatable {
    
    internal let displayName: String
    internal let value: Any?
    
    init(displayName: String, value: Any?) {
        self.displayName = displayName
        self.value = value
    }
    
    internal var description: String {
        return "\(displayName) – \(value == nil ? "nil" : value!)"
    }
    
    internal static func ==(lhs: StaticAttribute, rhs: StaticAttribute) -> Bool {
        return lhs.displayName == rhs.displayName
    }
    
}
