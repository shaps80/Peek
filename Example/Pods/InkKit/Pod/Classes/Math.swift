//
//  Math.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 29/08/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

/**
 Converts the specified angle in 'degrees' to 'radians'
 
 - parameter degrees: The angle in degrees
 
 - returns: The angle in radians
 */
public func radians(from degrees: Double) -> CGFloat {
  return CGFloat(degrees * M_PI / 180)
}

/**
 Converts the specified angle in 'radians' to 'degrees'
 
 - parameter radians: The angle in radians
 
 - returns: The angle in degrees
 */
public func degrees(from radians: Double) -> CGFloat {
  return CGFloat(radians * 180 / M_PI)
}

