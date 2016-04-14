//
//  ColorView.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

final class ColorAccessoryView: UIView {
  
  private let value: UIColor?
  private let size = CGSizeMake(24, 14)
  
  init(value: UIColor?) {
    self.value = value
    super.init(frame: CGRectMake(0, 0, size.width, size.height))
    opaque = true
    backgroundColor = value
    
    layer.cornerRadius = size.height / 2
    layer.borderColor = UIColor(white: 1, alpha: 0.5).CGColor
    layer.borderWidth = 1
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func intrinsicContentSize() -> CGSize {
    return CGSizeMake(size.width, size.height)
  }
  
}
