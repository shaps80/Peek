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
    func appendStatic(keyPath: String, title: String, detail: String?, value: Any?, in group: Group)
    func appendPreview(image: UIImage, forModel model: Model)
}

internal final class PeekCoordinator: Coordinator, CustomStringConvertible {
    
    internal unowned let model: Model
    internal private(set) var groupsMapping: [Group: PeekGroup] = [:]
    
    internal init(model: Model) {
        self.model = model
    }
    
    internal func appendPreview(image: UIImage, forModel model: Model) {
        guard image.size.width > 0 && image.size.height > 0 else { return }
        
        let peekGroup = groupsMapping[.preview] ?? Group.preview.peekGroup()
        groupsMapping[.preview] = peekGroup
        peekGroup.attributes.insert(PreviewAttribute(image: image), at: 0)
    }
    
    func appendTransformed(keyPaths: [String], valueTransformer: AttributeValueTransformer?, forModel model: Model, in group: Group) {
        let peekGroup = groupsMapping[group] ?? group.peekGroup()
        groupsMapping[group] = peekGroup

        peekGroup.attributes.insert(contentsOf: keyPaths.map {
            DynamicAttribute(title: String.capitalized($0), detail: nil, keyPath: $0, model: model, valueTransformer: valueTransformer)
        }, at: peekGroup.attributes.count)
    }
    
    internal func appendDynamic(keyPaths: [String], forModel model: Model, in group: Group) {
        appendTransformed(keyPaths: keyPaths, valueTransformer: nil, forModel: model, in: group)
    }
    
    internal func appendDynamic(keyPathToName mapping: [[String : String]], forModel model: Model, in group: Group) {
        let peekGroup = groupsMapping[group] ?? group.peekGroup()
        groupsMapping[group] = peekGroup
        
        peekGroup.attributes.insert(contentsOf: mapping.map {
            DynamicAttribute(title: $0.values.first!, keyPath: $0.keys.first!, model: model)
        }, at: peekGroup.attributes.count)
    }
    
    internal func appendStatic(keyPath: String, title: String, detail: String? = nil, value: Any?, in group: Group) {
        let peekGroup = groupsMapping[group] ?? group.peekGroup()
        groupsMapping[group] = peekGroup
        
        let attribute = StaticAttribute(keyPath: keyPath, title: title, detail: detail, value: value)
        peekGroup.attributes.insert(attribute, at: peekGroup.attributes.count)
    }
    
    internal var description: String {
        return """
        \(type(of: self))
        \(groupsMapping.values.map { "▹ \($0)" }.joined(separator: "\n"))
        """
    }
    
}
