//
//  UIDevice+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIDevice {
  
  @objc private var processInfo: NSProcessInfo {
    return NSProcessInfo.processInfo()
  }
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Device, "Battery") { (config) in
      config.addProperties([ "batteryMonitoringEnabled" ])
      
      if batteryMonitoringEnabled {
        config.addProperties([ "batteryLevel" ])
        
        config.addProperty("batteryState", displayName: nil, cellConfiguration: { (cell, view, value) in
          if let state = UIDeviceBatteryState(rawValue: value as! Int) {
            cell.detailTextLabel?.text = state.description
          }
        })
      }
    }
    
    context.configure(.Device, "Hardware") { (config) in
      config.addProperties([ "processInfo.processorCount",  ])
      
      config.addProperty("processInfo.physicalMemory", displayName: nil, cellConfiguration: { (cell, object, value) in
        let formatter = NSByteCountFormatter()
        let memory = NSProcessInfo.processInfo().physicalMemory
        formatter.countStyle = .Memory
        cell.detailTextLabel?.text = formatter.stringFromByteCount(Int64(memory))
      })
    }
    
    context.configure(.Device, "System") { (config) in
      config.addProperties([ "name", "model" ])
      config.addProperty("systemVersion", displayName: "iOS Version", cellConfiguration: nil)
    }
    
    context.configure(.Device, "Proximity") { (config) in
      config.addProperties([ "proximityMonitoringEnabled" ])
      
      if proximityMonitoringEnabled {
        config.addProperty("proximityState", displayName: "Proximity Detected", cellConfiguration: nil)
      }
    }
    
  }
  
}

