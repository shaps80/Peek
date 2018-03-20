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
    
    private lazy var vibrancyView: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .extraLight)))
    }()
    
    private lazy var visualEffectView: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
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
        
        UIView.animate(withDuration: 0.15) {
            self.visualEffectView.backgroundColor = .primaryTint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: 0.15) {
            self.visualEffectView.backgroundColor = nil
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        UIView.animate(withDuration: 0.15) {
            self.visualEffectView.backgroundColor = nil
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
