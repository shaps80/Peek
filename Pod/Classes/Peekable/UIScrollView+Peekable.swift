//
//  UIScrollView+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 28/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIScrollView {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Layout, "Scroll View") { (config) in
      config.addProperties([ "contentOffset", "contentSize", "contentInset", "scrollIndicatorInsets" ])
    }
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "directionalLockEnabled", "pagingEnabled", "scrollEnabled", "decelerationRate", "scrollsToTop" ])
      
      config.addProperty("keyboardDismissMode", displayName: nil, cellConfiguration: { (cell, object, value) in
        let mode = UIScrollViewKeyboardDismissMode(rawValue: value as! Int)!
        cell.detailTextLabel?.text = mode.description
      })
    }
    
    context.configure(.Attributes, "Indicators") { (config) in
      config.addProperties([ "showsHorizontalScrollIndicator", "showsVerticalScrollIndicator" ])
      
      config.addProperty("indicatorStyle", displayName: nil, cellConfiguration: { (cell, object, value) in
        let style = UIScrollViewIndicatorStyle(rawValue: value as! Int)!
        cell.detailTextLabel?.text = style.description
      })
    }
    
    context.configure(.Attributes, "Zoom") { (config) in
      config.addProperties([ "minimumZoomScale", "maximumZoomScale", "zoomScale", "bouncesZoom" ])
    }
    
    context.configure(.Attributes, "Bounce") { (config) in
      config.addProperties([ "bounces", "alwaysBounceVertical", "alwaysBounceHorizontal" ])
    }
  }
  
}
