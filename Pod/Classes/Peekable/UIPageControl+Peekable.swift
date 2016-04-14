//
//  UIPageControl+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 10/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIPageControl {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Color") { (config) in
      config.addProperties([ "pageIndicatorTintColor", "currentPageIndicatorTintColor" ])
    }
    
    context.configure(.Attributes, "General") { (config) in
      config.addProperties([ "numberOfPages", "currentPage" ])
    }
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "hidesForSinglePage", "defersCurrentPageDisplay" ])
    }
  }
  
}
