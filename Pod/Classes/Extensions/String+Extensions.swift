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

import Foundation

extension String {
    
    // Converts a camel case string to a capitalized one -- e.g. 'firstName' -> 'First Name'
    static func capitalized(_ camelCase: String) -> String {
        let chars = CharacterSet.uppercaseLetters
        var string = camelCase.components(separatedBy: ".").last ?? camelCase
        let peekPrefix = "peek_"
        let supportPrefix = "supports"
        
        if string.contains(peekPrefix) {
            string = String(string.dropFirst(peekPrefix.count))
        }
        
        if string.contains(supportPrefix) {
            string = String(string.dropFirst(supportPrefix.count))
        }
        
        while let range = string.rangeOfCharacter(from: chars) {
            let char = string[range]
            string.replaceSubrange(range, with: " " + char.lowercased())
        }
        
        return string.capitalized.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
}
