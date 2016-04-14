//
//  PeekCell.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

final class InspectorCell: UITableViewCell {
  
  override var accessoryView: UIView? {
    didSet {
      setNeedsUpdateConstraints()
    }
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
    
    selectedBackgroundView = UIView()
    selectedBackgroundView?.backgroundColor = UIColor(white: 1, alpha: 0.07)
    
    backgroundColor = UIColor(white: 1, alpha: 0.03)
    textLabel?.textColor = UIColor(white: 1, alpha: 0.6)
    detailTextLabel?.textColor = UIColor.whiteColor()
    detailTextLabel?.font = UIFont(name: "Avenir-Book", size: 16)
    textLabel?.font = UIFont(name: "Avenir-Book", size: 14)
    
    textLabel?.minimumScaleFactor = 0.8
    textLabel?.adjustsFontSizeToFitWidth = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if var rect = textLabel?.frame {
      rect.origin.y = 9
      textLabel?.frame = rect
    }
    
    if let label = textLabel {
      var rect = label.frame
      rect.origin.y = 9
      textLabel?.frame = rect
    }
    
    if let label = detailTextLabel where accessoryView != nil {
      var rect = label.frame
      rect.origin.x -= 15
      detailTextLabel?.frame = rect
    }
  }
  
  override func setHighlighted(highlighted: Bool, animated: Bool) {
    let color = accessoryView?.backgroundColor
    super.setHighlighted(highlighted, animated: animated)
    accessoryView?.backgroundColor = color
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    let color = accessoryView?.backgroundColor
    super.setSelected(selected, animated: animated)
    accessoryView?.backgroundColor = color
  }
  
}
