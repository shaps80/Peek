//
//  RectAccessoryView.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

final class RectAccessoryView: UIView {
  
  private let value: CGRect
  
  init(value: CGRect) {
    self.value = value
    super.init(frame: CGRectZero)
    backgroundColor = UIColor.clearColor()
    prepare()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func prepare() {    
    let attributes = [ NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)!, NSForegroundColorAttributeName: UIColor.whiteColor() ]
    let originString = "Origin:\t\(value.origin.x), \(value.origin.y)"
    let sizeString = "Size:\t\(value.width), \(value.height)"
    
    let originLabel = UILabel()
    originLabel.attributedText = NSAttributedString(string: originString, attributes: attributes)
    
    let sizeLabel = UILabel()
    sizeLabel.attributedText = NSAttributedString(string: sizeString, attributes: attributes)
    
    addSubview(originLabel)
    addSubview(sizeLabel)
    
    originLabel.pin([ .LeftAndRight, .Top ], toView: self)
    sizeLabel.pin([ .LeftAndRight, .Bottom ], toView: self)
    sizeLabel.pin(.Top, toEdge: .Bottom, toView: originLabel, margin: 7)
  }
  
}
