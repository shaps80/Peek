//
//  Graph.swift
//  Track
//
//  Created by Shaps Mohsenin on 09/02/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit
import InkKit

@IBDesignable
class Separator: UIView {
  
  @IBInspectable var reverse: Bool = false {
    didSet {
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var startColor: UIColor = UIColor(white: 1, alpha: 1) {
    didSet {
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var endColor: UIColor = UIColor(white: 1, alpha: 0) {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    let path = UIBezierPath(rect: rect)
    
    if reverse {
      Draw.fillPath(path, startColor: startColor, endColor: endColor, angleInDegrees: -90)
    } else {
      Draw.fillPath(path, startColor: startColor, endColor: endColor, angleInDegrees: 90)
    }
  }
  
}

