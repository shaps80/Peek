//
//  Sections.swift
//  GraphicsRenderer
//
//  Created by Shaps Benkau on 23/02/2018.
//

import Foundation
import InkKit
import GraphicsRenderer

internal struct Section {
    internal let group: PeekGroup
    internal let items: [Item]
    
    internal var isExpanded: Bool {
        get { return UserDefaults.standard.bool(forKey: group.title) }
        set { UserDefaults.standard.set(newValue, forKey: group.title) }
    }
    
    internal init(group: PeekGroup, items: [Item]) {
        self.group = group
        self.items = items
    }
}

internal struct Item {
    internal let title: String
    internal let attribute: Attribute
}

internal protocol SectionHeaderViewDelegate: class {
    func sectionHeader(_ view: SectionHeaderView, shouldToggleAt index: Int)
}

internal final class SectionHeaderView: UITableViewHeaderFooterView {
    
    internal weak var delegate: SectionHeaderViewDelegate?
    
    internal let label: UILabel
    internal let separator: UIView
    
    private let imageView: UIImageView
    
    override init(reuseIdentifier: String?) {
        label = UILabel(frame: .zero)
        imageView = UIImageView(image: nil) // collapsed/expanded indicator
        separator = UIView(frame: .zero)
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        let lineWidth: CGFloat = 1.5
        imageView.image = ImageRenderer(size: CGSize(width: 8 + lineWidth, height: 13 + lineWidth)).image { context in
            let rect = context.format.bounds.insetBy(dx: lineWidth, dy: lineWidth)
            
            let path = UIBezierPath()
            path.move(to: rect.origin)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            path.lineWidth = lineWidth
            UIColor.white.setStroke()
            path.stroke()
        }
        
        contentView.backgroundColor = .inspectorBackground
        imageView.tintColor = .neutral
        label.numberOfLines = 0
        separator.backgroundColor = .separator
        
        contentView.addSubview(imageView, constraints: [
            equal(\.centerYAnchor),
            equal(\.layoutMarginsGuide.trailingAnchor, \.trailingAnchor),
        ])
        
        contentView.addSubview(label, constraints: [
            equal(\.layoutMarginsGuide.leadingAnchor, \.leadingAnchor),
            equal(\.topAnchor, constant: -12),
            equal(\.bottomAnchor, constant: 12)
        ])
        
        contentView.addSubview(separator, constraints: [
            equal(\.layoutMarginsGuide.leadingAnchor, \.leadingAnchor),
            equal(\.layoutMarginsGuide.trailingAnchor, \.trailingAnchor),
            sized(\.heightAnchor, constant: 1 / UIScreen.main.scale),
            equal(\.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16)
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        addGestureRecognizer(gesture)
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        delegate?.sectionHeader(self, shouldToggleAt: tag)
    }
    
    func setExpanded(_ expanded: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.25, animations: {
            let angle = radians(from: 90)
            self.imageView.transform = expanded ? CGAffineTransform(rotationAngle: angle) : .identity
        }, completion: { _ in
            completion?()
        })
    }
    
    func prepareHeader(for section: Int, delegate: SectionHeaderViewDelegate) {
        tag = section
        self.delegate = delegate
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
