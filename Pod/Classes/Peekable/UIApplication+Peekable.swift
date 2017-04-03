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

extension UIApplication {
  
  @objc fileprivate var bundle: Bundle {
    return Bundle.main
  }
  
  /**
   Configures Peek's properties for this object
   
   - parameter context: The context to apply these properties to
   */
  public override func preparePeek(_ context: Context) {
    super.preparePeek(context)
    
    context.configure(.application, "App") { (config) in
      config.addProperties([ "bundle.version", "bundle.build", "bundle.appName" ])
      config.addProperty("bundle.bundleIdentifier", displayName: "Identifier", cellConfiguration: nil)
    }
    
    context.configure(.application, "Appearance") { (config) in
      config.addProperties([ "bundle.statusBarAppearance"])
      config.addProperties([ "statusBarFrame" ])
      config.addProperty("applicationIconBadgeNumber", displayName: "Icon Badge Number", cellConfiguration: nil)
      
      let property = config.addProperty("bundle.supportedOrientations", displayName: nil, cellConfiguration: { (cell, object, value) in
        let mask = UIInterfaceOrientationMask(rawValue: value as! UInt)
        let image = Images.orientationMaskImage(mask)
        cell.accessoryView = UIImageView(image: image)
        cell.detailTextLabel?.text = nil
      })
      
      property.cellHeight = 70
    }
    
    context.configure(.application, "Behaviour") { (config) in
      config.addProperty("applicationSupportsShakeToEdit", displayName: "Shake to Edit", cellConfiguration: nil)
      config.addProperty("isIgnoringInteractionEvents", displayName: "Ignoring Interaction Events", cellConfiguration: nil)
      config.addProperties([ "protectedDataAvailable" ])
    }
    
    context.configure(.application, "Background Modes") { (config) in
      config.addProperty("bundle.supportsBackgroundAudio", displayName: "Background Audio", cellConfiguration: nil)
      config.addProperty("bundle.supportsExternalAccessory", displayName: "External Accessory", cellConfiguration: nil)
      config.addProperty("bundle.supportsBackgroundFetch", displayName: "Background Fetch", cellConfiguration: nil)
      config.addProperty("bundle.supportsLocation", displayName: "Location", cellConfiguration: nil)
      config.addProperty("bundle.supportsNewsstand", displayName: "News Stand", cellConfiguration: nil)
      config.addProperty("bundle.supportsPushNotifications", displayName: "Push Notifications", cellConfiguration: nil)
      config.addProperty("bundle.supportsVoip", displayName: "VOIP", cellConfiguration: nil)
      config.addProperty("bundle.supportsBluetooth", displayName: "Bluetooth", cellConfiguration: nil)
      config.addProperty("bundle.sharesDataViaBluetooth", displayName: "Bluetooth Data Sharing", cellConfiguration: nil)
    }
    
    context.configure(.application, "Capabilities") { (config) in
      config.addProperty("bundle.supportsHealthKit", displayName: "Health Kit", cellConfiguration: nil)
      config.addProperty("bundle.supportsGameKit", displayName: "Game Kit", cellConfiguration: nil)
    }
  }
  
}

extension Bundle {
  
  @objc var backgroundModes: [String]? {
    return infoDictionary?["UIBackgroundModes"] as? [String]
  }
  
  @objc var capabilities: [String]? {
    return infoDictionary?["UIRequiredDeviceCapabilities"] as? [String]
  }
  
  @objc var supportedDevices: String {
    let families = infoDictionary?["UIDeviceFamily"] as? [Int]
    let iphone = families?.contains(1) ?? false
    let ipad = families?.contains(2) ?? false
    
    if iphone && ipad {
      return "Universal"
    } else if iphone {
      return "iPhone"
    } else {
      return "iPad"
    }
  }
  
  @objc var supportsHealthKit: Bool {
    return capabilities?.contains("healthkit") ?? false
  }
  
  @objc var supportsGameKit: Bool {
    return capabilities?.contains("gamekit") ?? false
  }
  
  @objc var supportsBackgroundAudio: Bool {
    return backgroundModes?.contains("audio") ?? false
  }
  
  @objc var supportsExternalAccessory: Bool {
    return backgroundModes?.contains("external-accessory") ?? false
  }
  
  @objc var supportsBackgroundFetch: Bool {
    return backgroundModes?.contains("fetch") ?? false
  }
  
  @objc var supportsLocation: Bool {
    return backgroundModes?.contains("location") ?? false
  }
  
  @objc var supportsNewsstand: Bool {
    return backgroundModes?.contains("newsstand-content") ?? false
  }
  
  @objc var supportsPushNotifications: Bool {
    return backgroundModes?.contains("remote-notification") ?? false
  }
  
  @objc var supportsVoip: Bool {
    return backgroundModes?.contains("voip") ?? false
  }
  
  @objc var supportsBluetooth: Bool {
    return backgroundModes?.contains("bluetooth-central") ?? false
  }
  
  @objc var sharesDataViaBluetooth: Bool {
    return backgroundModes?.contains("bluetooth-peripheral") ?? false
  }
  
  @objc var appName: String {
    return infoDictionary?["CFBundleName"] as? String ?? "Unknown"
  }
  
  @objc var version: String {
    return infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
  }
  
  @objc var build: String {
    return infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
  }
  
  @objc var statusBarAppearance: String {
    if infoDictionary?["UIViewControllerBasedStatusBarAppearance"] as? Bool == true {
      return "Per Controller"
    } else {
      return "Application"
    }
  }
  
  var supportedOrientations: UIInterfaceOrientationMask {
    let application = UIApplication.shared
    let window = application.keyWindow
    return application.supportedInterfaceOrientations(for: window)
  }
  
}
