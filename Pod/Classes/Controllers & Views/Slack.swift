//
//  Slacker.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import Foundation
import MessageUI

final class Slack {
  
  static let shared = Slack()
  
  func post(message: String, peek: Peek) {
    let topController = peek.window?.rootViewController?.topViewController()
    
    guard let URL = peek.options.slackWebHookURL,
      channel = peek.options.slackRecipient else {
        let alert = UIAlertController(title: "Peek", message: "Slack is not configured for this build.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        topController?.presentViewController(alert, animated: true, completion: nil)
        
        return
    }
    
    let session = NSURLSession.sharedSession()
    let request = NSMutableURLRequest(URL: URL)
    
    let data = [
      "channel": channel,
      "as_user": true,
      "username": peek.options.slackUserName,
      "text": message,
      "icon_url": "http://shaps.me/assets/img/peek.png"
    ]
    
    do {
      request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(data, options: [])
    } catch {
      print(error)
    }
    
    let task = session.dataTaskWithRequest(request) { [unowned peek] (data, response, error) in
      dispatch_async(dispatch_get_main_queue(), { 
        if error != nil {
          let alert = UIAlertController(title: "Peek: Slack", message: error?.localizedDescription, preferredStyle: .Alert)
          alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
          topController?.presentViewController(alert, animated: true, completion: nil)
        }
      })
    }
    
    task.resume()
  }
  
}

final class Email: NSObject, MFMailComposeViewControllerDelegate {
  
  static let shared = Email()
  private var mail: MFMailComposeViewController?
  
  func post(message: String, peek: Peek) {
    let topController = peek.window?.rootViewController?.topViewController()
    
    guard MFMailComposeViewController.canSendMail() else {
      let alert = UIAlertController(title: "Peek", message: "No email accounts are configured on this device.", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
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
