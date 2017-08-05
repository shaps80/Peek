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

extension UIView {
  
  @objc var horizontalConstraints: [NSLayoutConstraint] {
    return constraintsAffectingLayout(for: .horizontal)
  }
  
  @objc var verticalConstraints: [NSLayoutConstraint] {
    return constraintsAffectingLayout(for: .vertical)
  }
  
  @objc var horizontalContentHuggingPriority: UILayoutPriority {
    return contentHuggingPriority(for: .horizontal)
  }
  
  @objc var verticalContentHuggingPriority: UILayoutPriority {
    return contentHuggingPriority(for: .vertical)
  }
  
  @objc var horizontalContentCompressionResistance: UILayoutPriority {
    return contentCompressionResistancePriority(for: .horizontal)
  }
  
  @objc var verticalContentCompressionResistance: UILayoutPriority {
    return contentCompressionResistancePriority(for: .vertical)
  }
  
  /**
   Configures Peek's properties for this object
   
   - parameter context: The context to apply these properties to
   */
    
    /*
  public override func preparePeek(_ context: Context) {
    super.preparePeek(context)
    
    context.configure(.layout, "General") { config in
      config.addProperties([ "frame", "bounds", "center", "intrinsicContentSize", "alignmentRectInsets" ])
      config.addProperty("translatesAutoresizingMaskIntoConstraints", displayName: "Autoresizing to Constraints", cellConfiguration: nil)
    }
    
    context.configure(.layout, "Content Hugging Priority") { (config) in
      config.addProperty("horizontalContentHuggingPriority", displayName: "Horizontal", cellConfiguration: nil)
      config.addProperty("verticalContentHuggingPriority", displayName: "Vertical", cellConfiguration: nil)
    }
    
    context.configure(.layout, "Content Compression Resistance") { (config) in
      config.addProperty("horizontalContentCompressionResistance", displayName: "Horizontal", cellConfiguration: nil)
      config.addProperty("verticalContentCompressionResistance", displayName: "Vertical", cellConfiguration: nil)
    }
    
    context.configure(.layout, "Constraints") { (config) in
      config.addProperty("horizontalConstraints", displayName: "Horizontal", cellConfiguration: nil)
      config.addProperty("verticalConstraints", displayName: "Vertical", cellConfiguration: nil)
    }
    
    context.configure(.view, "Appearance") { (config) in
      config.addProperty("contentMode", displayName: nil, cellConfiguration: { (cell, view, value) in
        if let mode = UIViewContentMode(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
    }
    
    context.configure(.view, "Interaction") { config in
      config.addProperties([ "userInteractionEnabled", "multipleTouchEnabled", "exclusiveTouch" ])
    }
    
    context.configure(.view, "Color") { config in
      config.addProperties([ "alpha", "backgroundColor", "tintColor" ])
      
      config.addProperty("tintAdjustmentMode", displayName: nil, cellConfiguration: { (cell, view, value) in
        if let mode = UIViewTintAdjustmentMode(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
    }
    
    context.configure(.view, "Drawing") { config in
      config.addProperties([ "opaque", "hidden", "clipsToBounds" ])
    }
    
    context.configure(.view, "General") { config in
      config.addProperties([ "tag", "class", "superclass" ])
    }
    
    context.configure(.layout, "Layer") { (config) in
      config.addProperties([ "layer.position", "layer.anchorPoint", "layer.zPosition", "layer.geometryFlipped", "layer.anchorPointZ",  ])
    }
  }
 */
  
}
