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

extension CALayer {
  
  @objc var peek_borderColor: UIColor? {
    if let color = borderColor {
      return UIColor(cgColor: color)
    }
    
    return nil
  }
  
  @objc var peek_shadowColor: UIColor? {
    if let color = shadowColor {
      return UIColor(cgColor: color)
    }
    
    return nil
  }
  
  @objc var peek_backgroundColor: UIColor? {
    if let color = backgroundColor {
      return UIColor(cgColor: color)
    }
    
    return nil
  }
  
  /**
   Configures Peek's properties for this object
   
   - parameter context: The context to apply these properties to
   */
  public override func preparePeek(_ context: Context) {
    super.preparePeek(context)
    
    context.configure(.layer, "Appearance") { (config) in
      config.addProperty("layer.peek_backgroundColor", displayName: "Background Color", cellConfiguration: nil)
      config.addProperties([ "layer.cornerRadius", "layer.masksToBounds", "layer.doubleSided" ])
    }
    
    context.configure(.layer, "Visibility") { (config) in
      config.addProperties([ "layer.opacity", "layer.allowsGroupOpacity", "layer.hidden" ])
    }
    
    context.configure(.layer, "Rasterization") { (config) in
      config.addProperties([ "layer.shouldRasterize", "layer.rasterizationScale", "opaque" ])
    }
    
    context.configure(.layer, "Shadow") { (config) in
      config.addProperty("layer.peek_shadowColor", displayName: "Shadow Color", cellConfiguration: nil)
      config.addProperties([ "layer.shadowOffset", "layer.shadowOpacity", "layer.shadowRadius" ])
    }
    
    context.configure(.layer, "Border") { (config) in
      config.addProperty("layer.peek_borderColor", displayName: "Border Color", cellConfiguration: nil)
      config.addProperties([ "layer.borderWidth" ])
    }
    
    context.configure(.layer, "Contents") { (config) in
      config.addProperties([ "layer.contentsRect", "layer.contentsScale", "layer.contentsCenter" ])
      
      config.addProperty("layer.contentsGravity", displayName: nil, cellConfiguration: { (cell, object, value) in
        cell.detailTextLabel?.text = (value as? String)?.capitalized
      })
    }
  }
  
}
