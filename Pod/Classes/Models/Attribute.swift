//
//  Attribute.swift
//  Peek
//
//  Created by Shaps Benkau on 21/02/2018.
//

import Foundation

@objc public protocol Attribute: class {
    var title: String { get }
    var detail: String? { get }
    var value: Any? { get }
}

internal final class PreviewAttribute: Attribute {
    
    internal let title: String
    internal let detail: String? = nil
    internal let value: Any?
    
    internal var image: UIImage? {
        return value as? UIImage
    }
    
    internal init(image: UIImage) {
        title = ""
        value = image
    }
    
}

internal final class DynamicAttribute: Attribute, CustomStringConvertible, Equatable {
    
    internal let keyPath: String
    internal let title: String
    internal let detail: String?
    internal var previewImage: UIImage? = nil
    internal private(set) weak var model: Model?
    
    internal var value: Any? {
        return model?.value(forKeyPath: keyPath)
    }
    
    internal init(title: String?, detail: String? = nil, keyPath: String, model: Model) {
        self.title = title ?? String.capitalized(keyPath)
        self.detail = detail
        self.keyPath = keyPath
        self.model = model
    }
    
    internal var description: String {
        return "\(title) – \(keyPath) | \(value == nil ? "nil" : value!)"
    }
    
    internal static func ==(lhs: DynamicAttribute, rhs: DynamicAttribute) -> Bool {
        return lhs.model === rhs.model && lhs.keyPath == rhs.keyPath
    }
    
}

internal final class StaticAttribute: Attribute, CustomStringConvertible, Equatable {
    
    internal let title: String
    internal let detail: String?
    internal let value: Any?
    internal var previewImage: UIImage? = nil
    
    init(title: String, detail: String? = nil, value: Any?) {
        self.title = title
        self.detail = detail
        self.value = value
    }
    
    internal var description: String {
        return "\(title) – \(value == nil ? "nil" : value!)"
    }
    
    internal static func ==(lhs: StaticAttribute, rhs: StaticAttribute) -> Bool {
        return lhs.title == rhs.title
    }
    
}
