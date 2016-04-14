//
//  UIScreen+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIScreen {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Screen, "Brightness") { (config) in
      config.addProperties([ "wantsSoftwareDimming", "brightness" ])
    }
    
    context.configure(.Screen, "Layout") { (config) in
      config.addProperties([ "applicationFrame", "bounds", "currentMode.size" ])
    }
    
    context.configure(.Screen, "Scale") { (config) in
      config.addProperty("scale", displayName: "Device Scale", cellConfiguration: nil)
      config.addProperties([ "nativeScale", "currentMode.pixelAspectRatio" ])
    }
  }
  
}

