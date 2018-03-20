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
    
    open override func preparePeek(with coordinator: Coordinator) {
        let orientations = Images.orientationMaskImage(supportedInterfaceOrientations)
        coordinator.appendPreview(image: orientations, forModel: self)
        
        coordinator.appendTransformed(keyPaths: ["modalTransitionStyle"], valueTransformer: { value in
            guard let rawValue = value as? Int, let style = UIModalTransitionStyle(rawValue: rawValue) else { return nil }
            return style.description
        }, forModel: self, in: .appearance)
        
        coordinator.appendTransformed(keyPaths: ["modalPresentationStyle"], valueTransformer: { value in
            guard let rawValue = value as? Int, let style = UIModalPresentationStyle(rawValue: rawValue) else { return nil }
            return style.description
        }, forModel: self, in: .appearance)
        
        coordinator.appendTransformed(keyPaths: ["preferredStatusBarStyle"], valueTransformer: { value in
            guard let rawValue = value as? Int, let style = UIStatusBarStyle(rawValue: rawValue) else { return nil }
            return style.description
        }, forModel: self, in: .appearance)
        
        coordinator.appendTransformed(keyPaths: ["preferredStatusBarUpdateAnimation"], valueTransformer: { value in
            guard let rawValue = value as? Int, let style = UIStatusBarAnimation(rawValue: rawValue) else { return nil }
            return style.description
        }, forModel: self, in: .appearance)
        
        if self is UITableViewController {
            coordinator.appendDynamic(keyPathToName: [
                ["clearsSelectionOnViewWillAppear": "Auto Clears Selection"],
            ], forModel: self, in: .behaviour)
        }
        
        if self is UICollectionViewController {
            coordinator.appendDynamic(keyPathToName: [
                ["clearsSelectionOnViewWillAppear": "Auto Clears Selection"],
                ["useLayoutToLayoutNavigationTransitions": "Transitions between Layouts"],
                ["installsStandardGestureForInteractiveMovement": "Supports Reordering Gesture"]
            ], forModel: self, in: .behaviour)
        }
        
        if splitViewController != nil {
            coordinator.appendDynamic(keyPaths: ["splitViewController"], forModel: self, in: .more)
        }
        
        if tabBarController != nil {
            coordinator.appendDynamic(keyPaths: ["tabBarController"], forModel: self, in: .more)
        }
        
        coordinator.appendStatic(keyPath: "view", title: "View", detail: String(describing: view.classForCoder), value: view, in: .views)
        
        if navigationController != nil {
            coordinator.appendStatic(keyPath: "navigationItem.backBarButtonItem", title: "Back Navigation Item", detail: navigationItem.backBarButtonItem?.title, value: navigationItem.backBarButtonItem, in: .views)
            coordinator.appendStatic(keyPath: "navigationItem.rightBarButtonItem", title: "Right Navigation Item", detail: navigationItem.rightBarButtonItem?.title, value: navigationItem.rightBarButtonItem, in: .views)
            coordinator.appendStatic(keyPath: "navigationItem.leftBarButtonItem", title: "Left Navigation Item", detail: navigationItem.leftBarButtonItem?.title, value: navigationItem.leftBarButtonItem, in: .views)
            
            coordinator.appendDynamic(keyPaths: [
                "navigationController",
            ], forModel: self, in: .more)
            
            coordinator.appendDynamic(keyPaths: [
                "navigationItem.hidesBackButton",
            ], forModel: self, in: .behaviour)
            
            coordinator.appendDynamic(keyPaths: [
                "navigationItem.title",
                "navigationItem.prompt",
            ], forModel: self, in: .appearance)
        }
        
        if self is UINavigationController {
            coordinator.appendDynamic(keyPaths: [
                "navigationBarHidden",
                "toolbarHidden",
                "hidesBarsWhenKeyboardAppears",
                "hidesBarsOnSwipe",
                "hidesBarsWhenVerticallyCompact",
                "hidesBarsOnTap"
            ], forModel: self, in: .behaviour)
        }
        
        if self is UISplitViewController {
            coordinator.appendTransformed(keyPaths: ["preferredDisplayMode"], valueTransformer: { value in
                guard let rawValue = value as? Int, let mode = UISplitViewControllerDisplayMode(rawValue: rawValue) else { return nil }
                return mode.description
            }, forModel: self, in: .appearance)
            
            coordinator.appendTransformed(keyPaths: ["displayMode"], valueTransformer: { value in
                guard let rawValue = value as? Int, let mode = UISplitViewControllerDisplayMode(rawValue: rawValue) else { return nil }
                return mode.description
            }, forModel: self, in: .appearance)
            
            if #available(iOS 11.0, *) {
                coordinator.appendTransformed(keyPaths: ["primaryEdge"], valueTransformer: { value in
                    guard let rawValue = value as? Int, let edge = UISplitViewControllerPrimaryEdge(rawValue: rawValue) else { return nil }
                    return edge.description
                }, forModel: self, in: .appearance)
            }
            
            coordinator.appendDynamic(keyPaths: [
                "isCollapsed"
            ], forModel: self, in: .states)
            
            coordinator.appendDynamic(keyPaths: [
                "presentsWithGesture",
            ], forModel: self, in: .behaviour)
            
            coordinator.appendTransformed(keyPaths: ["preferredPrimaryColumnWidthFraction"], valueTransformer: { value in
                guard let value = value as? CGFloat else { return nil }
                return value == UISplitViewControllerAutomaticDimension ? "Automatic" : "\(value)"
            }, forModel: self, in: .layout)
            
            coordinator.appendTransformed(keyPaths: ["maximumPrimaryColumnWidth"], valueTransformer: { value in
                guard let value = value as? CGFloat else { return nil }
                return value == UISplitViewControllerAutomaticDimension ? "Automatic" : "\(value)"
            }, forModel: self, in: .layout)
            
            coordinator.appendTransformed(keyPaths: ["primaryColumnWidth"], valueTransformer: { value in
                guard let value = value as? CGFloat else { return nil }
                return value == UISplitViewControllerAutomaticDimension ? "Automatic" : "\(value)"
            }, forModel: self, in: .layout)
            
            coordinator.appendDynamic(keyPaths: [
                "displayModeButtonItem"
            ], forModel: self, in: .more)
        }
        
        if let parent = parent {
            coordinator.appendStatic(keyPath: "parent", title: String(describing: parent.classForCoder), detail: "", value: parent, in: .controllers)
        }
        
        coordinator.appendStatic(keyPath: "self", title: String(describing: classForCoder), detail: "", value: self, in: .controllers)
        
        for controller in childViewControllers.reversed() {
            coordinator.appendStatic(keyPath: "classForCoder", title: String(describing: controller.classForCoder), detail: "", value: controller, in: .controllers)
        }
        
        super.preparePeek(with: coordinator)
    }
    
}
