//
//  EmbedContainerView.swift
//  NotTwitter
//
//  Created by Shaps Benkau on 10/03/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit

public final class EmbedContainerView: UIControl {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        prepare()
    }
    
    private func prepare() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderColor = UIColor.separator.cgColor
        layer.borderWidth = 1 / UIScreen.main.scale
    }
    
}
