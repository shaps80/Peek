//
//  UIWindow+Extensions.swift
//  Peek
//
//  Created by Shaps Mohsenin on 09/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIWindow {
  
  public var peek: Peek {
    return objc_getAssociatedObject(self, &PeekAssociationKey.Peek) as? Peek ?? {
      let associatedProperty = Peek(window: self)
      objc_setAssociatedObject(self, &PeekAssociationKey.Peek, associatedProperty, .OBJC_ASSOCIATION_RETAIN)
      return associatedProperty
      }()
  }
  
}

