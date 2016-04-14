//
// UIFont+OpenSans.h
//
// Created by Kyle Fuller on 18/02/2014
//

#import <UIKit/UIKit.h>

/// UIFont extension providing the Open Sans font
@interface UIFont (OpenSans)


/** Returns a font object for the Open Sans font which has the specified size instead.
 @param size The desired size (in points) of the new font object. This value must be greater than 0.0
 @return A font object of the specified size.
*/
+ (instancetype)openSansFontOfSize:(CGFloat)size;

/** Returns a font object for the Open Sans Italic font which has the specified size instead.
 @param size The desired size (in points) of the new font object. This value must be greater than 0.0
 @return A font object of the specified size.
*/
+ (instancetype)openSansItalicFontOfSize:(CGFloat)size;

/** Returns a font object for the Open Sans Light font which has the specified size instead.
 @param size The desired size (in points) of the new font object. This value must be greater than 0.0
 @return A font object of the specified size.
*/
+ (instancetype)openSansLightFontOfSize:(CGFloat)size;

/** Returns a font object for the Open Sans Light Italic font which has the specified size instead.
 @param size The desired size (in points) of the new font object. This value must be greater than 0.0
 @return A font object of the specified size.
*/
+ (instancetype)openSansLightItalicFontOfSize:(CGFloat)size;

/** Returns a font object for the Open Sans bold font which has the specified size instead.
 @param size The desired size (in points) of the new font object. This value must be greater than 0.0
 @return A font object of the specified size.
*/
+ (instancetype)openSansBoldFontOfSize:(CGFloat)size;

/** Returns a font object for the Open Sans Bold Italic font which has the specified size instead.
 @param size The desired size (in points) of the new font object. This value must be greater than 0.0
 @return A font object of the specified size.
*/
+ (instancetype)openSansBoldItalicFontOfSize:(CGFloat)size;

/** Returns a font object for the Open Sans Semi Bold font which has the specified size instead.
 @param size The desired size (in points) of the new font object. This value must be greater than 0.0
 @return A font object of the specified size.
*/
+ (instancetype)openSansSemiBoldFontOfSize:(CGFloat)size;

/** Returns a font object for the Open Sans Semi Bold Italic font which has the specified size instead.
 @param size The desired size (in points) of the new font object. This value must be greater than 0.0
 @return A font object of the specified size.
*/
+ (instancetype)openSansSemiBoldItalicFontOfSize:(CGFloat)size;

/** Returns a font object for the Open Sans Extra Bold font which has the specified size instead.
 @param size The desired size (in points) of the new font object. This value must be greater than 0.0
 @return A font object of the specified size.
*/
+ (instancetype)openSansExtraBoldFontOfSize:(CGFloat)size;

/** Returns a font object for the Open Sans Extra Bold Italic font which has the specified size instead.
 @param size The desired size (in points) of the new font object. This value must be greater than 0.0
 @return A font object of the specified size.
*/
+ (instancetype)openSansExtraBoldItalicFontOfSize:(CGFloat)size;

@end

