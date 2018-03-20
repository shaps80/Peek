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
    // TODO
    // case light
    
    internal var backgroundColor: UIColor? {
        switch self {
        case .dark: return .inspectorDark
        case .black: return .inspectorBlack
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
