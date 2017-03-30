//
//  Color.swift
//  InkKit
//
//  Created by Shaps Benkau on 30/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Represents an RGBA color
 */
public struct RGBA {
    /// The red component
    public var red: Float
    /// The green component
    public var green: Float
    /// The blue component
    public var blue: Float
    /// The alpha component
    public var alpha: Float
}

/**
 *  Represents a color value type
 */
public struct Color: CustomStringConvertible {
    
    /// Represents the underlying RGBA values
    public var rgba: RGBA
    
    /**
     Initializes this color value with relative component values. e.g. (0.5, 0.2, 0.1, 1.0)
     
     - parameter red:   A value in the range 0...1
     - parameter green: A value in the range 0...1
     - parameter blue:  A value in the range 0...1
     - parameter alpha: A value in the range 0...1
     
     - returns: A new color value
     */
    public init(red: Float, green: Float, blue: Float, alpha: Float = 1) {
        func clamp(_ value: Float) -> Float {
            return min(1, max(0, value))
        }
        
        rgba = RGBA(red: clamp(red), green: clamp(green), blue: clamp(blue), alpha: clamp(alpha))
    }
    
    /**
     Returns a new color value with the associated alpha value
     
     - parameter alpha: The new alpha value
     
     - returns: A new color value
     */
    public func with(alpha: Float) -> Color {
        return Color(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: alpha)
    }
    
    /// Returns a debug friendly description of this color. The string contains both a relative and literal representation as well as the associated hexValue
    public var description: String {
        let color = literalRGBA()
        return "(\(color.red), \(color.green), \(color.blue), \(rgba.alpha)) \(hex(withPrefix: true))"
    }
}

extension Color {
    
    /**
     Initializes this color value with literal component values. e.g. (100, 50, 20, 1.0)
     
     - parameter red:   A value in the range 0...255
     - parameter green: A value in the range 0...255
     - parameter blue:  A value in the range 0...255
     - parameter alpha: A value in the range 0...1
     
     - returns: A new color value
     */
    public init(literalRed red: Float, green: Float, blue: Float, alpha: Float = 1) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    /**
     Returns the RGBA literal component values
     
     - returns: The RGBA literal component values
     */
    public func literalRGBA() -> RGBA {
        return RGBA(red: rgba.red * 255, green: rgba.green * 255, blue: rgba.blue * 255, alpha: rgba.alpha)
    }
    
}

extension Color {
    
    /**
     Initializes this color value with the associated hex string.
     
     - parameter hex: A valid hex string, optionally including the '#' prefix. Both 3 and 6 character formats are supported
     
     - returns: A new color value if the hex string is valid, nil otherwise
     */
    public init?(hex: String) {
        var hexValue = hex.hasPrefix("#") ? String(hex.characters.dropFirst()) : hex
        guard hexValue.characters.count == 3 || hexValue.characters.count == 6 else { return nil }
        
        if hexValue.characters.count == 3 {
            for (index, char) in hexValue.characters.enumerated() {
                let index = hexValue.index(hexValue.startIndex, offsetBy: index * 2)
                hexValue.insert(char, at: index)
            }
        }
        
        guard let parsedInt = Int(hexValue, radix: 16) else { return nil }
        
        self.init(
            red:   Float((parsedInt >> 16) & 0xFF) / 255.0,
            green: Float((parsedInt >> 8) & 0xFF) / 255.0,
            blue:  Float((parsedInt & 0xFF)) / 255.0,
            alpha: 1.0)
    }
    
    /**
     Returns a hex string representation of the color value
     
     - parameter withPrefix: If true, includes the '#' prefix
     
     - returns: A hex string representation
     */
    public func hex(withPrefix: Bool = true) -> String {
        let prefix = withPrefix ? "#" : ""
        return String(format: "\(prefix)%02X%02X%02X", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255))
    }
    
}

extension Color {
    
    /**
     Initializes this color value with the specified white value
     
     - parameter white: A value in the range 0...1
     - parameter alpha: A value in the range 0...1
     
     - returns: A new color value
     */
    public init(white: Float, alpha: Float = 1) {
        self.init(red: white, green: white, blue: white, alpha: alpha)
    }
    
    /**
     Initializes this color value with the specified CGColor
     
     - parameter cgColor: A CGColor instance to convert
     
     - returns: A new color value
     */
    public init?(cgColor: CGColor) {
        guard let components = cgColor.components else { return nil }
        let red, green, blue, alpha: Float
        
        if components.count == 2 {
            red = Float(components[0])
            green = Float(components[0])
            blue = Float(components[0])
            alpha = Float(components[1])
        } else {
            red = Float(components[0])
            green = Float(components[1])
            blue = Float(components[2])
            alpha = Float(components[3])
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Returns the CGColor representation of this color
    public var cgColor: CGColor {
        return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(),
                       components: [CGFloat(rgba.red), CGFloat(rgba.green), CGFloat(rgba.blue), CGFloat(rgba.alpha)])!
    }
    
}

extension Color {
    
    /// Returns true if the color is considered visually dark. False otherwise
    public var isDark: Bool {
        return (0.2126 * rgba.red + 0.7152 * rgba.green + 0.0722 * rgba.blue) < 0.5
    }
    
    /**
     Returns a new color value that is the inverse of this color
     
     - returns: A color that is the inverse of this color. e.g. white -> black
     */
    public func inversed() -> Color {
        return Color(red: 1 - rgba.red, green: 1 - rgba.green, blue: 1 - rgba.blue, alpha: rgba.alpha)
    }
    
}

extension Color {
    
    public static var black: Color { return Color(white: 0) }
    public static var darkGray: Color { return Color(white: 0.333) }
    public static var lightGray: Color { return Color(white: 0.667) }
    public static var white: Color { return Color(white: 1) }
    public static var gray: Color { return Color(white: 0.5) }
    public static var red: Color { return Color(red: 1, green: 0, blue: 0) }
    public static var green: Color { return Color(red: 0, green: 1, blue: 0) }
    public static var blue: Color { return Color(red: 0, green: 0, blue: 1) }
    public static var cyan: Color { return Color(red: 0, green: 1, blue: 1) }
    public static var yellow: Color { return Color(red: 1, green: 1, blue: 0) }
    public static var magenta: Color { return Color(red: 1, green: 0, blue: 1) }
    public static var orange: Color { return Color(red: 1, green: 0.5, blue: 0) }
    public static var purple: Color { return Color(red: 0.5, green: 0, blue: 0.5) }
    public static var brown: Color { return Color(red: 0.6, green: 0.4, blue: 0.2) }
    public static var clear: Color { return Color(white: 0, alpha: 0) }
    
}

extension Color {
  
    public func set() {
        setFill()
        setStroke()
    }
    
    public func setFill() {
        CGContext.current?.setFillColor(cgColor)
    }
    
    public func setStroke() {
        CGContext.current?.setStrokeColor(cgColor)
    }
  
}


#if os(iOS)
    import UIKit
    extension Color {
        public init?(color: UIColor) {
            self.init(cgColor: color.cgColor)
        }
        
        public var uiColor: UIColor {
            return UIColor(cgColor: cgColor)
        }
    }
#endif

#if os(OSX)
    import AppKit
    extension Color {
        public init?(color: NSColor) {
            self.init(cgColor: color.cgColor)
        }
        
        public var nsColor: NSColor {
            return NSColor(cgColor: cgColor)!
        }
    }
#endif
