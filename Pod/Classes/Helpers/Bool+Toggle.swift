//
//  Bool+Toggle.swift
//  Peek
//
//  Created by Shaps Benkau on 04/05/2018.
//

import Foundation

extension Bool {

    /// Equivalent to `someBool = !someBool`
    ///
    /// Useful when operating on long chains:
    ///
    ///    myVar.prop1.prop2.enabled.toggle()
    mutating func toggle() {
        self = !self
    }

}
