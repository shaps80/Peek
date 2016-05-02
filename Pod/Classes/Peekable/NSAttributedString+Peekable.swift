//
//  NSAttributedString+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 02/05/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension NSAttributedString {
  
  override public func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "General") { (config) in
      
    }
    
    context.configure(.Attributes, "Paragraph") { (config) in
      
    }
  }
  
}
