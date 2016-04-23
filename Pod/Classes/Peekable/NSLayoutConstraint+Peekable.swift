/*
  Copyright © 23/04/2016 Snippex

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
  
  public override var description: String {
    var name = "\(performSelector("asciiArtDescription"))".componentsSeparatedByString(": ").last
    
    if name == "nil" {
      name = super.description
    }
    
    return name ?? super.description
  }
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "active", "shouldBeArchived" ])
    }
    
    context.configure(.Attributes, "Items") { (config) in
      config.addProperties([ "firstItem", "secondItem" ])
    }
    
    context.configure(.Attributes, "Attributes") { (config) in
      config.addProperty("firstAttribute", displayName: "First", cellConfiguration: { (cell, object, value) in
        if let mode = NSLayoutAttribute(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
      
      config.addProperty("secondAttribute", displayName: "Second", cellConfiguration: { (cell, object, value) in
        if let mode = NSLayoutAttribute(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
    }
    
    context.configure(.Attributes, "Properties") { (config) in
      config.addProperty("relation", displayName: nil, cellConfiguration: { (cell, object, value) in
        if let mode = NSLayoutRelation(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
      
      config.addProperties([ "constant", "multiplier", "priority" ])
    }
  }
  
}