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
    case general
    case layout
    case classes
    case views
    
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

extension PeekGroup {
    
    public static var preview = { PeekGroup(title: "Preview", group: .preview) }
    public static var appearance = { PeekGroup(title: "Appearance", group: .appearance) }
    public static var general = { PeekGroup(title: "General", group: .general) }
    public static var layout = { PeekGroup(title: "Layout", group: .layout) }
    public static var classes = { PeekGroup(title: "Class Hierarchy", group: .classes) }
    public static var views = { PeekGroup(title: "View Hierarchy", group: .views) }
    
    public static func make(from group: Group) -> PeekGroup {
        switch group {
        case .preview: return .preview()
        case .views: return .views()
        case .general: return .general()
        case .appearance: return .appearance()
        case .layout: return .layout()
        case .classes: return .classes()
        }
    }
    
}
