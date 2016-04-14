//
// UIFont+OpenSans.m
//
// Created by Kyle Fuller on 18/02/2014
//

#import <CoreText/CoreText.h>
#import "UIFont+OpenSans.h"


@implementation UIFont (OpenSans)

void KOSLoadFontWithName(NSString *fontName) {
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"OpenSans" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    NSURL *fontURL = [bundle URLForResource:fontName withExtension:@"ttf"];
    NSData *fontData = [NSData dataWithContentsOfURL:fontURL];

    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);

    if (font) {
        CFErrorRef error = NULL;
        if (CTFontManagerRegisterGraphicsFont(font, &error) == NO) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:(__bridge NSString *)errorDescription userInfo:@{ NSUnderlyingErrorKey: (__bridge NSError *)error }];
        }

        CFRelease(font);
    }

    CFRelease(provider);
}

+ (instancetype)kosLoadAndReturnFont:(NSString *)fontName size:(CGFloat)fontSize onceToken:(dispatch_once_t *)onceToken fontFileName:(NSString *)fontFileName {
    dispatch_once(onceToken, ^{
        KOSLoadFontWithName(fontFileName);
    });

    return [self fontWithName:fontName size:fontSize];
}

+ (instancetype)openSansFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self kosLoadAndReturnFont:@"Open Sans" size:size onceToken:&onceToken fontFileName:@"OpenSans-Regular"];
}

+ (instancetype)openSansItalicFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self kosLoadAndReturnFont:@"OpenSans-Italic" size:size onceToken:&onceToken fontFileName:@"OpenSans-Italic"];
}

+ (instancetype)openSansLightFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self kosLoadAndReturnFont:@"OpenSans-Light" size:size onceToken:&onceToken fontFileName:@"OpenSans-Light"];
}

+ (instancetype)openSansLightItalicFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self kosLoadAndReturnFont:@"OpenSansLight-Italic" size:size onceToken:&onceToken fontFileName:@"OpenSans-LightItalic"];
}

+ (instancetype)openSansBoldFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self kosLoadAndReturnFont:@"OpenSans-Bold" size:size onceToken:&onceToken fontFileName:@"OpenSans-Bold"];
}

+ (instancetype)openSansBoldItalicFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self kosLoadAndReturnFont:@"OpenSans-BoldItalic" size:size onceToken:&onceToken fontFileName:@"OpenSans-BoldItalic"];
}

+ (instancetype)openSansSemiBoldFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self kosLoadAndReturnFont:@"OpenSans-Semibold" size:size onceToken:&onceToken fontFileName:@"OpenSans-Semibold"];
}

+ (instancetype)openSansSemiBoldItalicFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self kosLoadAndReturnFont:@"OpenSans-SemiboldItalic" size:size onceToken:&onceToken fontFileName:@"OpenSans-SemiboldItalic"];
}

+ (instancetype)openSansExtraBoldFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self kosLoadAndReturnFont:@"OpenSans-Extrabold" size:size onceToken:&onceToken fontFileName:@"OpenSans-ExtraBold"];
}

+ (instancetype)openSansExtraBoldItalicFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self kosLoadAndReturnFont:@"OpenSans-ExtraboldItalic" size:size onceToken:&onceToken fontFileName:@"OpenSans-ExtraBoldItalic"];
}

@end

