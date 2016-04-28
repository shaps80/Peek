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
  var previousStatusBarStyle = UIStatusBarStyle.Default
  /// The status bar style of the underlying app -- used to reset values when Peek is deactivated
  var previousStatusBarHidden = false
  var supportedOrientations = UIInterfaceOrientationMask.All
  unowned var peekingWindow: UIWindow // since this is the app's window, we don't want to retain it!
  
  private var activationController: PeekActivationController?
  private var volumeController: VolumeController?
  private(set) var options = PeekOptions()
  private(set) var window: UIWindow? // this is the Peek Overlay window, so we have to retain it!
  
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
    
    supportedOrientations = peekingWindow.rootViewController?.topViewController().supportedInterfaceOrientations() ?? .All
    previousStatusBarStyle = UIApplication.sharedApplication().statusBarStyle
    previousStatusBarHidden = UIApplication.sharedApplication().statusBarHidden
    
    peekingWindow.endEditing(true)
    
    window = UIWindow()
    window?.backgroundColor = UIColor.clearColor()
    window?.windowLevel = UIWindowLevelNormal
    window?.alpha = 0
    
    window?.rootViewController = PeekViewController(peek: self)
    window?.makeKeyAndVisible()
    
    UIView.animateWithDuration(0.25) { () -> Void in
      self.window?.alpha = 1
    }
    
    Peek.isAlreadyPresented = true
  }
  
  /**
   Dismisses Peek
   */
  public func dismiss() {
    UIView.animateWithDuration(0.25, animations: { () -> Void in
      self.window?.alpha = 0
    }) { (finished) -> Void in
      self.peekingWindow.makeKeyAndVisible()
      self.window?.rootViewController = nil
      self.window?.rootViewController?.view.removeFromSuperview()
      self.window = nil
      
      Peek.isAlreadyPresented = false
    }
  }
  
  /**
   Call this method from your AppDelegate to pass motion events to Peek. This will only activate/deactivate Peek when activationMode == .Shake or the app is being run from the Simulator
   
   - parameter motion: The motion events to handle
   */
  public func handleShake(motion: UIEventSubtype) {
    if motion != .MotionShake || !enabled {
      return
    }
    
    var isSimulator = false
    #if (arch(i386) || arch(x86_64))
      isSimulator = true
    #endif
    
    if (options.activationMode == .Auto && isSimulator) || options.activationMode == .Shake {
      if Peek.isAlreadyPresented {
        peekingWindow.peek.dismiss()
      } else {
        peekingWindow.peek.present()
      }
    }
  }
  
  /**
   Enables Peek with the specified options
   
   - parameter options: The options to use for configuring Peek
   */
  public func enableWithOptions(options: (options: PeekOptions) -> Void) {
    let opts = PeekOptions()
    options(options: opts)
    self.options = opts
    enabled = true
  }
  
  private func configureWithOptions(options: PeekOptions) {
    self.options = options
    
    var isSimulator = false
    #if (arch(i386) || arch(x86_64))
      isSimulator = true
    #endif
    
    if options.activationMode == .Auto && !isSimulator {
      activationController = VolumeController(peek: self)
    }
  }
  
}