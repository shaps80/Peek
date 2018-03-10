//
//  NSAttributedString+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 02/05/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

final class ParagraphStyle: NSObject {
    
    @objc let lineSpacing: CGFloat
    @objc let spacingBefore: CGFloat
    @objc let spacingAfter: CGFloat
    @objc let alignment: NSTextAlignment
    @objc let headIndent: CGFloat
    @objc let tailIndent: CGFloat
    @objc let firstLineHeadIndent: CGFloat
    @objc let minimumLineHeight: CGFloat
    @objc let maximumLineHeight: CGFloat
    @objc let lineBreakMode: NSLineBreakMode
    @objc let lineHeightMultiple: CGFloat
    @objc let hyphenationFactor: Float
    
    init(paragraphStyle: NSParagraphStyle) {
        self.lineSpacing = paragraphStyle.lineSpacing
        self.spacingBefore = paragraphStyle.paragraphSpacingBefore
        self.spacingAfter = paragraphStyle.paragraphSpacing
        self.alignment = paragraphStyle.alignment
        self.headIndent = paragraphStyle.headIndent
        self.tailIndent = paragraphStyle.tailIndent
        self.firstLineHeadIndent = paragraphStyle.firstLineHeadIndent
        self.minimumLineHeight = paragraphStyle.minimumLineHeight
        self.maximumLineHeight = paragraphStyle.maximumLineHeight
        self.lineBreakMode = paragraphStyle.lineBreakMode
        self.lineHeightMultiple = paragraphStyle.lineHeightMultiple
        self.hyphenationFactor = paragraphStyle.hyphenationFactor
    }
    
}

final class TextAttributes: NSObject {
    
    @objc let fontName: String?
    @objc let foregroundColor: UIColor?
    @objc let backgroundColor: UIColor?
    @objc fileprivate(set) var ligature: Int = 1
    @objc fileprivate(set) var kerning: CGFloat = 0
    @objc let strokeColor: UIColor?
    @objc fileprivate(set) var strokeWidth: CGFloat = 0
    @objc let shadow: NSShadow?
    @objc let paragraphStyle: ParagraphStyle?
    
    init(string: NSAttributedString) {
        var attributes = [NSAttributedStringKey: Any]()
        
        string.enumerateAttributes(in: NSRange.init(location: 0, length: string.length), options: []) { attr, _, _ in
            attributes = attr
        }
        
        fontName = attributes[.font] as? String
        foregroundColor = attributes[.foregroundColor] as? UIColor
        backgroundColor = attributes[.backgroundColor] as? UIColor
        ligature = attributes[.ligature] as? Int ?? 1
        kerning = attributes[.kern] as? CGFloat ?? 0
        strokeColor = attributes[.strokeColor] as? UIColor
        strokeWidth = attributes[.strokeWidth] as? CGFloat ?? 0
        shadow = attributes[.shadow] as? NSShadow
        
        if let style = attributes[.paragraphStyle] as? NSParagraphStyle {
            paragraphStyle = ParagraphStyle(paragraphStyle: style)
        } else {
            paragraphStyle = nil
        }
        
        super.init()
    }
    
}

extension NSAttributedString {
    
    @objc var attributes: TextAttributes {
        return TextAttributes(string: self)
    }
    
    @objc var paragraph: ParagraphStyle? {
        return attributes.paragraphStyle
    }
    
    open override func preparePeek(with coordinator: Coordinator) {
//        coordinator.appendPreview(image: string.peek_preview, forModel: self)
        
        coordinator.appendDynamic(keyPaths: [
            "attributes.fontName",
            "attributes.foregroundColor",
            "attributes.backgroundColor",
            "attributes.ligature",
            "attributes.kerning",
            "attributes.strokeColor",
            "attributes.strokeWidth"
        ], forModel: self, in: .general)
        
        coordinator.appendDynamic(keyPaths: [
            "paragraph.lineSpacing",
            "paragraph.headIndent",
            "paragraph.tailIndent",
            "paragraph.minimumLineHeight",
            "paragraph.maximumLineHeight",
            "paragraph.lineHeightMultiple",
            "paragraph.hyphenationFactor",
            "paragraph.spacingBefore",
            "paragraph.spacingAfter",
            "paragraph.firstLineHeadIndent"
        ], forModel: self, in: .paragraph)
        
        coordinator.appendTransformed(keyPaths: ["paragraph.lineBreakMode"], valueTransformer: { value in
            guard let rawValue = value as? Int, let lineBreakMode = NSLineBreakMode(rawValue: rawValue) else { return nil }
            return lineBreakMode.description
        }, forModel: self, in: .paragraph)
        
        coordinator.appendDynamic(keyPaths: [
            "attributes.shadow.shadowOffset",
            "attributes.shadow.shadowColor",
            "attributes.shadow.shadowBlurRadius"
        ], forModel: self, in: .shadow)
        
        super.preparePeek(with: coordinator)
    }
    
}
