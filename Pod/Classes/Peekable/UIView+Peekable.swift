/*
 Copyright © 23/04/2016 Shaps
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit
import GraphicsRenderer

extension UIView {
    
    @objc fileprivate var horizontalConstraints: [NSLayoutConstraint] {
        return constraintsAffectingLayout(for: .horizontal)
    }
    
    @objc fileprivate var verticalConstraints: [NSLayoutConstraint] {
        return constraintsAffectingLayout(for: .vertical)
    }
    
    @objc fileprivate var horizontalContentHuggingPriority: UILayoutPriority {
        return contentHuggingPriority(for: .horizontal)
    }
    
    @objc fileprivate var verticalContentHuggingPriority: UILayoutPriority {
        return contentHuggingPriority(for: .vertical)
    }
    
    @objc fileprivate var horizontalContentCompressionResistance: UILayoutPriority {
        return contentCompressionResistancePriority(for: .horizontal)
    }
    
    @objc fileprivate var verticalContentCompressionResistance: UILayoutPriority {
        return contentCompressionResistancePriority(for: .vertical)
    }
    
    @objc private var peek_application: UIApplication {
        return UIApplication.shared
    }
    
    @objc private var peek_screen: UIScreen {
        return UIScreen.main
    }
    
    @objc private var peek_device: UIDevice {
        return UIDevice.current
    }
    
    open override func preparePeek(with coordinator: Coordinator) {
        if bounds.size != .zero, alpha > 0, !isHidden {
            let image = ImageRenderer(size: bounds.size).image { [weak self] context in
                let rect = context.format.bounds
                self?.drawHierarchy(in: rect, afterScreenUpdates: true)
            }
            
            coordinator.appendPreview(image: image, forModel: self)
        }
        
        var current = classForCoder
        var classHierarchy = [String(describing: current)]
        
        while let next = current.superclass() {
            classHierarchy.append(String(describing: next))
            current = next
        }
        
        for `class` in classHierarchy {
            coordinator.appendStatic(keyPath: "classForCoder", title: String(describing: `class`), detail: nil, value: "", in: .classes)
        }
        
        if let superview = superview {
            coordinator.appendStatic(keyPath: "superview", title: String(describing: superview.classForCoder), detail: "", value: superview, in: .views)
        }
        
        coordinator.appendStatic(keyPath: "self", title: String(describing: classForCoder), detail: "", value: self, in: .views)
        
        for view in subviews.reversed() {
            coordinator.appendStatic(keyPath: "classForCoder", title: String(describing: view.classForCoder), detail: "", value: view, in: .views)
        }
        
        coordinator.appendDynamic(keyPathToName: [
            ["isAccessibilityElement": "Enabled"],
            ["accessibilityIdentifier": "Identifier"],
            ["accessibilityLabel": "Label"],
            ["accessibilityValue": "Value"],
            ["accessibilityHint": "Hint"],
            ["accessibilityPath": "Path"],
            ["accessibilityFrame": "Frame"],
        ], forModel: self, in: .accessibility)
        
        coordinator.appendDynamic(keyPaths: [
            "userInteractionEnabled",
            "multipleTouchEnabled",
            "exclusiveTouch"
        ], forModel: self, in: .general)
        
        coordinator.appendDynamic(keyPaths: ["tintColor"], forModel: self, in: .appearance)
        
        coordinator.appendTransformed(keyPaths: ["tintAdjustmentMode"], valueTransformer: { value in
            guard let rawValue = value as? Int, let adjustmodeMode = UIViewTintAdjustmentMode(rawValue: rawValue) else { return nil }
            return adjustmodeMode.description
        }, forModel: self, in: .appearance)
        
        coordinator.appendDynamic(keyPaths: [
            "backgroundColor",
            "alpha",
            "hidden",
            "opaque",
            "layer.cornerRadius",
            "clipsToBounds",
            "layer.masksToBounds",
        ], forModel: self, in: .appearance)
        
        coordinator.appendTransformed(keyPaths: ["contentMode"], valueTransformer: { value in
            guard let rawValue = value as? Int, let contentMode = UIViewContentMode(rawValue: rawValue) else { return nil }
            return contentMode.description
        }, forModel: self, in: .layout)
        
        coordinator.appendDynamic(keyPaths: [
            "frame",
            "bounds",
            "center",
            "intrinsicContentSize",
            "alignmentRectInsets",
            "layoutMargins",
        ], forModel: self, in: .layout)
        
        if #available(iOS 11.0, *) {
            coordinator.appendDynamic(keyPaths: [
                "safeAreaInsets"
                ], forModel: self, in: .layout)
            
            coordinator.appendDynamic(keyPaths: [
                "preservesSuperviewLayoutMargins",
                "insetsLayoutMarginsFromSafeArea"
                ], forModel: self, in: .layout)
        }
        
        coordinator.appendStatic(keyPath: "translatesAutoresizingMaskIntoConstraints",
                                 title: "Uses AutoLayout",
                                 detail: nil,
                                 value: !translatesAutoresizingMaskIntoConstraints,
                                 in: .constraints)
        
        if !translatesAutoresizingMaskIntoConstraints {
            let constraints = Constraints(view: self)
            let count = horizontalConstraints.count + verticalConstraints.count
            coordinator.appendStatic(keyPath: "none", title: "Constraints", detail: "\(count)", value: constraints, in: .constraints)
        }
        
        coordinator.appendStatic(keyPath: "layer", title: "Layer", detail: String(describing: layer.classForCoder), value: layer, in: .more)
        
        coordinator.appendDynamic(keyPathToName: [
            ["owningViewController": "View Controller"]
            ], forModel: self, in: .more)

        coordinator.appendStatic(keyPath: "UIApplication.shared", title: "Application", detail: Bundle.main.appName, value: UIApplication.shared, in: .more)
        coordinator.appendStatic(keyPath: "UIDevice.current", title: "Device", detail: UIDevice.current.name, value: UIDevice.current, in: .more)
        
        let screen = ValueTransformer().transformedValue(UIScreen.main.bounds.size) as? String
        coordinator.appendStatic(keyPath: "UIScreen.main", title: "Screen", detail: screen, value: UIScreen.main, in: .more)
        
        if self is UILabel || self is UITextField || self is UITextView {
            if let value = value(forKeyPath: "font.peek_textStyle") as? String {
                coordinator.appendStatic(keyPath: "font.peek_textStyle", title: "Text Style", detail: value, value: value, in: .typography)
            }
        }
        
        if #available(iOS 10.0, *) {
            if let type = self as? UIContentSizeCategoryAdjusting {
                coordinator.appendDynamic(keyPathToName: [
                    ["adjustsFontForContentSizeCategory": "Dynamic Type"]
                ], forModel: self, in: .typography)
            }
        }
        
        super.preparePeek(with: coordinator)
    }
    
}

@objc internal final class Constraints: NSObject, PeekInspectorNestable {
    
    internal weak var view: UIView?
    
    internal init(view: UIView) {
        self.view = view
    }
    
    override func preparePeek(with coordinator: Coordinator) {
        guard let view = view else { return }
        
        coordinator.appendDynamic(keyPaths: ["hasAmbiguousLayout"], forModel: view, in: .constraints)
        
        coordinator.appendDynamic(keyPathToName: [
            ["horizontalContentHuggingPriority": "Horizontal"],
            ["verticalContentHuggingPriority": "Vertical"],
        ], forModel: view, in: .hugging)
        
        coordinator.appendDynamic(keyPathToName: [
            ["horizontalContentCompressionResistance": "Horizontal"],
            ["verticalContentCompressionResistance": "Vertical"]
        ], forModel: view, in: .resistance)
        
        for constraint in view.horizontalConstraints {
            coordinator.appendStatic(keyPath: "horizontalConstraints", title: "\(constraint)", detail: "", value: constraint, in: .horizontal)
        }
        
        for constraint in view.verticalConstraints {
            coordinator.appendStatic(keyPath: "verticalConstraints", title: "\(constraint)", detail: "", value: constraint, in: .vertical)
        }
        
        super.preparePeek(with: coordinator)
    }
    
}
