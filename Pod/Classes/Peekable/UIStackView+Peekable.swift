//
//  UIStackView+Peekable.swift
//  Peek
//
//  Created by Shaps Benkau on 10/03/2018.
//

import UIKit

extension UIStackView {
    
    open override func preparePeek(with coordinator: Coordinator) {
        coordinator.appendTransformed(keyPaths: ["axis"], valueTransformer: { value in
            guard let rawValue = value as? Int, let axis = UILayoutConstraintAxis(rawValue: rawValue) else { return nil }
            return axis.description
        }, forModel: self, in: .appearance)
        
        coordinator.appendTransformed(keyPaths: ["distribution"], valueTransformer: { value in
            guard let rawValue = value as? Int, let distribution = UIStackViewDistribution(rawValue: rawValue) else { return nil }
            return distribution
        }, forModel: self, in: .appearance)
        
        coordinator.appendTransformed(keyPaths: ["alignment"], valueTransformer: { value in
            guard let rawValue = value as? Int, let alignment = UIStackViewAlignment(rawValue: rawValue) else { return nil }
            return alignment
        }, forModel: self, in: .appearance)
        
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
