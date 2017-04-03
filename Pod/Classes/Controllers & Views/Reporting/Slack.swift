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
  
  fileprivate var session: URLSession!
  
  func post(_ metaData: MetaData, peek: Peek, controller: SlackViewController, completion: @escaping (Bool) -> Void) {
    let topController = controller
    
    guard let URL = peek.options.slackWebHookURL,
      let channel = peek.options.slackRecipient else {
        DispatchQueue.main.async(execute: { 
          let webhooksHelpURL = "https://slack.com/apps/A0F7XDUAZ-incoming-webhooks"
          let alert = UIAlertController(title: "Peek Error", message: "Slack is not configured for this build.\n\nVisit Slack to get started, then configure Peek with your WebHook URL in Xcode.\n\n\(webhooksHelpURL)", preferredStyle: .alert)
          
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          alert.addAction(UIAlertAction(title: "Visit", style: .default, handler: { (action) in
            UIApplication.shared.openURL(NSURL(string: webhooksHelpURL)! as URL)
          }))
          
          topController.present(alert, animated: true, completion: nil)
        })
        
        completion(false)
        return
    }
    
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 45
    session = URLSession(configuration: configuration)
    
    let request = NSMutableURLRequest(url: URL as URL)
    request.httpMethod = "POST"
    
    var attachments: [String: AnyObject] = [
      "fields": metaData.JSONRepresentation() as AnyObject,
      "color": SlackPriority.High.rawValue as AnyObject,
      "title": "Issue" as AnyObject,
    ]
    
    if let image = peek.screenshot, peek.options.includeScreenshot {
      let url = peek.options.slackImageUploader?(session, image)
      attachments["image_url"] = url?.absoluteString as AnyObject
    }
    
    let data: [String: AnyObject] = [
      "channel": channel as AnyObject,
      "username": peek.options.slackUserName as AnyObject,
      "text": metaData.message as AnyObject,
      "icon_url": "http://shaps.me/assets/img/peek-square.png" as AnyObject,
      "attachments": [ attachments ] as AnyObject,
    ]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
    } catch {
      print(error)
    }
    
    session?.dataTask(with: request as URLRequest) { (data, response, error) in
      DispatchQueue.main.async(execute: {
        guard error != nil || ((response as? HTTPURLResponse)?.statusCode)! > 299 else {
          DispatchQueue.main.async(execute: {
            completion(true)
          })
            
          return
        }
        
        var description = error?.localizedDescription
        
        if let data = data, let desc = String(data: data, encoding: String.Encoding.utf8) {
          description = "Failed to send message to\nchannel: \(channel)\n\n\(desc)"
        }
        
        DispatchQueue.main.async(execute: {
          let alert = UIAlertController(title: "Peek Error", message: description, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          topController.present(alert, animated: true, completion: nil)
          
          completion(false)
        })
      })
    }.resume()
  }
  
}

