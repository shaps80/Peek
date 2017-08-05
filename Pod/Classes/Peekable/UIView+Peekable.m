//
//  UIView+Peekable.m
//  Peek
//
//  Created by Shahpour Benkau on 05/08/2017.
//

#import "NSObject+Peekable.h"
#import <Peek/Peek-Swift.h>

@interface UIView (PeekableComformance) <Peekable> @end

@implementation UIView (Peekable)

- (void)preparePeek:(id<Context>)context
{
    [[self superclass] preparePeek:context];
    
    [context configureWithInspector:InspectorLayer category:@"General" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperties:@[ @"frame", @"bounds", @"center", @"intrinsicContentSize", @"alignmentRectInsets" ]];
        [config addProperty:@"translatesAutoresizingMaskIntoConstraints" displayName:@"Autoresizing to Constraints" cellConfiguration:nil];
    }];
    
    [context configureWithInspector:InspectorLayout category:@"Content Hugging Priority" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperty:@"horizontalContentHuggingPriority" displayName:@"Horizontal" cellConfiguration:nil];
        [config addProperty:@"verticalContentHuggingPriority" displayName:@"Vertical" cellConfiguration:nil];
    }];
    
    [context configureWithInspector:InspectorLayout category:@"Content Compression Resistance" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperty:@"horizontalContentCompressionResistance" displayName:@"Horizontal" cellConfiguration:nil];
        [config addProperty:@"verticalContentCompressionResistance" displayName:@"Vertical" cellConfiguration:nil];
    }];
    
    [context configureWithInspector:InspectorLayout category:@"Constraints" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperty:@"horizontalConstraints" displayName:@"Horizontal" cellConfiguration:nil];
        [config addProperty:@"verticalConstraints" displayName:@"Vertical" cellConfiguration:nil];
    }];
    
    [context configureWithInspector:InspectorLayer category:@"Apperance" configuration:^(id<Configuration> _Nonnull config) {
        [config addProperty:@"contentMode" displayName:nil cellConfiguration:^(UITableViewCell * _Nonnull cell, id _Nonnull view, id mode) {
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@", mode];
        }];
    }];
}

@end
