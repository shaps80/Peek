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
import MediaPlayer


/**
 *  Defines a controller that is responsible for presenting Peek
 */
protocol PeekActivationController {
  
  func register()
  func unregister()
  init(peek: Peek)
  
}

/// Defines an controller that activates Peek via your device Volume controls
final class VolumeController: NSObject, PeekActivationController {
  
  unowned var peek: Peek
  fileprivate var volumeView: MPVolumeView!
  fileprivate var session: AVAudioSession!
  fileprivate var previousVolume: Float = 0
  
  init(peek: Peek) {
    self.peek = peek
    super.init()
    
    NotificationCenter.default.addObserver(self, selector: #selector(VolumeController.register), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(VolumeController.unregister), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
    unregister()
  }

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if let keyPath = keyPath, keyPath == "outputVolume",
      let volume = change?[.newKey] as? NSNumber, volume.floatValue != previousVolume {
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
      if view.responds(to: #selector(UISlider.setValue(_:animated:))) {
        view.perform(#selector(UISlider.setValue(_:animated:)), with: previousVolume, with: false)
        
        if view.responds(to: Selector(("_commitVolumeChange"))) {
          view.perform(Selector(("_commitVolumeChange")))
        }

        return
      }
    }
  }
  
  func register() {
    volumeView = MPVolumeView(frame: CGRect(x: -1000, y: 0, width: 1, height: 1))
    peek.peekingWindow.addSubview(volumeView)
    
    session = AVAudioSession.sharedInstance()
    previousVolume = session.outputVolume
    
    do {
      try session.setCategory(AVAudioSessionCategoryAmbient, with: .mixWithOthers)
      try session.setActive(true)
    } catch {
      print(error)
    }
    
    session.addObserver(self, forKeyPath: "outputVolume", options: .new, context: nil)
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
