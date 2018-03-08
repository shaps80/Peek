//
//  Bundle+Peekable.swift
//  Peek
//
//  Created by Shaps Benkau on 26/02/2018.
//

import Foundation

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
    
    @objc var appIcon: UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? NSDictionary,
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? NSDictionary,
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? NSArray,
            // First will be smallest for the device class, last will be the largest for device class
            let lastIcon = iconFiles.lastObject as? String,
            let icon = UIImage(named: lastIcon) else {
                return nil
        }
        
        return icon
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
    
    @objc var supportedOrientations: UIInterfaceOrientationMask {
        let application = UIApplication.shared
        let window = application.keyWindow
        return application.supportedInterfaceOrientations(for: window)
    }
    
}
