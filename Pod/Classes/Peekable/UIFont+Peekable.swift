//
//  UIFont+Peekabel.swift
//  Peek
//
//  Created by Shaps Mohsenin on 10/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIFont {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Font") { (config) in
      config.addProperties([ "familyName", "fontName", "ascender", "descender", "capHeight", "xHeight", "lineHeight", "leading" ])
    }
  }
  
}

