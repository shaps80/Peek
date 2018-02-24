//
//  Group.swift
//  Peek
//
//  Created by Shaps Benkau on 24/02/2018.
//

import Foundation

@objc public enum Group: Int {
    case appearance
    case layout
    case classes
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
