//
//  UIViewController+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 23/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIViewController {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    
    context.configure(.Controller, "Status Bar") { (config) in
      config.addProperty("preferredStatusBarStyle", displayName: "Preferred Style", cellConfiguration: { (cell, object, value) in
        let style = UIStatusBarStyle(rawValue: value as! Int)!
        cell.detailTextLabel?.text = style.description
      })
      
      config.addProperty("preferredStatusBarUpdateAnimation", displayName: "Preferred Animation", cellConfiguration: { (cell, object, value) in
        let style = UIStatusBarAnimation(rawValue: value as! Int)!
        cell.detailTextLabel?.text = style.description
      })
    }
    
    context.configure(.Controller, "Modal") { (config) in
      config.addProperty("modalTransitionStyle", displayName: nil, cellConfiguration: { (cell, object, value) in
        let style = UIModalTransitionStyle(rawValue: value as! Int)
        cell.detailTextLabel?.text = style?.description
      })
      
      config.addProperty("modalPresentationStyle", displayName: nil, cellConfiguration: { (cell, object, value) in
        let style = UIModalPresentationStyle(rawValue: value as! Int)
        cell.detailTextLabel?.text = style?.description
      })
    }
    
    context.configure(.Controller, "Orientation") { (config) in
      config.addProperty("interfaceOrientation", displayName: "Current Orientation", cellConfiguration: { (cell, object, value) in
        let orientation = UIInterfaceOrientation(rawValue: value as! Int)!
        let image = Images.orientationImage(orientation)
        cell.accessoryView = UIImageView(image: image)
        cell.detailTextLabel?.text = orientation.description
      })
      
      let property = config.addProperty("supportedInterfaceOrientations", displayName: "Supported Orientations", cellConfiguration: { (cell, object, value) in
        let mask = UIInterfaceOrientationMask(rawValue: value as! UInt)
        let image = Images.orientationMaskImage(mask)
        cell.accessoryView = UIImageView(image: image)
        cell.detailTextLabel?.text = nil
      })
      
      property.cellHeight = 70
    }
    
    if self is UITableViewController {
      context.configure(.Controller, "Table View", configuration: { (config) in
        config.addProperty("clearsSelectionOnViewWillAppear", displayName: "Clears Selection on View", cellConfiguration: nil)
      })
    }
    
    if self is UICollectionViewController {
      context.configure(.Controller, "Collection View", configuration: { (config) in
        config.addProperty("clearsSelectionOnViewWillAppear", displayName: "Clears Selection on View", cellConfiguration: nil)
        config.addProperty("useLayoutToLayoutNavigationTransitions", displayName: "Layout to Layout Transitions", cellConfiguration: nil)
        config.addProperty("installsStandardGestureForInteractiveMovement", displayName: "Uses Default Reordering Gesture", cellConfiguration: nil)
      })
    }
    
    if navigationController != nil {
      context.configure(.Controller, "Navigation") { (config) in
        config.addProperties([ "navigationController.navigationBarHidden", "navigationController.toolbarHidden", "navigationController.hidesBarsWhenKeyboardAppears", "navigationController.hidesBarsOnSwipe", "navigationController.hidesBarsWhenVerticallyCompact", "navigationController.hidesBarsOnTap" ])
      }
      
      context.configure(.Controller, "Navigation Item", configuration: { (config) in
        config.addProperties([ "navigationItem.hidesBackButton", "navigationItem.title", "navigationItem.prompt" ])
      })
      
      context.configure(.Controller, "Navigation Items", configuration: { (config) in
        if navigationItem.leftBarButtonItem != nil {
          config.addProperties([ "navigationItem.leftBarButtonItem" ])
        }
        
        if navigationItem.rightBarButtonItem != nil {
          config.addProperties([ "navigationItem.rightBarButtonItem" ])
        }
        
        if navigationItem.backBarButtonItem != nil {
          config.addProperties([ "navigationItem.backBarButtonItem" ])
        }
      })
    }
  }
  
}

