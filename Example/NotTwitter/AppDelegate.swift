//
//  AppDelegate.swift
//  NotTwitter
//
//  Created by Shaps Benkau on 10/03/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit
import Peek

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Theme.apply()

        window?.peek.enableWithOptions { options in
            options.theme = .dark
            options.activationMode = .auto
            options.ignoresContainerViews = false
            
            /*
             Configure the metadata asscociated with this app.
             */
            options.metadata = [
                "Environment": "UAT"
            ]
        }
        
        return true
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        // iOS 8/9 requires device motion handlers to be on the AppDelegate
        window?.peek.handleShake(motion)
    }
    
}

