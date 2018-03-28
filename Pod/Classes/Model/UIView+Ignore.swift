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
    internal override func isVisibleInOverlay(options: PeekOptions) -> Bool {
        let isContainer = isMember(of: UIView.self) && subviews.count > 0
        if isContainer && options.ignoresContainerViews { return false }
        
        let isInvisible = isHidden || alpha == 0 || frame.equalTo(CGRect.zero)
        if isInvisible { return false }
        
        let isTableViewOrCell = isMember(of: UITableViewCell.self) || isMember(of: UITableView.self)
        if isTableViewOrCell { return false }
        
        let isCollectionView = isMember(of: UICollectionView.self)
        if isCollectionView { return false }
        
        let isFullScreen = frame.equalTo(window?.bounds ?? UIScreen.main.bounds)
        if isFullScreen { return false }
        
        if String(describing: classForCoder).hasPrefix("_UIModern") { return true }
        
        let blacklist = [ "UIPickerTableView", "UIPickerColumnView", "UITableViewCellContentView" ]
        let className = String(describing: classForCoder)
        
        if className.hasPrefix("_") || blacklist.contains(className) {
            return false
        }
        
        let invalidContainerClassNames = [ "UINavigationButton" ]
        var superview = self.superview
        
        while superview != nil {
            if superview?.isComponent == true {
                return false
            }
            
            // also need to check private internal classes
            for className in invalidContainerClassNames {
                if let klass = NSClassFromString(className) {
                    if superview?.isMember(of: klass) ?? false {
                        return false
                    }
                }
            }
            
            superview = superview?.superview
        }
        
        return true
    }
    
}
