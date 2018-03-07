//
//  PeekButton.swift
//  Peek
//
//  Created by Shaps Benkau on 07/03/2018.
//

import UIKit

internal final class PeekButton: UIControl {
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
    }()
    
    private lazy var visualEffectView: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    }()
    
    private lazy var imageView: UIImageView = {
        return UIImageView(image: Images.attributes)
    }()
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(visualEffectView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor),
            equal(\.topAnchor), equal(\.bottomAnchor)
        ])
        
        visualEffectView.contentView.addSubview(imageView, constraints: [
            equal(\.centerXAnchor), equal(\.centerYAnchor)
        ])
        
        addGestureRecognizer(tapGesture)
        backgroundColor = .clear
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        sendActions(for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        setAlpha(0.8)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        setAlpha(1)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        setAlpha(1)
    }
    
    private func setAlpha(_ alpha: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.alpha = alpha
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = bounds.height / 2
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: size / 2)
        
        visualEffectView.layer.cornerRadius = size
        visualEffectView.layer.masksToBounds = true
        
        layer.shadowPath = path.cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
    
}
