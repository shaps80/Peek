//
//  UISwitch+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 09/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UISwitch {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Appearance") { (config) in
      config.addProperties([ "onTintColor", "thumbTintColor", "onImage", "offImage" ])
    }
    
    context.configure(.Attributes, "state") { (config) in
      config.addProperties([ "on" ])
    }
  }
  
}
