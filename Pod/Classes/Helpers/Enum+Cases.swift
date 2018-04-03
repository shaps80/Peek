//
//  Enum+Cases.swift
//  Peek
//
//  Created by Shaps Benkau on 26/02/2018.
//

import Foundation

extension RawRepresentable where RawValue == Int, Self: Hashable {
    
    private static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    internal static var all: [Self] {
        return Array(self.cases())
    }
}
