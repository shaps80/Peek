//
//  Coordinator.swift
//  Peek
//
//  Created by Shaps Benkau on 24/02/2018.
//

import Foundation

@objc public protocol Coordinator: class {
    @discardableResult
    func appendDynamic(keyPaths: [String], forModel model: Peekable, in group: Group) -> Coordinator
    @discardableResult
    func appendDynamic(keyPathToName mapping: [[String: String]], forModel model: Peekable, in group: Group) -> Coordinator
    @discardableResult
    func appendStatic(keyPath: String, title: String, detail: String?, value: Any?, in group: Group) -> Coordinator
    @discardableResult
    func appendPreview(image: UIImage, forModel model: Peekable) -> Coordinator
    @discardableResult
    func appendTransformed(keyPaths: [String], valueTransformer: AttributeValueTransformer?, forModel model: Peekable, in group: Group) -> Coordinator
}

internal protocol SwiftCoordinator: Coordinator {
    @discardableResult
    func appendEnum<T>(keyPath: String..., into: T.Type, forModel model: Peekable, group: Group) -> Self where T: RawRepresentable & PeekDescribing & Hashable, T.RawValue == Int
}

internal final class PeekCoordinator: SwiftCoordinator {
    
    internal unowned let model: Peekable
    internal private(set) var groupsMapping: [Group: PeekGroup] = [:]
    
    internal init(model: Peekable) {
        self.model = model
    }
    
    internal func appendPreview(image: UIImage, forModel model: Peekable) -> Coordinator {
        guard image.size.width > 0 && image.size.height > 0 else { return self }
        
        let peekGroup = groupsMapping[.preview] ?? Group.preview.peekGroup()
        groupsMapping[.preview] = peekGroup
        peekGroup.attributes.insert(PreviewAttribute(image: image), at: 0)
        
        return self
    }
    
    internal func appendDynamic(keyPaths: [String], forModel model: Peekable, in group: Group) -> Coordinator {
        return appendTransformed(keyPaths: keyPaths, valueTransformer: nil, forModel: model, in: group)
    }
    
    internal func appendDynamic(keyPathToName mapping: [[String : String]], forModel model: Peekable, in group: Group) -> Coordinator {
        let peekGroup = groupsMapping[group] ?? group.peekGroup()
        groupsMapping[group] = peekGroup
        
        peekGroup.attributes.insert(contentsOf: mapping.map {
            DynamicAttribute(title: $0.values.first!, keyPath: $0.keys.first!, model: model)
        }, at: peekGroup.attributes.count)
        
        return self
    }
    
    internal func appendStatic(keyPath: String, title: String, detail: String? = nil, value: Any?, in group: Group) -> Coordinator {
        let peekGroup = groupsMapping[group] ?? group.peekGroup()
        groupsMapping[group] = peekGroup
        
        let attribute = StaticAttribute(keyPath: keyPath, title: title, detail: detail, value: value)
        peekGroup.attributes.insert(attribute, at: peekGroup.attributes.count)
        
        return self
    }
    
    internal func appendTransformed(keyPaths: [String], valueTransformer: AttributeValueTransformer?, forModel model: Peekable, in group: Group) -> Coordinator {
        let peekGroup = groupsMapping[group] ?? group.peekGroup()
        groupsMapping[group] = peekGroup
        
        peekGroup.attributes.insert(contentsOf: keyPaths.map {
            DynamicAttribute(title: String.capitalized($0), detail: nil, keyPath: $0, model: model, valueTransformer: valueTransformer)
        }, at: peekGroup.attributes.count)
        
        return self
    }
    
    internal func appendEnum<T>(keyPath: String..., into: T.Type, forModel model: Peekable, group: Group) -> Self where T: RawRepresentable & PeekDescribing & Hashable, T.RawValue == Int {
        let peekGroup = groupsMapping[group] ?? group.peekGroup()
        groupsMapping[group] = peekGroup
        
        peekGroup.attributes.insert(contentsOf: keyPath.map {
            EnumAttribute<T>(title: String.capitalized($0), detail: nil, keyPath: $0, model: model, valueTransformer: nil)
        }, at: peekGroup.attributes.count)
        
        return self
    }
    
}

extension PeekCoordinator: CustomStringConvertible {
    
    internal var description: String {
        return """
        \(type(of: self))
        \(groupsMapping.values.map { "▹ \($0)" }.joined(separator: "\n"))
        """
    }
    
}
