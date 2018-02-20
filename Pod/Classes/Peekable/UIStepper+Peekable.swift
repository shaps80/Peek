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
        return incrementImage(for: UIControlState())
    }
    
    @objc var disabledIncrementImage: UIImage? {
        return incrementImage(for: .disabled)
    }
    
    @objc var highlightedIncrementImage: UIImage? {
        return incrementImage(for: .highlighted)
    }
    
    @objc var selectedIncrementImage: UIImage? {
        return incrementImage(for: .selected)
    }
    
    @objc var normalDecrementImage: UIImage? {
        return decrementImage(for: UIControlState())
    }
    
    @objc var disabledDecrementImage: UIImage? {
        return decrementImage(for: .disabled)
    }
    
    @objc var highlightedDecrementImage: UIImage? {
        return decrementImage(for: .highlighted)
    }
    
    @objc var selectedDecrementImage: UIImage? {
        return decrementImage(for: .selected)
    }
    
    /**
     Configures Peek's properties for this object
     
     - parameter context: The context to apply these properties to
     */
    public override func preparePeek(_ context: Context) {
        super.preparePeek(context)
        
        context.configure(.attributes, "Behaviour") { (config) in
            config.addProperties([ "continuous", "wraps" ])
            
            config.addProperty("autorepeat", displayName: "Auto Repeat", cellConfiguration: nil)
        }
        
        context.configure(.attributes, "General") { (config) in
            config.addProperties([ "value", "minimumValue", "maximumValue", "stepValue" ])
        }
        
        context.configure(.attributes, "Increment Images") { (config) in
            config.addProperty("normalIncrementImage", displayName: "Normal", cellConfiguration: nil)
            config.addProperty("disabledIncrementImage", displayName: "Disabled", cellConfiguration: nil)
            config.addProperty("highlightedIncrementImage", displayName: "Highlighted", cellConfiguration: nil)
            config.addProperty("selectedIncrementImage", displayName: "Selected", cellConfiguration: nil)
        }
        
        context.configure(.attributes, "Decrement Images") { (config) in
            config.addProperty("normalDecrementImage", displayName: "Normal", cellConfiguration: nil)
            config.addProperty("disabledDecrementImage", displayName: "Disabled", cellConfiguration: nil)
            config.addProperty("highlightedDecrementImage", displayName: "Highlighted", cellConfiguration: nil)
            config.addProperty("selectedDecrementImage", displayName: "Selected", cellConfiguration: nil)
        }
        
    }
    
}
