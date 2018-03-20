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

import Foundation

struct PeekAssociationKey {
    static var Peek: UInt8 = 1
}

/// The primary class where Peek can be activated/disabled
public final class Peek: NSObject {
    
    /// Returns true if Peek is already being presented -- this is to prevent
    public static var isAlreadyPresented: Bool = false
    internal var screenshot: UIImage?
    
    /// Enables/disables Peek
    public var enabled: Bool = false {
        didSet {
            if enabled {
                configureWithOptions(options)
            } else {
                activationController?.unregister()
            }
        }
    }
    
    /// The status bar style of the underlying app -- used to reset values when Peek is deactivated
    var previousStatusBarStyle = UIStatusBarStyle.default
    /// The status bar hidden state of the underlying app -- used to reset values when Peek is deactivated
    var previousStatusBarHidden = false
    var supportedOrientations = UIInterfaceOrientationMask.all
    unowned var peekingWindow: UIWindow // since this is the app's window, we don't want to retain it!
    
    fileprivate var activationController: PeekActivationController?
    fileprivate var volumeController: VolumeController?
    fileprivate(set) var options = PeekOptions()
    fileprivate(set) var window: UIWindow? // this is the Peek Overlay window, so we have to retain it!
    
    init(window: UIWindow) {
        peekingWindow = window
        super.init()
    }
    
    /**
     Presents Peek
     */
    public func present() {
        if !enabled {
            print("Peek is disabled!")
            return
        }
        
        if Peek.isAlreadyPresented {
            print("Peek is already being presented!")
            return
        }
        
        supportedOrientations = peekingWindow.rootViewController?.topViewController().supportedInterfaceOrientations ?? .all
        previousStatusBarStyle = UIApplication.shared.statusBarStyle
        previousStatusBarHidden = UIApplication.shared.isStatusBarHidden
        
        peekingWindow.endEditing(true)
        
        window = UIWindow()
        window?.backgroundColor = UIColor.clear
        window?.frame = peekingWindow.bounds
        window?.windowLevel = UIWindowLevelNormal
        window?.alpha = 0
        
        window?.rootViewController = PeekViewController(peek: self)
        window?.makeKeyAndVisible()
        
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.window?.alpha = 1
        }) 
        
        Peek.isAlreadyPresented = true
    }
    
    /**
     Dismisses Peek
     */
    public func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.window?.alpha = 0
        }, completion: { (_) -> Void in
            if let controller = self.window?.rootViewController?.presentedViewController {
                controller.presentingViewController?.dismiss(animated: false, completion: nil)
            }
            
            self.peekingWindow.makeKeyAndVisible()
            self.window?.rootViewController?.view.removeFromSuperview()
            self.window?.rootViewController = nil
            self.window = nil
            self.screenshot = nil
            
            Peek.isAlreadyPresented = false
        }) 
    }
    
    /**
     On iOS 10+ call this from your rootViewController. Otherwise use your AppDelegate. This will only activate/deactivate Peek when activationMode == .Shake or the app is being run from the Simulator. On iOS 10+ this will also dismiss the Inspectors view when visible.
     - parameter motion: The motion events to handle
     */
    public func handleShake(_ motion: UIEventSubtype) {
        if motion != .motionShake || !enabled {
            return
        }
        
        var isSimulator = false
        #if (arch(i386) || arch(x86_64))
            isSimulator = true
        #endif
        
        if (options.activationMode == .auto && isSimulator) || options.activationMode == .shake {
            handleActivation()
        }
    }
    
    private func handleActivation() {
        if let nav = window?.rootViewController?.presentedViewController as? UINavigationController {
            let inspectors = nav.viewControllers.flatMap { $0 as? PeekInspectorViewController }
            
            if (inspectors.filter { $0.tableView.isEditing }).count == 0 {
                nav.dismiss(animated: true, completion: nil)
            }
            
            return
        }
        
        if Peek.isAlreadyPresented {
            peekingWindow.peek.dismiss()
        } else {
            peekingWindow.peek.present()
        }
    }
    
    /**
     Enables Peek with the specified options
     
     - parameter options: The options to use for configuring Peek
     */
    public func enableWithOptions(_ options: (_ options: PeekOptions) -> Void) {
        let opts = PeekOptions()
        options(opts)
        self.options = opts
        enabled = true
    }
    
    fileprivate func configureWithOptions(_ options: PeekOptions) {
        self.options = options
        
        var isSimulator = false
        #if (arch(i386) || arch(x86_64))
            isSimulator = true
        #endif
        
        if options.activationMode == .auto && !isSimulator {
            activationController = VolumeController(peek: self, handleActivation: handleActivation)
        }
    }
    
}
