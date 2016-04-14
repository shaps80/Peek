//
//  UIViewController+Extensions.swift
//  Peek
//
//  Created by Shaps Mohsenin on 09/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func topViewController() -> UIViewController {
    
    if let controller = self as? UINavigationController {
      return controller.topViewController ?? controller
    }
    
    if let controller = self as? UITabBarController {
      return controller.selectedViewController?.topViewController() ?? controller
    }
    
    if let controller = presentedViewController {
      return controller.topViewController() ?? self
    }
    
    return self
  }
  
}
