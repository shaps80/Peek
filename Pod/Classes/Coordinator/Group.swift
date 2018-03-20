//
//  Group.swift
//  Peek
//
//  Created by Shaps Benkau on 24/02/2018.
//

import Foundation

@objc public enum Group: Int {
    case preview
    case accessibility
    case typography
    case appearance
    case actions
    case paragraph
    case behaviour
    case states
    case shadow
    case border
    case general
    
    case horizontal
    case vertical
    case hugging
    case resistance
    case constraints
    
    case layout
    case classes
    case views
    case controllers
    case layers
    
    case capabilities
    case more
    
    internal var title: String {
        switch self {
        case .preview: return "Preview"
        case .typography: return "Typography"
        case .actions: return "Actions"
        case .appearance: return "Appearance"
        case .accessibility: return "Accessibility"
        case .general: return "General"
        case .paragraph: return "Paragraph"
        case .states: return "States"
        case .behaviour: return "Behaviour"
        case .constraints: return "Constraints"
        case .hugging: return "Hugging"
        case .resistance: return "Resistance"
        case .horizontal: return "Horizontal"
        case .vertical: return "Vertical"
        case .layout: return "Layout"
        case .classes: return "Class Inheritance"
        case .views: return "View Hierarchy"
        case .controllers: return "Controller Hierarchy"
        case .layers: return "Layers"
        case .shadow: return "Shadow"
        case .border: return "Border"
        case .capabilities: return "Capabilities"
        case .more: return "More"
        }
    }
    
    internal func peekGroup() -> PeekGroup {
        return PeekGroup(title: title, group: self)
    }
    
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

extension Group {
    
    public var isExpandedByDefault: Bool {
        switch self {
        case .preview: return true
        case .typography: return true
        case .appearance: return true
        case .actions: return true
        case .accessibility: return false
        case .general: return true
        case .paragraph: return true
        case .states: return true
        case .behaviour: return true
        case .constraints: return false
        case .hugging: return true
        case .resistance: return true
        case .horizontal: return true
        case .vertical: return true
        case .layout: return false
        case .classes: return false
        case .views: return true
        case .controllers: return true
        case .layers: return true
        case .shadow: return true
        case .border: return true
        case .capabilities: return true
        case .more: return true
        }
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
    
    internal init(title: String, group: Group) {
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
