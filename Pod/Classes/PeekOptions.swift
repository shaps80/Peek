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

/// Defines various options to use when enabling Peek
public final class PeekOptions: NSObject {
    
    /// Defines how Peek is activated/de-activated. Default to auto
    public var activationMode: PeekActivationMode = .auto
    
    /// Defines whether Peek should ignore pure containers (i.e. UIView's (NOT subclassed) where subviews.count > 0)
    public var shouldIgnoreContainers = true
    
    /// You can provide meta data that will be attached to every report. This is useful for passing additional info about the app, e.g. Environment, etc...
    public var metaData: [String: String]?
    
    /// Defines whether or not a screenshot should be included when posting an issue. Note: if you're using Slack, you'll also need to provide a slackImageUploader block
    public var includeScreenshot = true
    
    /// Defines the render scale to use when generating screenshots
    public var screenshotScale = UIScreen.main.scale
    
    // Obsoletions
    @available(*, obsoleted: 4.0.1)
    public var slackUserName = "Peek"
    @available(*, obsoleted: 4.0.1)
    public var slackRecipient: String?
    @available(*, obsoleted: 4.0.1)
    public var slackWebHookURL: URL?
    @available(*, obsoleted: 4.0.1)
    public var emailRecipients: [String]?
    @available(*, obsoleted: 4.0.1)
    public var emailSubject: String?
    @available(*, obsoleted: 4.0.1)
    public var slackImageUploader: ((URLSession, UIImage) -> URL?)?
    @available(*, obsoleted: 4.0.1, renamed: "metaData")
    public var reportMetaData: [String: String]?
    
}
