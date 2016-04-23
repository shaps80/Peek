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

extension UIStepper {
  
  @objc var normalIncrementImage: UIImage? {
    return incrementImageForState(.Normal)
  }
  
  @objc var disabledIncrementImage: UIImage? {
    return incrementImageForState(.Disabled)
  }
  
  @objc var highlightedIncrementImage: UIImage? {
    return incrementImageForState(.Highlighted)
  }
  
  @objc var selectedIncrementImage: UIImage? {
    return incrementImageForState(.Selected)
  }
  
  @objc var normalDecrementImage: UIImage? {
    return decrementImageForState(.Normal)
  }
  
  @objc var disabledDecrementImage: UIImage? {
    return decrementImageForState(.Disabled)
  }
  
  @objc var highlightedDecrementImage: UIImage? {
    return decrementImageForState(.Highlighted)
  }
  
  @objc var selectedDecrementImage: UIImage? {
    return decrementImageForState(.Selected)
  }
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "continuous", "wraps" ])
      
      config.addProperty("autorepeat", displayName: "Auto Repeat", cellConfiguration: nil)
    }
    
    context.configure(.Attributes, "General") { (config) in
      config.addProperties([ "value", "minimumValue", "maximumValue", "stepValue" ])
    }
    
    context.configure(.Attributes, "Increment Images") { (config) in
      config.addProperty("normalIncrementImage", displayName: "Normal", cellConfiguration: nil)
      config.addProperty("disabledIncrementImage", displayName: "Disabled", cellConfiguration: nil)
      config.addProperty("highlightedIncrementImage", displayName: "Highlighted", cellConfiguration: nil)
      config.addProperty("selectedIncrementImage", displayName: "Selected", cellConfiguration: nil)
    }
    
    context.configure(.Attributes, "Decrement Images") { (config) in
      config.addProperty("normalDecrementImage", displayName: "Normal", cellConfiguration: nil)
      config.addProperty("disabledDecrementImage", displayName: "Disabled", cellConfiguration: nil)
      config.addProperty("highlightedDecrementImage", displayName: "Highlighted", cellConfiguration: nil)
      config.addProperty("selectedDecrementImage", displayName: "Selected", cellConfiguration: nil)
    }
  
  }
  
}