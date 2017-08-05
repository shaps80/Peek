//
//  CALayer+Peekable.m
//  Peek
//
//  Created by Shahpour Benkau on 05/08/2017.
//

#import "NSObject+Peekable.h"
#import <QuartzCore/QuartzCore.h>
#import <Peek/Peek-Swift.h>

@interface CALayer (PeekableComformance) <Peekable> @end

@implementation CALayer (Peekable)

- (void)preparePeek:(id<Context>)context
{
    [[self superclass] preparePeek:context];
    
    [context configureWithInspector:InspectorLayer category:@"Appearance" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperty:@"layer.peek_backgroundColor" displayName:@"Background Color" cellConfiguration:nil];
        [config addProperties:@[ @"layer.cornerRadius", @"layer.masksToBounds", @"layer.doubleSided" ]];
    }];
    
    [context configureWithInspector:InspectorLayer category:@"Visibility" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperties:@[ @"layer.opacity", @"layer.allowsGroupOpacity", @"layer.hidden" ]];
    }];
    
    [context configureWithInspector:InspectorLayer category:@"Rasterization" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperties:@[ @"layer.shouldRasterize", @"layer.rasterizationScale", @"opaque" ]];
    }];
    
    [context configureWithInspector:InspectorLayer category:@"Shadow" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperty:@"layer.peek_shadowColor" displayName:@"Shadow Color" cellConfiguration:nil];
        [config addProperties:@[ @"layer.shadowOffset", @"layer.shadowOpacity", @"layer.shadowRadius" ]];
    }];
    
    [context configureWithInspector:InspectorLayer category:@"Border" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperty:@"layer.peek_borderColor" displayName:@"Border Color" cellConfiguration:nil];
        [config addProperties:@[ @"layer.borderWidth" ]];
    }];
    
    [context configureWithInspector:InspectorLayer category:@"Contents" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperties:@[ @"layer.contentsRect", @"layer.contentsScale", @"layer.contentsCenter" ]];
        [config addProperty:@"layer.contentsGravity" displayName:nil cellConfiguration:^(UITableViewCell * _Nonnull cell, id _Nonnull object, NSString * _Nonnull value) {
            cell.detailTextLabel.text = [value capitalizedString];
        }];
    }];
}

@end
