/*
  Copyright © 23/04/2016 Shaps

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 */

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