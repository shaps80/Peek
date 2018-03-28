//
//  PeekAccessoryProviding.swift
//  Peek
//
//  Created by Shaps Benkau on 28/03/2018.
//

import Foundation

public protocol PeekAccessoryProviding {
    var theme: PeekTheme { get set }
    var intrinsicContentSize: CGSize { get }
}
