//
//  Model.swift
//  Pods
//
//  Created by Shaps Mohsenin on 06/02/2016.
//
//

import Foundation

public protocol Model: Peekable {
  func valueForKeyPath(key: String) -> AnyObject?
}

extension NSObject: Model { }
