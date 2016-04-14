//
//  HighlightView.swift
//  Pods
//
//  Created by Shaps Mohsenin on 07/02/2016.
//
//

import UIKit

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

final class HighlightView: UIView {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init(color: UIColor) {
    super.init(frame: CGRectZero)
    
    backgroundColor = UIColor.clearColor()
    layer.borderColor = color.CGColor
    layer.cornerRadius = 2
    layer.borderWidth = 1
  }
  
  private(set) lazy var leftMetricLabel: MetricLabel = {
    let label = MetricLabel()
    self.addSubview(label)
    
    label.alignVertically(self)
    label.pin(.Right, toEdge: .Left, toView: self, margin: 2)

    return label
  }()
  
  private(set) lazy var topMetricLabel: MetricLabel = {
    let label = MetricLabel()
    self.addSubview(label)
    
    label.alignHorizontally(self)
    label.pin(.Bottom, toEdge: .Top, toView: self, margin: 2)
    
    return label
  }()
  
  private(set) lazy var rightMetricLabel: MetricLabel = {
    let label = MetricLabel()
    self.addSubview(label)
    
    label.alignVertically(self)
    label.pin(.Left, toEdge: .Right, toView: self, margin: 2)
    
    return label
  }()
  
  private(set) lazy var bottomMetricLabel: MetricLabel = {
    let label = MetricLabel()
    self.addSubview(label)
    
    label.alignHorizontally(self)
    label.pin(.Top, toEdge: .Bottom, toView: self, margin: 2)
    
    return label
  }()
  
  func setMetrics(metrics: Metrics) {
    setValue(metrics.left, forMetricsLabel: leftMetricLabel)
    setValue(metrics.right, forMetricsLabel: rightMetricLabel)
    setValue(metrics.top, forMetricsLabel: topMetricLabel)
    setValue(metrics.bottom, forMetricsLabel: bottomMetricLabel)
  }
  
  func setValue(value: CGFloat, forMetricsLabel label: MetricLabel) {
    if value != 0 {
      label.text = MetricLabel.formatter.stringFromNumber(value)
      label.hidden = false
    } else {
      label.hidden = true
    }
  }
  
}

final class MetricLabel: UILabel {
  
  static let formatter: NSNumberFormatter = {
    let formatter = NSNumberFormatter()
    formatter.maximumFractionDigits = 1
    formatter.minimumFractionDigits = 0
    formatter.roundingIncrement = 0.5
    return formatter
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init() {
    super.init(frame: CGRectZero)
    
    font = UIFont.systemFontOfSize(10)
    backgroundColor = UIColor(white: 0.03, alpha: 0.9)
    textColor = UIColor.whiteColor()
    layer.masksToBounds = true
    layer.cornerRadius = 3
    textAlignment = .Center
    
    setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Horizontal)
    setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
    
    setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
    setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
  }
  
  override func intrinsicContentSize() -> CGSize {
    let size = super.intrinsicContentSize()
    return CGSizeMake(size.width + 4, size.height + 2)
  }
  
}

