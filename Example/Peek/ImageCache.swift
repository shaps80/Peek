//
//  ImageCache.swift
//  Yubl
//
//  Created by Shaps Mohsenin on 31/01/2016.
//  Copyright © 2016 Yubl. All rights reserved.
//

import UIKit

final class ImageCache {
  
  private static var _sharedCache: ImageCache = {
    return ImageCache()
  }()
  
  static func sharedCache() -> ImageCache {
    return ImageCache._sharedCache
  }
  
  private func pathForWeek(week: Week) -> String {
    let docs = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
    return docs.stringByAppendingPathComponent(week.number.description + ".jpg")
  }
  
  private var cache = NSCache()
  
  func removeImage(week: Week) {
    cache.removeObjectForKey(week.number)
    try! NSFileManager.defaultManager().removeItemAtPath(pathForWeek(week))
  }
  
  func addImage(image: UIImage, week: Week) {
    if imageExists(week) {
      removeImage(week)
    }
    
    let width: CGFloat = 375
    let ratio = width / image.size.width
    
    let scaledImage = image.resizedImage(CGSizeMake(width, ratio * image.size.height))
    let data = UIImageJPEGRepresentation(scaledImage, 1)
    let path = pathForWeek(week)
    
    data?.writeToFile(path, atomically: true)
    cache.setObject(scaledImage, forKey: week.number)
  }
  
  func imageExists(week: Week) -> Bool {
    let path = pathForWeek(week)
    return NSFileManager.defaultManager().fileExistsAtPath(path)
  }
  
  func image(week: Week, completion: (UIImage?) -> ()) {
    if !imageExists(week) {
      completion(nil)
      return
    }
    
    if let image = self.cache.objectForKey(week.number) as? UIImage {
      completion(image)
      return
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
      guard let image = UIImage(contentsOfFile: self.pathForWeek(week)) else {
        print("ImageCache: Image not found for week: \(week)")
        completion(nil)
        return
      }
      
      if let decompressedImage = image.decompressedImage() {
        self.addImage(decompressedImage, week: week)
 
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          completion(decompressedImage)
        })
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          completion(decompressedImage)
        })
      }
    }
  }
  
}

extension UIImage {
  
  func decompressedImage(scale scale: CGFloat = 0) -> UIImage? {
    let imageRef = self.CGImage
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue
    let contextHolder = UnsafeMutablePointer<Void>(nil)
    let context = CGBitmapContextCreate(contextHolder, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef), 8, 0, colorSpace, bitmapInfo)
    if let context = context {
      let rect = CGRect(x: 0, y: 0, width: CGImageGetWidth(imageRef), height: CGImageGetHeight(imageRef))
      CGContextDrawImage(context, rect, imageRef)
      let decompressedImageRef = CGBitmapContextCreateImage(context)
      return UIImage(CGImage: decompressedImageRef!, scale: scale, orientation: self.imageOrientation)
    } else {
      return nil
    }
  }
  
  func resizedImage(size: CGSize) -> UIImage {
    let hasAlpha = false
    let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
    
    UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
    drawInRect(CGRect(origin: CGPointZero, size: size))
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
  
}
