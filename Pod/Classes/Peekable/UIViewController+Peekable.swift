/*
  Copyright © 23/04/2016 Shaps

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 */

import UIKit

extension UIViewController {
  
  /**
   Configures Peek's properties for this object
   
   - parameter context: The context to apply these properties to
   */
  public override func preparePeek(_ context: Context) {
    super.preparePeek(context)
    
    
    context.configure(.controller, "Status Bar") { (config) in
      config.addProperty("preferredStatusBarStyle", displayName: "Preferred Style", cellConfiguration: { (cell, object, value) in
        let style = UIStatusBarStyle(rawValue: value as! Int)!
        cell.detailTextLabel?.text = style.description
      })
      
      config.addProperty("preferredStatusBarUpdateAnimation", displayName: "Preferred Animation", cellConfiguration: { (cell, object, value) in
        let style = UIStatusBarAnimation(rawValue: value as! Int)!
        cell.detailTextLabel?.text = style.description
      })
    }
    
    context.configure(.controller, "Modal") { (config) in
      config.addProperty("modalTransitionStyle", displayName: nil, cellConfiguration: { (cell, object, value) in
        let style = UIModalTransitionStyle(rawValue: value as! Int)
        cell.detailTextLabel?.text = style?.description
      })
      
      config.addProperty("modalPresentationStyle", displayName: nil, cellConfiguration: { (cell, object, value) in
        let style = UIModalPresentationStyle(rawValue: value as! Int)
        cell.detailTextLabel?.text = style?.description
      })
    }
    
    context.configure(.controller, "Orientation") { (config) in
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
      context.configure(.controller, "Table View", configuration: { (config) in
        config.addProperty("clearsSelectionOnViewWillAppear", displayName: "Clears Selection on View", cellConfiguration: nil)
      })
    }
    
    if self is UICollectionViewController {
      context.configure(.controller, "Collection View", configuration: { (config) in
        config.addProperty("clearsSelectionOnViewWillAppear", displayName: "Clears Selection on View", cellConfiguration: nil)
        config.addProperty("useLayoutToLayoutNavigationTransitions", displayName: "Layout to Layout Transitions", cellConfiguration: nil)
        config.addProperty("installsStandardGestureForInteractiveMovement", displayName: "Uses Default Reordering Gesture", cellConfiguration: nil)
      })
    }
    
    if navigationController != nil {
      context.configure(.controller, "Navigation") { (config) in
        config.addProperties([ "navigationController.navigationBarHidden", "navigationController.toolbarHidden", "navigationController.hidesBarsWhenKeyboardAppears", "navigationController.hidesBarsOnSwipe", "navigationController.hidesBarsWhenVerticallyCompact", "navigationController.hidesBarsOnTap" ])
      }
      
      context.configure(.controller, "Navigation Item", configuration: { (config) in
        config.addProperties([ "navigationItem.hidesBackButton", "navigationItem.title", "navigationItem.prompt" ])
      })
      
      context.configure(.controller, "Navigation Items", configuration: { (config) in
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
