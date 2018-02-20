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

import UIKit

final class ImageCache {
    
    fileprivate static var _sharedCache: ImageCache = {
        return ImageCache()
    }()
    
    static func sharedCache() -> ImageCache {
        return ImageCache._sharedCache
    }
    
    fileprivate func pathForWeek(_ week: Week) -> String {
        let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        return docs.appendingPathComponent(week.number.description + ".jpg")
    }
    
    fileprivate var cache = NSCache<NSNumber, UIImage>()
    
    func removeImage(_ week: Week) {
        cache.removeObject(forKey: NSNumber(value: week.number))
        try! FileManager.default.removeItem(atPath: pathForWeek(week))
    }
    
    func addImage(_ image: UIImage, week: Week) {
        if imageExists(week) {
            removeImage(week)
        }
        
        let width: CGFloat = 375
        let ratio = width / image.size.width
        
        let scaledImage = image.resizedImage(CGSize(width: width, height: ratio * image.size.height))
        let data = UIImageJPEGRepresentation(scaledImage, 1)
        let path = pathForWeek(week)
        
        try? data?.write(to: URL(fileURLWithPath: path), options: [.atomic])
        cache.setObject(scaledImage, forKey: NSNumber(value: week.number))
    }
    
    func imageExists(_ week: Week) -> Bool {
        let path = pathForWeek(week)
        return FileManager.default.fileExists(atPath: path)
    }
    
    func image(_ week: Week, completion: @escaping (UIImage?) -> ()) {
        if !imageExists(week) {
            completion(nil)
            return
        }
        
        if let image = self.cache.object(forKey: NSNumber(value: week.number)) {
            completion(image)
            return
        }
        
        DispatchQueue.global(qos: .background).async { () -> Void in
            guard let image = UIImage(contentsOfFile: self.pathForWeek(week)) else {
                print("ImageCache: Image not found for week: \(week)")
                completion(nil)
                return
            }
            
            if let decompressedImage = image.decompressedImage() {
                self.addImage(decompressedImage, week: week)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completion(decompressedImage)
                })
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completion(decompressedImage)
                })
            }
        }
    }
    
}

extension UIImage {
    
    func decompressedImage(scale: CGFloat = 0) -> UIImage? {
        guard let imageRef = self.cgImage else { return nil }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue).rawValue
        let contextHolder: UnsafeMutableRawPointer? = nil
        let context = CGContext(data: contextHolder, width: imageRef.width, height: imageRef.height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo)
        if let context = context {
            let rect = CGRect(x: 0, y: 0, width: imageRef.width, height: imageRef.height)
            context.draw(imageRef, in: rect)
            let decompressedImageRef = context.makeImage()
            return UIImage(cgImage: decompressedImageRef!, scale: scale, orientation: self.imageOrientation)
        } else {
            return nil
        }
    }
    
    func resizedImage(_ size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            print("Returning the original image because the current graphics context was invalid!")
            return self
        }
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
