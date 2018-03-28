//
//  UIStackView+Peekable.swift
//  Peek
//
//  Created by Shaps Benkau on 10/03/2018.
//

import UIKit

extension UIStackView {
    
    open override func preparePeek(with coordinator: Coordinator) {
        (coordinator as? SwiftCoordinator)?
            .appendEnum(keyPath: "axis", into: UILayoutConstraintAxis.self, forModel: self, group: .appearance)
            .appendEnum(keyPath: "distribution", into: UIStackViewDistribution.self, forModel: self, group: .appearance)
            .appendEnum(keyPath: "alignment", into: UIStackViewAlignment.self, forModel: self, group: .appearance)
        
        coordinator.appendDynamic(keyPaths: [
            "spacing"
        ], forModel: self, in: .appearance)
        
        coordinator.appendDynamic(keyPathToName: [
            ["isBaselineRelativeArrangement": "Relative to Baseline"],
            ["isLayoutMarginsRelativeArrangement": "Relative to Margins"]
        ], forModel: self, in: .layout)
        
        super.preparePeek(with: coordinator)
    }
    
}
