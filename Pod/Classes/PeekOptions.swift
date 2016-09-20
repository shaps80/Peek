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
  case Auto
    /// Peek will use a shake gesture on both the Simulator and a device
  case Shake
}

/// Defines various options to use when enabling Peek
public final class PeekOptions: NSObject {
  
   /// Defines how Peek is activated/de-activated
  public var activationMode = PeekActivationMode.Auto
  
   /// Defines whether Peek should ignore pure containers (i.e. UIView's (NOT subclassed) where subviews.count > 0)
  public var shouldIgnoreContainers = true
  
   /// Defines the username to use when sending a Slack message
  public var slackUserName = "Peek"
  
  /// Defines the Slack channel/user to post to -- e.g. #channel, @user  -- Note: When sending to a private channel, you must add `slackUserName` to the channel first
  public var slackRecipient: String?
  
   /// Defines the Slack WebHook URL to use for posting messages, this should be the full url -- e.g. https://hooks.slack.com/services/$TOKEN -- visit https://slack.com/apps/A0F7XDUAZ-incoming-webhooks to get yours
  public var slackWebHookURL: NSURL?
  
   /// Defines the email recipients to include by default when sending a report via email
  public var emailRecipients: [String]?
  
   /// Defines the default email subject to include by default when sending a report via email 
  public var emailSubject: String?
  
   /// You can provide meta data that will be attached to every report. This is useful for passing additional info about the app, e.g. Environment, etc...
  public var reportMetaData: [String: String]?
  
   /// When posting issues to slack you can optionally provide an image uploader block. This will execute when an issue is being posted to Slack. You should upload the image to your service, then return the associated image URL -- which will be included in the Slack message automatically. If the image upload failed, return nil
  public var slackImageUploader: ((NSURLSession, UIImage) -> NSURL?)?
  
   /// Defines whether or not a screenshot should be included when posting an issue. Note: if you're using Slack, you'll also need to provide a slackImageUploader block
  public var includeScreenshot = true
  
   /// Defines the render scale to use when generating screenshots
  public var screenshotScale = UIScreen.mainScreen().scale
  
}
