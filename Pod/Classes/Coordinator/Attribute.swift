//
//  Attribute.swift
//  Peek
//
//  Created by Shaps Benkau on 21/02/2018.
//

import Foundation

public typealias AttributeValueTransformer = (Any?) -> Any?

@objc public protocol Attribute: class {
    var keyPath: String { get }
    var title: String { get }
    var detail: String? { get }
    var value: Any? { get }
    var alternateValues: [String] { get }
    var valueTransformer: AttributeValueTransformer? { get }
}

internal final class PreviewAttribute: Attribute {
    
    internal let keyPath: String
    internal let title: String
    internal let detail: String? = nil
    internal let value: Any?
    var alternateValues: [String] { return [] }
    internal let valueTransformer: AttributeValueTransformer?
    
    internal var image: UIImage? {
        return value as? UIImage
    }
    
    internal init(image: UIImage) {
        title = ""
        value = image
        valueTransformer = nil
        keyPath = "none"
    }
    
}

internal final class DynamicAttribute: Attribute, CustomStringConvertible, Equatable {
    
    internal let keyPath: String
    internal let title: String
    internal let detail: String?
    internal var previewImage: UIImage? = nil
    var alternateValues: [String] { return [] }
    internal private(set) weak var model: Peekable?
    
    internal let valueTransformer: AttributeValueTransformer?
    
    internal var value: Any? {
        return model?.value(forKeyPath: keyPath)
    }
    
    internal init(title: String?, detail: String? = nil, keyPath: String, model: Peekable, valueTransformer: AttributeValueTransformer? = nil) {
        self.title = title ?? String.capitalized(keyPath)
        self.detail = detail
        self.keyPath = keyPath
        self.model = model
        self.valueTransformer = valueTransformer
    }
    
    internal var description: String {
        return "\(title) – \(keyPath) | \(value == nil ? "nil" : value!)"
    }
    
    internal static func ==(lhs: DynamicAttribute, rhs: DynamicAttribute) -> Bool {
        return lhs.model === rhs.model && lhs.keyPath == rhs.keyPath
    }
    
}

internal final class StaticAttribute: Attribute, CustomStringConvertible, Equatable {
    
    internal let keyPath: String
    internal let title: String
    internal let detail: String?
    internal let value: Any?
    internal let valueTransformer: AttributeValueTransformer?
    var alternateValues: [String] { return [] }
    internal var previewImage: UIImage? = nil
    
    init(keyPath: String, title: String, detail: String? = nil, value: Any?, valueTransformer: AttributeValueTransformer? = nil) {
        self.keyPath = keyPath
        self.title = title
        self.detail = detail
        self.value = value
        self.valueTransformer = valueTransformer
    }
    
    internal var description: String {
        return "\(title) – \(keyPath) | \(value == nil ? "nil" : value!)"
    }
    
    internal static func ==(lhs: StaticAttribute, rhs: StaticAttribute) -> Bool {
        return lhs.title == rhs.title
    }
    
}

internal final class EnumAttribute<T>: Attribute, CustomStringConvertible, Equatable where T: RawRepresentable & PeekDescribing & Hashable, T.RawValue == Int {
    
    internal let keyPath: String
    internal let title: String
    internal let detail: String?
    internal private(set) weak var model: Peekable?
    
    internal let valueTransformer: AttributeValueTransformer?
    
    internal var alternateValues: [String] {
        return T.all.map { $0.displayName }
    }
    
    internal var value: Any? {
        guard let value = model?.value(forKeyPath: keyPath) as? Int,
            let enumRep = T(rawValue: value) as? PeekDescribing else {
                fatalError()
        }
        
        return enumRep.displayName
    }
    
    internal init(title: String?, detail: String? = nil, keyPath: String, model: Peekable, valueTransformer: AttributeValueTransformer? = nil) {
        self.title = title ?? String.capitalized(keyPath)
        self.detail = detail
        self.keyPath = keyPath
        self.model = model
        self.valueTransformer = valueTransformer
    }
    
    internal var description: String {
        return "\(title) – \(keyPath) | \(value == nil ? "nil" : value!)"
    }
    
    static func ==(lhs: EnumAttribute<T>, rhs: EnumAttribute<T>) -> Bool {
        return lhs.model === rhs.model && lhs.keyPath == rhs.keyPath
    }
    
}
