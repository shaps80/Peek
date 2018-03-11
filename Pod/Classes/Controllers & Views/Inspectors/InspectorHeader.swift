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

/// Some properties can provide an optional header for better representing an object. E.g. image, color, etc...
final class InspectorHeader: UIView {
    
    init(image: UIImage, showBorder: Bool) {
        let width = min(280, image.size.width) + 20
        let height = min(100, image.size.height) + 20
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        var headerImage: UIImage?
        
        switch image.renderingMode {
        case .alwaysTemplate, .automatic:
            headerImage = image.withRenderingMode(.alwaysTemplate)
        case .alwaysOriginal:
            headerImage = image
        }
        
        let imageView = UIImageView(image: headerImage)
        imageView.backgroundColor = UIColor.clear
        imageView.clipsToBounds = true
        imageView.frame = rect.insetBy(dx: 10, dy: 10)
        imageView.contentMode = imageView.bounds.width > 280 || imageView.bounds.width > height ? .scaleAspectFit : .center
        
        var frame = rect
        frame.size.height -= 20
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        clipsToBounds = true
        
        addSubview(imageView, constraints: [
            sized(\.widthAnchor, constant: imageView.bounds.width),
            sized(\.heightAnchor, constant: imageView.bounds.height),
            equal(\.centerXAnchor), equal(\.centerYAnchor)
        ])
        
        if showBorder {
            let borderView = DashedBorderView(frame: rect)
            borderView.clipsToBounds = true
            borderView.backgroundColor = UIColor.clear
            
            addSubview(borderView, constraints: [
                equal(\.leadingAnchor), equal(\.trailingAnchor),
                equal(\.topAnchor), equal(\.bottomAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: rect.width),
            heightAnchor.constraint(equalToConstant: rect.height)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

private class DashedBorderView: UIView {
    
    fileprivate override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    fileprivate override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let color = UIColor(white: 1, alpha: 0.3)
        let path = UIBezierPath(roundedRect: rect.insetBy(dx: 1, dy: 1), cornerRadius: 2)
        
        color.setStroke()
        path.setLineDash([2, 4], count: 2, phase: 0)
        path.lineWidth = 1
        path.stroke()
    }
    
}
