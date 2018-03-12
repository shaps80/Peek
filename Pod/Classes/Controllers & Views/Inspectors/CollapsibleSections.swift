//
//  Sections.swift
//  GraphicsRenderer
//
//  Created by Shaps Benkau on 23/02/2018.
//

import Foundation
import GraphicsRenderer

private func radians(fromDegrees degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(Double.pi) / 180
}

internal struct CollapsibleSection {
    internal let group: PeekGroup
    internal let items: [CollapsibleItem]
    
    internal var isExpanded: Bool {
        get { return UserDefaults.standard.bool(forKey: group.title) }
        set { UserDefaults.standard.set(newValue, forKey: group.title) }
    }
    
    internal init(group: PeekGroup, items: [CollapsibleItem]) {
        self.group = group
        self.items = items
    }
}

internal struct CollapsibleItem {
    internal let title: String
    internal let attribute: Attribute
}

internal protocol CollapsibleSectionHeaderViewDelegate: class {
    func sectionHeader(_ view: CollapsibleSectionHeaderView, shouldToggleAt index: Int)
}

internal final class CollapsibleSectionHeaderView: UITableViewHeaderFooterView {
    
    internal weak var delegate: CollapsibleSectionHeaderViewDelegate? {
        didSet {
            imageView.isHidden = delegate == nil
            gesture.isEnabled = delegate != nil
        }
    }
    
    internal let label: UILabel
    private lazy var gesture: UITapGestureRecognizer = {
        UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
    }()
    
    private let imageView: UIImageView
    
    override init(reuseIdentifier: String?) {
        label = UILabel(frame: .zero)
        imageView = UIImageView(image: nil) // collapsed/expanded indicator
        imageView.isHidden = true
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        let thickness: CGFloat = 1.5
        let size = CGSize(width: 13 + thickness, height: 8 + thickness)
        imageView.image = Images.disclosure(size: size, thickness: thickness)
        
        imageView.tintColor = .neutral
        label.numberOfLines = 0
        
        contentView.addSubview(imageView, constraints: [
            equal(\.centerYAnchor),
            equal(\.layoutMarginsGuide.trailingAnchor, \.trailingAnchor),
        ])
        
        contentView.addSubview(label, constraints: [
            equal(\.layoutMarginsGuide.leadingAnchor, \.leadingAnchor),
            equal(\.topAnchor, constant: -12),
            equal(\.bottomAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16)
        ])
        
        gesture.isEnabled = false
        addGestureRecognizer(gesture)
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        delegate?.sectionHeader(self, shouldToggleAt: tag)
    }
    
    func setExpanded(_ expanded: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.25, animations: {
            let angle = radians(fromDegrees: -90)
            self.imageView.transform = expanded ? .identity : CGAffineTransform(rotationAngle: angle)
        }, completion: { _ in
            completion?()
        })
    }
    
    func prepareHeader(for section: Int, delegate: CollapsibleSectionHeaderViewDelegate) {
        tag = section
        self.delegate = delegate
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
