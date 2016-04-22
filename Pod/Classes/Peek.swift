//
//  Peek.swift
//  Pods
//
//  Created by Shaps Mohsenin on 05/02/2016.
//
//

import Foundation

struct PeekAssociationKey {
  static var Peek: UInt8 = 1
}

public final class Peek: NSObject {
  
  public static var isAlreadyPresented: Bool = false
  
  public var enabled: Bool = false {
    didSet {
      if enabled {
        configureWithOptions(options)
      } else {
        activationController?.unregister()
      }
    }
  }
  
  var previousStatusBarStyle = UIStatusBarStyle.Default
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
    window?.tintColor = UIColor.whiteColor()
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

