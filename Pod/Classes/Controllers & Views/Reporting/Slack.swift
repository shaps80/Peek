//
//  Slacker.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import Foundation

enum SlackPriority: String {
  case Low = "good"
  case Medium = "warning"
  case High = "danger"
}

/// Defines an object that can post messages via Slack
final class Slack {
  
  private var session: NSURLSession!
  
  func post(metaData: MetaData, peek: Peek, controller: SlackViewController, completion: (Bool) -> Void) {
    let topController = controller
    
    guard let URL = peek.options.slackWebHookURL,
      channel = peek.options.slackRecipient else {
        dispatch_async(dispatch_get_main_queue(), { 
          let webhooksHelpURL = "https://slack.com/apps/A0F7XDUAZ-incoming-webhooks"
          let alert = UIAlertController(title: "Peek Error", message: "Slack is not configured for this build.\n\nVisit Slack to get started, then configure Peek with your WebHook URL in Xcode.\n\n\(webhooksHelpURL)", preferredStyle: .Alert)
          
          alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
          alert.addAction(UIAlertAction(title: "Visit", style: .Default, handler: { (action) in
            UIApplication.sharedApplication().openURL(NSURL(string: webhooksHelpURL)!)
          }))
          
          topController.presentViewController(alert, animated: true, completion: nil)
        })
        
        completion(false)
        return
    }
    
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    configuration.timeoutIntervalForRequest = 45
    session = NSURLSession(configuration: configuration)
    
    let request = NSMutableURLRequest(URL: URL)
    request.HTTPMethod = "POST"
    
    var attachments: [String: AnyObject] = [
      "fields": metaData.JSONRepresentation(),
      "color": SlackPriority.High.rawValue,
      "title": "Issue",
    ]
    
    if let image = peek.screenshot where peek.options.includeScreenshot {
      let url = peek.options.slackImageUploader?(session, image)
      attachments["image_url"] = url?.absoluteString
    }
    
    let data: [String: AnyObject] = [
      "channel": channel,
      "username": peek.options.slackUserName,
      "text": metaData.message,
      "icon_url": "http://shaps.me/assets/img/peek-square.png",
      "attachments": [ attachments ],
    ]
    
    do {
      request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(data, options: [])
    } catch {
      print(error)
    }
    
    session?.dataTaskWithRequest(request) { (data, response, error) in
      dispatch_async(dispatch_get_main_queue(), {
        guard error != nil || (response as? NSHTTPURLResponse)?.statusCode > 299 else {
          dispatch_async(dispatch_get_main_queue(), {
            completion(true)
          })
            
          return
        }
        
        var description = error?.localizedDescription
        
        if let data = data, desc = String(data: data, encoding: NSUTF8StringEncoding) {
          description = "Failed to send message to\nchannel: \(channel)\n\n\(desc)"
        }
        
        dispatch_async(dispatch_get_main_queue(), {
          let alert = UIAlertController(title: "Peek Error", message: description, preferredStyle: .Alert)
          alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
          topController.presentViewController(alert, animated: true, completion: nil)
          
          completion(false)
        })
      })
    }.resume()
  }
  
}

