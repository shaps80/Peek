//
//  Cell.swift
//  NotTwitter
//
//  Created by Shaps Benkau on 10/03/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit

public final class Cell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: TextView!
    @IBOutlet weak var embedImageView: UIImageView!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        replyButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        favouriteButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        shareButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        replyButton.titleLabel?.adjustsFontForContentSizeCategory = true
        favouriteButton.titleLabel?.adjustsFontForContentSizeCategory = true
        shareButton.titleLabel?.adjustsFontForContentSizeCategory = true
        
        replyButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        favouriteButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        shareButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .selection
    }
    
}
