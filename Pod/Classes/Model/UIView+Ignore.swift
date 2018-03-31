//
//  UIView+Ignore.swift
//  Peek
//
//  Created by Shaps Benkau on 26/03/2018.
//

import UIKit

extension UIView {
    
    /**
     Determines if Peek should ignore this view when parsing it into a model
     
     - parameter peek: The Peek instance
     
     - returns: Returns true if Peek should ignore this view, false otherwise
     */
    open override func shouldIgnore(options: PeekOptions) -> Bool {
        let isContainer = isMember(of: UIView.self) && subviews.count > 0
        if isContainer && options.ignoresContainerViews { return true }
        
        let isInvisible = isHidden || alpha == 0 || frame.equalTo(CGRect.zero)
        if isInvisible { return true }
        
        let isTableViewOrCell = isMember(of: UITableViewCell.self) || isMember(of: UITableView.self)
        if isTableViewOrCell { return true }
        
        let isCollectionView = isMember(of: UICollectionView.self)
        if isCollectionView { return true }
        
        let isFullScreen = frame.equalTo(window?.bounds ?? UIScreen.main.bounds)
        if isFullScreen { return true }
        
        if String(describing: classForCoder).hasPrefix("_UIModern") { return false }
        
        let blacklist = [ "UIPickerTableView", "UIPickerColumnView", "UITableViewCellContentView" ]
        let className = String(describing: classForCoder)
        
        if className.hasPrefix("_") || blacklist.contains(className) {
            return true
        }
        
        let invalidContainerClassNames = [ "UINavigationButton" ]
        var superview = self.superview
        
        while superview != nil {
            if superview?.isComponent == true {
                return true
            }
            
            // also need to check private internal classes
            for className in invalidContainerClassNames {
                if let klass = NSClassFromString(className) {
                    if superview?.isMember(of: klass) ?? false {
                        return true
                    }
                }
            }
            
            superview = superview?.superview
        }
        
        return false
    }
    
}
