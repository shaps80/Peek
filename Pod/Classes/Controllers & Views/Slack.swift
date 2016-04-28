//
//  Slacker.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import Foundation
import MessageUI

/// Defines an object that can post messages via Slack
final class Slack {
  
  static let shared = Slack()
  private var session: NSURLSession?
  
  func post(message: String, peek: Peek) {
    let topController = peek.window?.rootViewController?.topViewController()
    
    guard let URL = peek.options.slackWebHookURL,
      channel = peek.options.slackRecipient else {
        let alert = UIAlertController(title: "Peek Error", message: "Slack is not configured for this build.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        topController?.presentViewController(alert, animated: true, completion: nil)
        
        return
    }
    
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    configuration.timeoutIntervalForRequest = 45
    session = NSURLSession(configuration: configuration)
    
    let request = NSMutableURLRequest(URL: URL)
    request.HTTPMethod = "POST"
    
    let data = [
      "channel": channel,
      "username": peek.options.slackUserName,
      "text": message,
      "icon_url": "http://shaps.me/assets/img/peek.png"
    ]
    
    do {
      request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(data, options: [])
    } catch {
      print(error)
    }
    
    session?.dataTaskWithRequest(request) { (data, response, error) in
      dispatch_async(dispatch_get_main_queue(), { 
        if error != nil || (response as? NSHTTPURLResponse)?.statusCode > 299 {
          var description = error?.localizedDescription
          
          if let data = data, desc = String(data: data, encoding: NSUTF8StringEncoding) {
            description = "Failed to send message to\nchannel: \(channel)\n\n\(desc)"
          }
          
          let alert = UIAlertController(title: "Peek Error", message: description, preferredStyle: .Alert)
          alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
          topController?.presentViewController(alert, animated: true, completion: nil)
        }
      })
    }.resume()
  }
  
}

/// Defines an object that can post messages via Email
final class Email: NSObject, MFMailComposeViewControllerDelegate {
  
  static let shared = Email()
  private var mail: MFMailComposeViewController?
  
  func post(message: String, peek: Peek) {
    let topController = peek.window?.rootViewController?.topViewController()
    
    guard MFMailComposeViewController.canSendMail() else {
      let alert = UIAlertController(title: "Peek Error", message: "No email accounts are configured on this device.", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      topController?.presentViewController(alert, animated: true, completion: nil)
      return
    }
    
    let controller = MFMailComposeViewController()
    controller.mailComposeDelegate = self
    controller.setMessageBody(message, isHTML: false)
    topController?.presentViewController(controller, animated: true, completion: nil)
    mail = controller
  }
  
  func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    controller.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    mail = nil
  }
  
}
