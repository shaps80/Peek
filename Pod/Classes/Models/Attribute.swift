//
//  Attribute.swift
//  Peek
//
//  Created by Shaps Benkau on 21/02/2018.
//

import Foundation

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
