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
  
  public var enabled: Bool = false {
    didSet {
      if enabled {
        volumeController?.register()
      } else {
        volumeController?.unregister()
      }
    }
  }
  
  public static var isAlreadyPresented: Bool = false
  
  var peekingWindow: UIWindow
  var previousStatusBarStyle = UIStatusBarStyle.Default
  var previousStatusBarHidden = false
  var supportedOrientations = UIInterfaceOrientationMask.All
  
  private var volumeController: VolumeController?
  private(set) var window: UIWindow?
  
  public required init(window: UIWindow) {
    peekingWindow = window
    super.init()
    volumeController = VolumeController(peek: self)
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
  
}

