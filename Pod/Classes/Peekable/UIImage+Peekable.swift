//
//  UIImage+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 10/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIImage {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "General") { (config) in
      config.addProperties([ "size", "scale", "capInsets", "alignmentRectInsets" ])
      
      config.addProperty("renderingMode", displayName: nil, cellConfiguration: { (cell, object, value) in
        let mode = UIImageRenderingMode(rawValue: value as! Int)!
        cell.detailTextLabel?.text = mode.description
      })
      
      config.addProperty("resizingMode", displayName: nil, cellConfiguration: { (cell, object, value) in
        let mode = UIImageResizingMode(rawValue: value as! Int)!
        cell.detailTextLabel?.text = mode.description
      })
      
      config.addProperty("imageOrientation", displayName: "Orientation", cellConfiguration: { (cell, object, value) in
        let orientation = UIImageOrientation(rawValue: value as! Int)!
        cell.detailTextLabel?.text = orientation.description
      })
    }
  }
  
}

