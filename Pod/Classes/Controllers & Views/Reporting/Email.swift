//
//  Email.swift
//  Peek
//
//  Created by Shaps Mohsenin on 01/05/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import Foundation
import MessageUI

/// Defines an object that can post messages via Email
final class Email: NSObject {
  
  fileprivate var mail: MFMailComposeViewController?
  
  override init() { }
  
  func post(_ image: UIImage? = nil, metaData: MetaData, peek: Peek, delegate: MFMailComposeViewControllerDelegate) {
    let topController = peek.window?.rootViewController?.topViewController()
    
    guard MFMailComposeViewController.canSendMail() else {
      let alert = UIAlertController(title: "Peek Error", message: "No email accounts are configured on this device.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      topController?.present(alert, animated: true, completion: nil)
      return
    }
    
    let controller = MFMailComposeViewController()
    controller.mailComposeDelegate = delegate

    if let image = image {
      controller.addAttachmentData(UIImageJPEGRepresentation(image, 0.7)!, mimeType: "image/jpeg", fileName: "screenshot.jpg")
    }

    controller.setToRecipients(peek.options.emailRecipients)
    controller.setSubject(peek.options.emailSubject ?? "")
    
    let data = try! JSONSerialization.data(withJSONObject: metaData.JSONRepresentation(), options: [.prettyPrinted])
    controller.addAttachmentData(data, mimeType: "application/json", fileName: "metaData.json")
    
    controller.setMessageBody(metaData.HTMLRepresentation(), isHTML: true)
    topController?.present(controller, animated: true, completion: nil)
    
    mail = controller
  }

}

