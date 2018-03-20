//
//  PeekLayoutView.swift
//  Peek
//
//  Created by Shaps Benkau on 12/03/2018.
//

import UIKit

extension CGRect {
    internal static func distance(from: CGRect, to: CGRect, in bounds: CGRect) -> Metrics {
        let left: CGFloat, right: CGFloat
        let top: CGFloat, bottom: CGFloat
        
        let hSpacing = bounds.width - (from.width + to.width)
        let vSpacing = bounds.height - (from.height + to.height)
        
        if to.minX == from.minX && to.maxX == from.maxX {
            right = 0
            left = 0
        } else if from.minX >= to.minX && from.maxX <= to.maxX {
            left = from.minX - to.minX
            right = to.maxX - from.maxX
        } else if to.minX >= from.minX && to.maxX <= from.maxX {
            left = to.minX - from.minX
            right = from.maxX - to.maxX
        } else if to.minX < from.minX {
            left = 0
            right = hSpacing
        } else {
            left = hSpacing
            right = 0
        }
        
        if to.minY == from.minY && to.maxY == from.maxY {
            top = 0
            bottom = 0
        } else if from.minY >= to.minY && from.maxY <= to.maxY {
            top = from.minY - to.minY
            bottom = to.maxY - from.maxY
        } else if to.minY >= from.minY && to.maxY <= from.maxY {
            top = to.minY - from.minY
            bottom = from.maxY - to.maxY
        } else if to.minY < from.minY {
            top = 0
            bottom = vSpacing
        } else {
            top = vSpacing
            bottom = 0
        }
        
        return Metrics(top: top, left: left, bottom: bottom, right: right)
    }
}

internal final class PeekLayoutView: PeekSelectionView {
    
    internal weak var primaryView: UIView?
    internal weak var secondaryView: UIView?
    internal weak var primarySelectionView: PeekSelectionView?
    internal weak var secondarySelectionView: PeekSelectionView?
    internal weak var overlayView: PeekOverlayView!
    
    internal let leftMetric: PeekMetricView
    internal let topMetric: PeekMetricView
    internal let rightMetric: PeekMetricView
    internal let bottomMetric: PeekMetricView
    
    init(overlayView: PeekOverlayView, borderColor: UIColor?, borderWidth: CGFloat, dashed: Bool) {
        self.overlayView = overlayView
        
        leftMetric = PeekMetricView()
        topMetric = PeekMetricView()
        rightMetric = PeekMetricView()
        bottomMetric = PeekMetricView()
        
        rightMetric.translatesAutoresizingMaskIntoConstraints = false
        topMetric.translatesAutoresizingMaskIntoConstraints = false
        bottomMetric.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(borderColor: borderColor, borderWidth: borderWidth, dashed: dashed)
        clipsToBounds = false
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refresh() {
        setNeedsDisplay()
        
        guard let primary = primarySelectionView, let secondary = secondarySelectionView else { return }
        
        let primaryFrame = primaryView?.frameInPeek(overlayView) ?? .zero
        let secondaryFrame = secondaryView?.frameInPeek(overlayView) ?? .zero
        let distance = CGRect.distance(from: primaryFrame, to: secondaryFrame, in: bounds)
        
        if distance.left == 0 {
            leftMetric.removeFromSuperview()
        } else {
            leftMetric.apply(value: distance.left)

            overlayView.addSubview(leftMetric)
            leftMetric.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                leftMetric.trailingAnchor.constraint(equalTo: secondary.leadingAnchor, constant: -2),
                leftMetric.centerYAnchor.constraint(equalTo: secondary.centerYAnchor)
            ])
        }
        
        if distance.top == 0 {
            topMetric.removeFromSuperview()
        } else {
            topMetric.apply(value: distance.top)
            
            let guide = UILayoutGuide()
            overlayView.addLayoutGuide(guide)
            overlayView.addSubview(topMetric)
            
            topMetric.translatesAutoresizingMaskIntoConstraints = false
            
            if secondaryFrame.maxY > primaryFrame.minY {
                NSLayoutConstraint.activate([
                    guide.topAnchor.constraint(equalTo: secondary.topAnchor),
                    guide.bottomAnchor.constraint(equalTo: primary.topAnchor),
                ])
            } else {
                NSLayoutConstraint.activate([
                    guide.topAnchor.constraint(equalTo: secondary.bottomAnchor),
                    guide.bottomAnchor.constraint(equalTo: primary.topAnchor),
                ])
            }
            
            if secondaryFrame.maxX > primaryFrame.minX {
                NSLayoutConstraint.activate([
                    guide.leadingAnchor.constraint(equalTo: secondary.leadingAnchor),
                    guide.trailingAnchor.constraint(equalTo: primary.leadingAnchor),
                ])
            } else {
                NSLayoutConstraint.activate([
                    guide.leadingAnchor.constraint(equalTo: secondary.trailingAnchor),
                    guide.trailingAnchor.constraint(equalTo: primary.leadingAnchor),
                ])
            }
            
            NSLayoutConstraint.activate([
                topMetric.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
                topMetric.centerYAnchor.constraint(equalTo: guide.centerYAnchor)
            ])
        }
                
        if distance.right == 0 {
            rightMetric.removeFromSuperview()
        } else {
            rightMetric.apply(value: distance.right)
            
            overlayView.addSubview(rightMetric)
            rightMetric.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                rightMetric.leadingAnchor.constraint(equalTo: secondary.trailingAnchor, constant: 2),
                rightMetric.centerYAnchor.constraint(equalTo: secondary.centerYAnchor)
            ])
        }
        
        if distance.bottom == 0 {
            bottomMetric.removeFromSuperview()
        } else {
            bottomMetric.apply(value: distance.bottom)
            
            overlayView.addSubview(bottomMetric)
            bottomMetric.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                bottomMetric.topAnchor.constraint(equalTo: secondary.bottomAnchor, constant: 2),
                bottomMetric.centerXAnchor.constraint(equalTo: secondary.centerXAnchor)
            ])
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        UIColor(white: 1, alpha: 0.5).setStroke()
        path.setLineDash([1, 2], count: 2, phase: 0)
        path.stroke()
    }
    
}
