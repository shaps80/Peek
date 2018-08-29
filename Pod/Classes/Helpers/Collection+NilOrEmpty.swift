//
//  Collection+NilOrEmpty.swift
//  Peek
//
//  Created by Shaps Benkau on 04/05/2018.
//

import Foundation

internal extension Optional where Wrapped: Collection {

    /// Equivalent to `if let value = value, !value.isEmpty`
    ///
    /// Useful when you need to know whether or not an underlying value exists at all.
    ///
    ///     string.isNilOrEmpty
    ///
    /// Returns true if `string` is nil or empty. False otherwise
    var isNilOrEmpty: Bool {
        switch self {
        case .some(let wrapped): return wrapped.isEmpty
        case .none: return true
        }
    }

}
