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

internal struct Metrics {
    
    var top: CGFloat
    var left: CGFloat
    var bottom: CGFloat
    var right: CGFloat
    
    init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
    
}

internal final class PeekMetricView: UIVisualEffectView {
    
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.roundingIncrement = 0.5
        return formatter
    }()
    
    fileprivate let label: UILabel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init() {
        label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .textDark
        label.textAlignment = .center
        
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        super.init(effect: UIBlurEffect(style: .extraLight))
        
        layer.cornerRadius = 3
        layer.masksToBounds = true
        layer.zPosition = 100
        
        contentView.addSubview(label, constraints: [
            equal(\.leadingAnchor, constant: -2), equal(\.trailingAnchor, constant: 2),
            equal(\.topAnchor, constant: -1), equal(\.bottomAnchor, constant: 1)
        ])
    }
    
    internal func apply(value: CGFloat) {
        label.text = PeekMetricView.formatter.string(from: NSNumber(value: Float(value)))
        label.sizeToFit()
    }
    
}
