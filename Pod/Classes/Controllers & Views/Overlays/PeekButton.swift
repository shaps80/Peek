//
//  PeekButton.swift
//  Peek
//
//  Created by Shaps Benkau on 07/03/2018.
//

import UIKit

internal final class PeekButton: UIControl {
    
    private var feedbackGenerator: Any?
    
    @available(iOS 10.0, *)
    private func haptic() -> UIImpactFeedbackGenerator? {
        return feedbackGenerator as? UIImpactFeedbackGenerator
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
    }()
    
    private lazy var vibrancyView: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    }()
    
    private lazy var visualEffectView: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blur.contentView.addSubview(vibrancyView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor),
            equal(\.topAnchor), equal(\.bottomAnchor)
        ])
        return blur
    }()
    
    private lazy var imageView: UIImageView = {
        return UIImageView(image: Images.attributes)
    }()
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 11.0, *) {
            accessibilityIgnoresInvertColors = true
        }
        
        vibrancyView.contentView.addSubview(imageView, constraints: [
            equal(\.centerXAnchor), equal(\.centerYAnchor)
        ])
        
        addSubview(visualEffectView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor),
            equal(\.topAnchor), equal(\.bottomAnchor)
        ])
        
        addGestureRecognizer(tapGesture)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        sendActions(for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        setTransform(CGAffineTransform(scaleX: 1.5, y: 1.5))
        
        if #available(iOS 10.0, *) {
            feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            haptic()?.impactOccurred()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        setTransform(.identity)
        feedbackGenerator = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        setTransform(.identity)
        feedbackGenerator = nil
    }
    
    private func setTransform(_ transform: CGAffineTransform) {
        let damping: CGFloat = transform == .identity ? 1 : 0.45
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
            self.transform = transform
        }, completion: nil)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = bounds.height / 2
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: size / 2)
        
        visualEffectView.layer.cornerRadius = size
        visualEffectView.layer.masksToBounds = true
    }
    
}
