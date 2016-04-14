//
//  UINavigationItem+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 10/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "General") { (config) in
      config.addProperties([ "title", "enabled", "image", "landscapeImagePhone", "imageInsets", "landscapeImagePhoneInsets", "tag" ])
    }
  }
  
}
