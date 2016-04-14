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
    #if DEBUG
      window?.peek.enabled = true
    #endif
    return true
  }
  
  
  // lets ONLY use the shake in the simulator since we don't have access to volume controls
  #if (arch(i386) || arch(x86_64)) && os(iOS)
  override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
    if motion == .MotionShake {
      
      if Peek.isAlreadyPresented {
        window?.peek.dismiss()
      } else {
        window?.peek.present()
      }
    }
  }
  #endif
  
}

