//
//  PeekTheme+Colors.swift
//  Peek
//
//  Created by Shaps Benkau on 26/03/2018.
//

import Foundation

extension PeekTheme {
    
    internal var overlayBackgroundColor: UIColor? {
        return .black
    }
    
    internal var overlayTintColor: UIColor? {
        return Color(literalRed: 135, green: 252, blue: 112).system
    }
    
    internal var backgroundColor: UIColor? {
        switch self {
        case .dark: return Color(hex: "1c1c1c")!.system
        case .black: return .black
        case .light: return .white
        }
    }
    
    internal var selectedBackgroundColor: UIColor? {
        switch self {
        case .dark: return UIColor(white: 1, alpha: 0.1)
        case .black: return UIColor(white: 1, alpha: 0.1)
        case .light: return UIColor(white: 0, alpha: 0.1)
        }
    }
    
    internal var separatorColor: UIColor? {
        switch self {
        case .dark: return UIColor(white: 1, alpha: 0.1)
        case .black: return UIColor(white: 1, alpha: 0.1)
        case .light: return UIColor(white: 0, alpha: 0.1)
        }
    }
    
    internal func titleTextColor(isEditing: Bool) -> UIColor? {
        switch self {
        case .dark: return .white
        case .black: return .white
        case .light: return isEditing ? .white : .black
        }
    }
    
    internal var primaryTextColor: UIColor? {
        switch self {
        case .dark: return .white
        case .black: return .white
        case .light: return .black
        }
    }
    
    internal var secondaryTextColor: UIColor? {
        switch self {
        case .dark: return UIColor(white: 1, alpha: 0.6)
        case .black: return UIColor(white: 1, alpha: 0.6)
        case .light: return Color(hex: "1c1c1c")!.system
        }
    }
    
    internal var tintColor: UIColor? {
        switch self {
        case .dark: return Color(literalRed: 135, green: 252, blue: 112).system
        case .black: return Color(literalRed: 135, green: 252, blue: 112).system
        case .light: return Color(hex: "4CD863")!.system
        }
    }
    
    internal var editingColor: UIColor? {
        switch self {
        case .dark: return Color(hex: "4CD863")!.system
        case .black: return Color(hex: "4CD863")!.system
        case .light: return Color(hex: "4CD863")!.system
        }
    }
    
    internal var editingCounterColor: UIColor? {
        return Color(hex: "3EB454")!.system
    }
    
    internal var disclosureColor: UIColor? {
        switch self {
        case .dark: return UIColor(white: 1, alpha: 0.6)
        case .black: return UIColor(white: 1, alpha: 0.6)
        case .light: return UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        }
    }
    
}
