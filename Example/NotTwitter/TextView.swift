//
//  TextView.swift
//  NotTwitter
//
//  Created by Shaps Benkau on 10/03/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit

public final class TextView: UITextView {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }
    
}
