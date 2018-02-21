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
    
    @objc fileprivate var processInfo: ProcessInfo {
        return ProcessInfo.processInfo
    }
    
    /**
     Configures Peek's properties for this object
     
     - parameter context: The context to apply these properties to
     */
    public override func preparePeek(_ context: Context) {
        super.preparePeek(context)
        
        context.configure(.device, "Battery") { (config) in
            config.addProperties([ "batteryMonitoringEnabled" ])
            
            if isBatteryMonitoringEnabled {
                config.addProperties([ "batteryLevel" ])
                
                config.addProperty("batteryState", displayName: nil, cellConfiguration: { (cell, _, value) in
                    if let state = UIDeviceBatteryState(rawValue: value as! Int) {
                        cell.detailTextLabel?.text = state.description
                    }
                })
            }
        }
        
        context.configure(.device, "Hardware") { (config) in
            config.addProperties([ "processInfo.processorCount", ])
            
            config.addProperty("processInfo.physicalMemory", displayName: nil, cellConfiguration: { (cell, _, _) in
                let formatter = ByteCountFormatter()
                let memory = ProcessInfo.processInfo.physicalMemory
                formatter.countStyle = .memory
                cell.detailTextLabel?.text = formatter.string(fromByteCount: Int64(memory))
            })
        }
        
        context.configure(.device, "System") { (config) in
            config.addProperties([ "name", "model" ])
            config.addProperty("systemVersion", displayName: "iOS Version", cellConfiguration: nil)
        }
        
        context.configure(.device, "Proximity") { (config) in
            config.addProperties([ "proximityMonitoringEnabled" ])
            
            if isProximityMonitoringEnabled {
                config.addProperty("proximityState", displayName: "Proximity Detected", cellConfiguration: nil)
            }
        }
        
    }
    
}
