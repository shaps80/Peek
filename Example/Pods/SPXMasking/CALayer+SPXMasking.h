/*
   Copyright (c) 2014 Snippex. All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY Snippex `AS IS' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL Snippex OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <QuartzCore/QuartzCore.h>

typedef struct SPXCornerRadii {
  CGFloat bottomLeft, topLeft, topRight, bottomRight;
} SPXCornerRadii;

extern SPXCornerRadii SPXCornerRadiiMake(CGFloat bottomLeft, CGFloat topLeft, CGFloat topRight, CGFloat bottomRight);
extern bool SPXCornerRadiiEquals(SPXCornerRadii radii1, SPXCornerRadii radii2);

/**
 *  Adds support for different corner radii on a layer
 */
@interface CALayer (SPXMasking)

/**
 *  Sets/gets the corner radii for the layer
 */
@property (nonatomic, assign) SPXCornerRadii cornerRadii;

/**
 *  Returns the current path applied to mask for this layer
 *
 *  @return A UIBezier path if a mask is applied, nil otherwise
 */
- (UIBezierPath *)maskPath;

@end
