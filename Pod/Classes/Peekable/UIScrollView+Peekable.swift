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

extension UIScrollView {
    
    /**
     Configures Peek's properties for this object
     
     - parameter context: The context to apply these properties to
     */
    public override func preparePeek(_ context: Context) {
        super.preparePeek(context)
        
        context.configure(.layout, "Scroll View") { (config) in
            config.addProperties([ "contentOffset", "contentSize", "contentInset", "scrollIndicatorInsets" ])
        }
        
        context.configure(.attributes, "Behaviour") { (config) in
            config.addProperties([ "directionalLockEnabled", "pagingEnabled", "scrollEnabled", "decelerationRate", "scrollsToTop" ])
            
            config.addProperty("keyboardDismissMode", displayName: nil, cellConfiguration: { (cell, object, value) in
                let mode = UIScrollViewKeyboardDismissMode(rawValue: value as! Int)!
                cell.detailTextLabel?.text = mode.description
            })
        }
        
        context.configure(.attributes, "Indicators") { (config) in
            config.addProperties([ "showsHorizontalScrollIndicator", "showsVerticalScrollIndicator" ])
            
            config.addProperty("indicatorStyle", displayName: nil, cellConfiguration: { (cell, object, value) in
                let style = UIScrollViewIndicatorStyle(rawValue: value as! Int)!
                cell.detailTextLabel?.text = style.description
            })
        }
        
        context.configure(.attributes, "Zoom") { (config) in
            config.addProperties([ "minimumZoomScale", "maximumZoomScale", "zoomScale", "bouncesZoom" ])
        }
        
        context.configure(.attributes, "Bounce") { (config) in
            config.addProperties([ "bounces", "alwaysBounceVertical", "alwaysBounceHorizontal" ])
        }
    }
    
}
