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

import UIKit
import Peek
import InkKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//    window?.peek.enableWithOptions { options in
//      options.activationMode = .Auto
//      options.shouldIgnoreContainers = true
//      
//      /*
//       In order to use Slack, you need to define a username, recipient (either a channel or user, e.g. #peek or @peek)
//       You also need to provide your Slack Incoming WebHook URL
//       
//       https://slack.com/apps/A0F7XDUAZ-incoming-webhooks
//       */
//      options.slackUserName = "Peek"
//      options.slackRecipient = "#peek"
//      // options.slackWebHookURL = NSURL(string: "https://hooks.slack.com/services/$TOKEN")!
//      
//      /*
//       Email support works by default, but you can also configure options like recipient(s) & subject
//       */
//      options.emailRecipients = [ "" ]
//      options.emailSubject = "Peek Issue: "
//      
//      /*
//       Both email and Slack reporting can use an optional metaData dictionary of key/values -- this is useful for providing additional context, like the environment your application is currently pointing to
//       */
//      options.reportMetaData = [ "Environment": "UAT" ]
//      
//      /**
//       Both email and Slack support including screenshots. For email, you don't need to do a thing, it JUST WORKS out of the box.
//       However, Slack doesn't support direct image uploads via WebHooks, so instead you can provide an image upload block that will automatically execute when you try to post to Slack.
//       
//       Note: The upload block is already dispatched to a background queue, so you can run your code synchronously.
//       
//       Just use the provided session and image, upload it to your service and return the resulting URL
//       */
//      options.includeScreenshot = true
//      options.screenshotScale = 1
//      options.slackImageUploader = { (session, image) in
//        return NSURL(string: "http://shaps.me/assets/img/peek-overlay.png")
//      }
//    }
    
    return true
  }
  
  override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
    window?.peek.handleShake(motion)
  }

}
