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

extension NSLayoutConstraint {
    
    open override var description: String {
        var name = "\(perform(Selector(("asciiArtDescription"))))".components(separatedBy: ": ").last
        
        if name == "nil" {
            name = super.description
        }
        
        return name ?? super.description
    }
    
    @objc var peek_firstItem: String {
        guard let item = firstItem else { return "nil" }
        return "\(item.classForCoder!)"
    }
    
    @objc var peek_secondItem: String {
        guard let item = secondItem else { return "nil" }
        return "\(item.classForCoder!)"
    }
    
    /**
     Configures Peek's properties for this object
     
     - parameter context: The context to apply these properties to
     */
    public override func preparePeek(_ context: Context) {
        super.preparePeek(context)
        
        context.configure(.attributes, "Behaviour") { (config) in
            config.addProperties([ "active", "shouldBeArchived" ])
        }
        
        context.configure(.attributes, "Item") { config in
            config.addProperty("peek_firstItem", displayName: "First Item", cellConfiguration: nil)
            config.addProperty("firstAttribute", displayName: "First Attribute", cellConfiguration: { (cell, object, value) in
                if let mode = NSLayoutAttribute(rawValue: value as! Int) {
                    cell.detailTextLabel?.text = mode.description
                }
            })
            
            config.addProperty("peek_secondItem", displayName: "Second Item", cellConfiguration: nil)
            config.addProperty("secondAttribute", displayName: "Second Attribute", cellConfiguration: { (cell, object, value) in
                if let mode = NSLayoutAttribute(rawValue: value as! Int) {
                    cell.detailTextLabel?.text = mode.description
                }
            })
        }
        
        context.configure(.attributes, "Properties") { (config) in
            config.addProperty("relation", displayName: nil, cellConfiguration: { (cell, object, value) in
                if let mode = NSLayoutRelation(rawValue: value as! Int) {
                    cell.detailTextLabel?.text = mode.description
                }
            })
            
            config.addProperties([ "constant", "multiplier", "priority" ])
        }
    }
    
}
