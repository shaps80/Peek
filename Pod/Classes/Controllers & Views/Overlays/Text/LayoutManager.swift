//
//  LayoutManager.swift
//  Peek
//
//  Created by Shaps Benkau on 13/03/2018.
//

import Foundation
import CoreText

final class LayoutManager: NSLayoutManager {
    
    override func drawBackground(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        super.drawBackground(forGlyphRange: glyphsToShow, at:origin)
        
        guard let text = textStorage?.string else { return }
        
        enumerateLineFragments(forGlyphRange: glyphsToShow)
        { (rect: CGRect, usedRect: CGRect, textContainer: NSTextContainer, glyphRange: NSRange, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            
            let characterRange = self.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
            
            // Draw invisible tab space characters
            
            let line = (text as NSString).substring(with: characterRange)
            
            do {
                let expr = try NSRegularExpression(pattern: "\t", options: [])
                
                expr.enumerateMatches(in: line, options: .reportProgress, range: characterRange)
                { result, flags, stop in
                    if let result = result {
                        
                        let range = NSMakeRange(result.range.location + characterRange.location, result.range.length)
                        let characterRect = self.boundingRect(forGlyphRange: range, in: textContainer)
                        
                        let symbol = "\u{21E5}"
                        let attrs = [NSAttributedStringKey.foregroundColor : UIColor.red ]
                        let height = (symbol as NSString).size(withAttributes: attrs).height
                        let rect = characterRect.offsetBy(dx: 1, dy: height * 0.5)
                        symbol.draw(in: rect, withAttributes: attrs)
                    }
                    
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
    }
    
}
