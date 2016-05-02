//
//  NSAttributedString+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 02/05/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

final class ParagraphStyle: NSObject {
  
  let lineSpacing: CGFloat
  let spacingBefore: CGFloat
  let spacingAfter: CGFloat
  let alignment: NSTextAlignment
  let headIndent: CGFloat
  let tailIndent: CGFloat
  let firstLineHeadIndent: CGFloat
  let minimumLineHeight: CGFloat
  let maximumLineHeight: CGFloat
  let lineBreakMode: NSLineBreakMode
  let lineHeightMultiple: CGFloat
  let hyphenationFactor: Float
  
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
  
  let fontName: String?
  let foregroundColor: UIColor?
  let backgroundColor: UIColor?
  private(set) var ligature: Int = 1
  private(set) var kerning: CGFloat = 0
  let strokeColor: UIColor?
  private(set) var strokeWidth: CGFloat = 0
  let shadow: NSShadow?
  let paragraphStyle: ParagraphStyle?
  
  init(string: NSAttributedString) {
    var attributes = [String: AnyObject]()
    
    string.enumerateAttributesInRange(NSMakeRange(0, string.length), options: [], usingBlock: { (attr, range, false) in
      attributes = attr
    })
    
    fontName = attributes[NSFontAttributeName] as? String
    foregroundColor = attributes[NSForegroundColorAttributeName] as? UIColor
    backgroundColor = attributes[NSBackgroundColorAttributeName] as? UIColor
    ligature = attributes[NSLigatureAttributeName] as? Int ?? 1
    kerning = attributes[NSKernAttributeName] as? CGFloat ?? 0
    strokeColor = attributes[NSStrokeColorAttributeName] as? UIColor
    strokeWidth = attributes[NSStrokeWidthAttributeName] as? CGFloat ?? 0
    shadow = attributes[NSShadowAttributeName] as? NSShadow
    
    if let style = attributes[NSParagraphStyleAttributeName] as? NSParagraphStyle {
      paragraphStyle = ParagraphStyle(paragraphStyle: style)
    } else {
      paragraphStyle = nil
    }
    
    super.init()
  }
  
}

extension NSAttributedString {
  
  var attributes: TextAttributes {
    return TextAttributes(string: self)
  }
  
  var paragraph: ParagraphStyle? {
    return attributes.paragraphStyle
  }
  
  override public func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "General") { (config) in
      config.addProperties([ "attributes.fontName", "attributes.foregroundColor", "attributes.backgroundColor", "attributes.ligature", "attributes.kerning", "attributes.strokeColor", "attributes.strokeWidth" ])
    }
    
    context.configure(.Attributes, "Shadow") { (config) in
      config.addProperties([ "attributes.shadow.shadowOffset", "attributes.shadow.shadowColor", "attributes.shadow.shadowBlurRadius" ])
    }
    
    if self.paragraph != nil {
      context.configure(.Attributes, "Paragraph") { (config) in
        config.addProperties([ "paragraph.lineSpacing", "paragraph.headIndent", "paragraph.tailIndent", "paragraph.minimumLineHeight", "paragraph.maximumLineHeight", "paragraph.lineHeightMultiple", "paragraph.hyphenationFactor", "paragraph.spacingBefore", "paragraph.spacingAfter", "paragraph.firstLineHeadIndent" ])

        config.addProperty("paragraph.lineBreakMode", displayName: nil, cellConfiguration: { (cell, object, value) in
          cell.detailTextLabel?.text = NSLineBreakMode(rawValue: value as! Int)?.description
        })
      }
    }
  }
  
}
