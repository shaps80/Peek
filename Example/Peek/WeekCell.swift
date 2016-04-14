//
//  WeekCell.swift
//  Track
//
//  Created by Shaps Mohsenin on 09/02/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit
import SPXMasking
import pop

class WeekCell: UICollectionViewCell {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var separatorView: UIView!
  
  var lightColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.00)
  var darkColor = UIColor(red: 0.118, green: 0.122, blue: 0.129, alpha: 1.00)
  
  override var selected: Bool {
    didSet {
      update()
    }
  }
  
  override var highlighted: Bool {
    didSet {
      update()      
    }
  }
  
  private func update() {
    if self.selected || self.highlighted {
      self.titleLabel.textColor = self.darkColor
      self.imageView.tintColor = self.darkColor
    } else {
      self.titleLabel.textColor = self.lightColor
      self.imageView.tintColor = self.lightColor
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    
    let view = UIView()
    view.backgroundColor = lightColor
    selectedBackgroundView = view
    
    let radius: CGFloat = 15
    selectedBackgroundView!.layer.cornerRadii = SPXCornerRadiiMake(0, radius, radius, 0)
  }
  
}

