/*
 Copyright © 23/04/2016 Shaps
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import Foundation

/**
 Available activation modes
 
 - Auto:  Peek will use a shake gesture when running in the Simulator, and the volume controls on a device
 - Shake: Peek will use a shake gesture on both the Simulator and a device
 */
public enum PeekActivationMode {
    /// Peek will use a shake gesture when running in the Simulator, and the volume controls on a device
    case auto
    /// Peek will use a shake gesture on both the Simulator and a device
    case shake
}

public enum PeekTheme {
    case dark
    case black
    case light
    
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

/// Defines various options to use when enabling Peek
public final class PeekOptions: NSObject {
    
    /// Defines how peek looks (.black mode is optimised for OLED displays). Defaults to .dark
    public var theme: PeekTheme = .dark
    
    /// Defines how Peek is activated/de-activated. Defaults to auto
    public var activationMode: PeekActivationMode = .auto
    
    /// When this is true, views that are not subclassed but contain subviews, will be ignored. Defaults to false
    public var ignoresContainerViews = false
    
    /// You can provide meta data that will be attached to every report. This is useful for passing additional info about the app, e.g. Environment, etc...
    public var metadata: [String: String] = [:]
    
    // MARK: Obsoletions
    
    @available(*, obsoleted: 4.0.1, renamed: "ignoresContainerViews")
    public var shouldIgnoreContainers: Bool {
        get { return ignoresContainerViews }
        set { ignoresContainerViews = newValue }
    }
    
    @available(*, obsoleted: 4.0.1)
    public var includeScreenshot = true
    @available(*, obsoleted: 4.0.1, message: "Defaults to UIScreen.main.scale")
    public var screenshotScale = UIScreen.main.scale
    @available(*, obsoleted: 4.0.1, message: "Peek now uses the built in UIActivityViewController")
    public var slackUserName = "Peek"
    @available(*, obsoleted: 4.0.1, message: "Peek now uses the built in UIActivityViewController")
    public var slackRecipient: String?
    @available(*, obsoleted: 4.0.1, message: "Peek now uses the built in UIActivityViewController")
    public var slackWebHookURL: URL?
    @available(*, obsoleted: 4.0.1, message: "Peek now uses the built in UIActivityViewController")
    public var emailRecipients: [String]?
    @available(*, obsoleted: 4.0.1, message: "Peek now uses the built in UIActivityViewController")
    public var emailSubject: String?
    @available(*, obsoleted: 4.0.1, message: "Peek now uses the built in UIActivityViewController")
    public var slackImageUploader: ((URLSession, UIImage) -> URL?)?
    @available(*, obsoleted: 4.0.1, renamed: "metadata")
    public var reportMetaData: [String: String]?
    
}
