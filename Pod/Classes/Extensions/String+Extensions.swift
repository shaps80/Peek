//
//  String+Extensions.swift
//  Peek
//
//  Created by Shaps Mohsenin on 09/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import Foundation

extension String {
  
  static func capitalized(camelCase: String) -> String {
    
    let chars = NSCharacterSet.uppercaseLetterCharacterSet()
    var string = camelCase.componentsSeparatedByString(".").last ?? camelCase
    
    while let range = string.rangeOfCharacterFromSet(chars) {
      let char = string.substringWithRange(range)
      string.replaceRange(range, with: " " + char.lowercaseString)
    }
    
    return string.capitalizedString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
  }
  
}

