//
//  Coordinator.swift
//  Peek
//
//  Created by Shaps Benkau on 24/02/2018.
//

import Foundation

@objc public protocol Coordinator: class {
    func appendDynamic(keyPaths: [String], forModel model: Model, in group: Group)
    func appendDynamic(keyPathToName mapping: [[String: String]], forModel model: Model, in group: Group)
    func appendTransformed(keyPaths: [String], valueTransformer: AttributeValueTransformer?, forModel model: Model, in group: Group)
    func appendStatic(title: String, detail: String?, value: Any?, in group: Group)
    func appendPreview(image: UIImage, forModel model: Model)
}

internal final class PeekCoordinator: Coordinator, CustomStringConvertible {
    
    internal private(set) var groupsMapping: [Group: PeekGroup] = [:]
    
    internal func appendPreview(image: UIImage, forModel model: Model) {
        let peekGroup = groupsMapping[.preview] ?? PeekGroup.make(from: .preview)
        groupsMapping[.preview] = peekGroup
        
        peekGroup.attributes.append(
            PreviewAttribute(image: image)
        )
    }
    
    func appendTransformed(keyPaths: [String], valueTransformer: AttributeValueTransformer?, forModel model: Model, in group: Group) {
        let peekGroup = groupsMapping[group] ?? PeekGroup.make(from: group)
        groupsMapping[group] = peekGroup
        
        peekGroup.attributes.append(contentsOf: keyPaths.map {
            DynamicAttribute(title: String.capitalized($0), detail: nil, keyPath: $0, model: model, valueTransformer: valueTransformer)
        })
    }
    
    internal func appendDynamic(keyPaths: [String], forModel model: Model, in group: Group) {
        appendTransformed(keyPaths: keyPaths, valueTransformer: nil, forModel: model, in: group)
    }
    
    internal func appendDynamic(keyPathToName mapping: [[String : String]], forModel model: Model, in group: Group) {
        let peekGroup = groupsMapping[group] ?? PeekGroup.make(from: group)
        groupsMapping[group] = peekGroup
        
        peekGroup.attributes.append(contentsOf: mapping.map {
            DynamicAttribute(title: $0.values.first!, keyPath: $0.keys.first!, model: model)
        })
    }
    
    internal func appendStatic(title: String, detail: String? = nil, value: Any?, in group: Group) {
        let peekGroup = groupsMapping[group] ?? PeekGroup.make(from: group)
        groupsMapping[group] = peekGroup
        
        let attribute = StaticAttribute(title: title, detail: detail, value: value)
        peekGroup.attributes.append(attribute)
    }
    
    internal var description: String {
        return """
        \(type(of: self))
        \(groupsMapping.values.map { "▹ \($0)" }.joined(separator: "\n"))
        """
    }
    
}
