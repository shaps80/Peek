//
//  CGAffineTransform+Extensions.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 29/08/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

extension CGAffineTransform {
  
  /**
   Initializes a new transform for applying a shear
   
   - parameter x: The x value of this shear
   - parameter y: The y value of this shear
   
   - returns: A shear transform
   */
  public init(shearX x: CGFloat, y: CGFloat) {
    self.init(a: 1, b: y, c: -x, d: 1, tx: 1, ty: 1)
  }
  
  /**
   Applies a shear transform to the current transform
   
   - parameter x: The x value of this shear
   - parameter y: The y value of this shear
   
   - returns: A new transform with a shear transform applied
   */
  public func shearedBy(x: CGFloat, y: CGFloat) -> CGAffineTransform {
    var transform = self
    transform.c = -x
    transform.b = y
    return transform
  }
  
}

extension CATransform3D {
  
  /**
   Initializes a new transform for applying perspective
   
   - parameter distance: The logical 'distance' from the camera
   
   - returns: A new perspective transform
   */
  public init(perspective distance: CGFloat) {
    self.init(m11: 1, m12: 0, m13: 0, m14: 0, m21: 0, m22: 1, m23: 0, m24: 0, m31: 0, m32: 0, m33: 1, m34: -1/distance, m41: 0, m42: 0, m43: 0, m44: 1)
  }
  
  /**
   Apples perspective to the current transform
   
   - parameter distance: The logical 'distance' from the camera
   
   - returns: A new transform with perspective applied
   */
  public func withPerspective(distance: CGFloat) -> CATransform3D {
    var transform = self
    transform.m34 = -1 / distance
    return transform
  }
  
}

