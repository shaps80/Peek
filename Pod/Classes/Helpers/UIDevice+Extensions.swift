//
//  UIDevice+Extensions.swift
//  Peek
//
//  Created by Shaps Benkau on 26/03/2018.
//

import Foundation

extension UIDevice {
    
    internal var isSimulator: Bool {
        var isSimulator = false
        #if (arch(i386) || arch(x86_64))
            isSimulator = true
        #endif
        return isSimulator
    }
    
}
