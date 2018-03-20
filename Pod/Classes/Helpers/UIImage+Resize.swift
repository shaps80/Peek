//
//  UIImage+Resize.swift
//  Peek
//
//  Created by Shaps Benkau on 20/03/2018.
//

import UIKit

extension UIImage {
    
    public func resized(to preferredSize: CGSize) -> UIImage {
        let newSize = size.scaledTo(size: preferredSize, scaleMode: .scaleAspectFit)
        UIGraphicsBeginImageContextWithOptions(newSize, true, UIScreen.main.scale)
        let rect = CGRect(origin: .zero, size: newSize)
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? self
    }
    
}
