//
//  AppDelegate.swift
//  Peek
//
//  Created by Shaps Mohsenin on 02/05/2016.
//  Copyright (c) 2016 Shaps Mohsenin. All rights reserved.
//

import UIKit
import Peek

// Slack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    window?.peek.enableWithOptions { options in
      options.activationMode = .Shake
      options.shouldIgnoreContainers = false
    }
    
    return true
  }
  
  override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
    window?.peek.handleShake(motion)
  }
  
}

