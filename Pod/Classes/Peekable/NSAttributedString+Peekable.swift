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
    
    string.enumerateAttributes(in: NSMakeRange(0, string.length), options: [], using: { (attr, range, false) in
      attributes = attr
    })
    
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
  
  override public func preparePeek(_ context: Context) {
    super.preparePeek(context)
    
    context.configure(.attributes, "General") { (config) in
      config.addProperties([ "attributes.fontName", "attributes.foregroundColor", "attributes.backgroundColor", "attributes.ligature", "attributes.kerning", "attributes.strokeColor", "attributes.strokeWidth" ])
    }
    
    context.configure(.attributes, "Shadow") { (config) in
      config.addProperties([ "attributes.shadow.shadowOffset", "attributes.shadow.shadowColor", "attributes.shadow.shadowBlurRadius" ])
    }
    
    if self.paragraph != nil {
      context.configure(.attributes, "Paragraph") { (config) in
        config.addProperties([ "paragraph.lineSpacing", "paragraph.headIndent", "paragraph.tailIndent", "paragraph.minimumLineHeight", "paragraph.maximumLineHeight", "paragraph.lineHeightMultiple", "paragraph.hyphenationFactor", "paragraph.spacingBefore", "paragraph.spacingAfter", "paragraph.firstLineHeadIndent" ])

        config.addProperty("paragraph.lineBreakMode", displayName: nil, cellConfiguration: { (cell, object, value) in
          cell.detailTextLabel?.text = NSLineBreakMode(rawValue: value as! Int)?.description
        })
      }
    }
  }
  
}
