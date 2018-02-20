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

/**
 *  Represents 4 metrics, top, left, bottom & right
 */
struct Metrics {
    
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

/// Defines a view that will be used to highlight in the overlay's view
final class HighlightView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(color: UIColor) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.clear
        layer.borderColor = color.cgColor
        layer.cornerRadius = 2
        layer.borderWidth = 1
    }
    
    fileprivate(set) lazy var leftMetricLabel: MetricLabel = {
        let label = MetricLabel()
        self.addSubview(label)
        
        label.align(axis: .vertical, to: self)
        label.pin(edge: .right, to: .left, of: self, margin: 2)
        
        return label
    }()
    
    fileprivate(set) lazy var topMetricLabel: MetricLabel = {
        let label = MetricLabel()
        self.addSubview(label)
        
        label.align(axis: .horizontal, to: self)
        label.pin(edge: .bottom, to: .top, of: self, margin: 2)
        
        return label
    }()
    
    fileprivate(set) lazy var rightMetricLabel: MetricLabel = {
        let label = MetricLabel()
        self.addSubview(label)
        
        label.align(axis: .vertical, to: self)
        label.pin(edge: .left, to: .right, of: self, margin: 2)
        
        return label
    }()
    
    fileprivate(set) lazy var bottomMetricLabel: MetricLabel = {
        let label = MetricLabel()
        self.addSubview(label)
        
        label.align(axis: .horizontal, to: self)
        label.pin(edge: .top, to: .bottom, of: self, margin: 2)
        
        return label
    }()
    
    func setMetrics(_ metrics: Metrics) {
        setValue(metrics.left, forMetricsLabel: leftMetricLabel)
        setValue(metrics.right, forMetricsLabel: rightMetricLabel)
        setValue(metrics.top, forMetricsLabel: topMetricLabel)
        setValue(metrics.bottom, forMetricsLabel: bottomMetricLabel)
    }
    
    func setValue(_ value: CGFloat, forMetricsLabel label: MetricLabel) {
        if value != 0 {
            label.text = MetricLabel.formatter.string(from: NSNumber(value: Float(value)))
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
    
}

/// Defines a label that will be used to represent a metric in the overlay view's
final class MetricLabel: UILabel {
    
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.roundingIncrement = 0.5
        return formatter
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        font = UIFont(name: "Avenir-Medium", size: 10.5)
        backgroundColor = UIColor(white: 0.03, alpha: 0.9)
        textColor = UIColor.white
        layer.masksToBounds = true
        layer.cornerRadius = 3
        textAlignment = .center
        
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
        
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
    }
    
    override var intrinsicContentSize : CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 4, height: size.height + 2)
    }
    
}
