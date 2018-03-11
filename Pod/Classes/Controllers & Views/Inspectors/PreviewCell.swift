//
//  PreviewCell.swift
//  Peek
//
//  Created by Shaps Benkau on 24/02/2018.
//

import UIKit

internal final class PreviewCell: UITableViewCell {
    
    internal let previewImageView: UIImageView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        previewImageView = UIImageView()
        previewImageView.contentMode = .scaleAspectFit
        previewImageView.clipsToBounds = true
        
        previewImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        previewImageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        previewImageView.setContentHuggingPriority(.required, for: .vertical)
        previewImageView.setContentCompressionResistancePriority(.required, for: .vertical)
        previewImageView.tintColor = .primaryTint
        
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        addSubview(previewImageView, constraints: [
            equal(\.layoutMarginsGuide.leadingAnchor, \.leadingAnchor),
            equal(\.layoutMarginsGuide.trailingAnchor, \.trailingAnchor),
            equal(\.topAnchor, constant: -16),
            equal(\.bottomAnchor, constant: 16)
        ])
        
        clipsToBounds = true
        contentView.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
