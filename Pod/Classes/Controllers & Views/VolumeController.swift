//
//  VolumeController.swift
//  Pods
//
//  Created by Shaps Mohsenin on 07/02/2016.
//
//

import Foundation
import MediaPlayer

protocol PeekActivationController {
  
  func register()
  func unregister()
  init(peek: Peek)
  
}

final class VolumeController: NSObject, PeekActivationController {
  
  unowned var peek: Peek
  private var volumeView: MPVolumeView!
  private var session: AVAudioSession!
  private var previousVolume: Float = 0
  
  init(peek: Peek) {
    self.peek = peek
    super.init()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VolumeController.register), name: UIApplicationDidBecomeActiveNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VolumeController.unregister), name: UIApplicationWillResignActiveNotification, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
    unregister()
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if let keyPath = keyPath where keyPath == "outputVolume",
      let volume = change?["new"] as? NSNumber where volume != previousVolume {
        if Peek.isAlreadyPresented {
          peek.dismiss()
        } else {
          peek.present()
        }
        
        resetVolume()
    }
  }
  
  func resetVolume() {
    for view in volumeView.subviews {
      if view.respondsToSelector(#selector(UISlider.setValue(_:animated:))) {
        view.performSelector(#selector(UISlider.setValue(_:animated:)), withObject: previousVolume, withObject: false)
        
        if view.respondsToSelector("_commitVolumeChange") {
          view.performSelector("_commitVolumeChange")
        }

        return
      }
    }
  }
  
  func register() {
    volumeView = MPVolumeView(frame: CGRectMake(-1000, 0, 1, 1))
    peek.peekingWindow.addSubview(volumeView)
    
    session = AVAudioSession.sharedInstance()
    previousVolume = session.outputVolume
    
    do {
      try session.setCategory(AVAudioSessionCategoryAmbient, withOptions: .MixWithOthers)
      try session.setActive(true)
    } catch {
      print(error)
    }
    
    session.addObserver(self, forKeyPath: "outputVolume", options: .New, context: nil)
  }
  
  func unregister() {
    if volumeView == nil {
      // already unregistered
      return
    }
    
    session.removeObserver(self, forKeyPath: "outputVolume")
    
    do {
      try session.setActive(false)
    } catch {
      print(error)
    }
    
    volumeView.removeFromSuperview()
    volumeView = nil
    session = nil
  }
  
}
