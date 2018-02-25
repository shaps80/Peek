//
//  Group.swift
//  Peek
//
//  Created by Shaps Benkau on 24/02/2018.
//

import Foundation

@objc public enum Group: Int {
    case preview
    case appearance
    case accessibility
    case general
    case behaviour
    case states
    case shadow
    case border
    case constraints
    case horizontal
    case vertical
    case hugging
    case resistance
    
    case layout
    case classes
    case views
    case layers
    
    internal static var all: [Group] {
        var values: [Group] = []
        var index = 0
        
        while let element = self.init(rawValue: index) {
            values.append(element)
            index += 1
        }
        
        return values
    }
}

@objc public protocol PeekGroupProtocol: class {
    var title: String { get }
    var attributes: [Attribute] { get }
}

internal final class PeekGroup: PeekGroupProtocol, Hashable, CustomStringConvertible {
    
    internal let title: String
    internal var attributes: [Attribute]
    internal let group: Group
    internal let isExpandedByDefault: Bool
    
    internal init(title: String, group: Group, isExpandedByDefault: Bool = true) {
        self.isExpandedByDefault = isExpandedByDefault
        self.title = title
        self.group = group
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
    
    public static var preview = { PeekGroup(title: "Preview", group: .preview) }
    public static var appearance = { PeekGroup(title: "Appearance", group: .appearance) }
    public static var accessibility = { PeekGroup(title: "Accessibility", group: .accessibility, isExpandedByDefault: false) }
    public static var general = { PeekGroup(title: "General", group: .general, isExpandedByDefault: false) }
    public static var behaviour = { PeekGroup(title: "Behaviour", group: .behaviour) }
    public static var states = { PeekGroup(title: "States", group: .states, isExpandedByDefault: false) }
    public static var constraints = { PeekGroup(title: "Constraints", group: .constraints) }
    public static var hugging = { PeekGroup(title: "Content Hugging", group: .hugging) }
    public static var resistance = { PeekGroup(title: "Compression Resistance", group: .resistance) }
    public static var horizontal = { PeekGroup(title: "Horizontal", group: .horizontal, isExpandedByDefault: false) }
    public static var vertical = { PeekGroup(title: "Vertical", group: .vertical, isExpandedByDefault: false) }
    public static var layout = { PeekGroup(title: "Layout", group: .layout, isExpandedByDefault: false) }
    public static var classes = { PeekGroup(title: "Class Hierarchy", group: .classes, isExpandedByDefault: false) }
    public static var views = { PeekGroup(title: "View Hierarchy", group: .views, isExpandedByDefault: false) }
    public static var layers = { PeekGroup(title: "Layer Hierarchy", group: .layers, isExpandedByDefault: false) }
    public static var shadow = { PeekGroup(title: "Shadow", group: .shadow, isExpandedByDefault: true) }
    public static var border = { PeekGroup(title: "Border", group: .border, isExpandedByDefault: true) }
    
    public static func make(from group: Group) -> PeekGroup {
        switch group {
        case .preview: return .preview()
        case .appearance: return .appearance()
        case .accessibility: return .accessibility()
        case .general: return .general()
        case .states: return .states()
        case .behaviour: return .behaviour()
        case .constraints: return .constraints()
        case .hugging: return .hugging()
        case .resistance: return .resistance()
        case .horizontal: return .horizontal()
        case .vertical: return .vertical()
        case .layout: return .layout()
        case .classes: return .classes()
        case .views: return .views()
        case .layers: return .layers()
        case .shadow: return .shadow()
        case .border: return .border()
        }
    }
    
}
