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
    
    open override func preparePeek(with coordinator: Coordinator) {
        if let image = bundle.appIcon {
            coordinator.appendPreview(image: image, forModel: self)
        }
        
        coordinator.appendDynamic(keyPaths: [
            "bundle.appName",
            "bundle.bundleIdentifier",
            "bundle.version",
            "bundle.build",
            "bundle.supportedDevices",
            "bundle.statusBarAppearance",
            "statusBarFrame",
            "applicationIconBadgeNumber"
        ], forModel: self, in: .general)
        
        coordinator.appendDynamic(keyPathToName: [
            ["applicationSupportsShakeToEdit": "Supports Shake to Edit"],
            ["ignoringInteractionEvents": "Ignoring Interactions"],
            ["protectedDataAvailable": "Protected Data Available"]
        ], forModel: self, in: .behaviour)
        
        coordinator.appendDynamic(keyPaths: [
            "bundle.supportsBackgroundAudio",
            "bundle.supportsExternalAccessory",
            "bundle.supportsBackgroundFetch",
            "bundle.supportsLocation",
            "bundle.supportsNewsstand",
            "bundle.supportsPushNotifications",
            "bundle.supportsVoip",
            "bundle.supportsBluetooth",
            "bundle.supportsHealthKit",
            "bundle.supportsGameKit",
            "bundle.sharesDataViaBluetooth",
        ], forModel: self, in: .capabilities)
        
        super.preparePeek(with: coordinator)
    }
    
    @objc fileprivate var bundle: Bundle {
        return Bundle.main
    }
    
}
