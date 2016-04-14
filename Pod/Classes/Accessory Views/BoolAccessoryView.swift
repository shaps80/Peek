//
//  BoolAccessoryView.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

final class BoolAccessoryView: UIView {
  
  private let size = CGSizeMake(26, 16)
  private let value: Bool
  
  init(value: Bool) {
    self.value = value
    super.init(frame: CGRectMake(0, 0, size.width, size.height))
    self.backgroundColor = UIColor.clearColor()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    let rect = rect.insetBy(dx: 1, dy: 1)
    
    var bgColor: UIColor
    let bgPath = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2)
    
    var fgColor: UIColor
    var fgPath: UIBezierPath
    
    if value {
      bgColor = UIColor(white: 1, alpha: 1)
      fgColor = UIColor.secondaryColor()
      fgPath = UIBezierPath(ovalInRect: CGRectMake(rect.maxX - rect.height, rect.minY, rect.height, rect.height))
    } else {
      bgColor = UIColor(white: 1, alpha: 0.3)
      fgColor = UIColor(white: 1, alpha: 0.5)
      fgPath = UIBezierPath(ovalInRect: CGRectMake(rect.minX, rect.minY, rect.height, rect.height))
    }
    
    bgColor.setFill()
    bgPath.fill()
    
    fgColor.setFill()
    fgPath.fill()
  }
  
  override func intrinsicContentSize() -> CGSize {
    return CGSizeMake(size.width, size.height)
  }
  
}

