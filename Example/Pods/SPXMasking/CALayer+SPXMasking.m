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

#import "CALayer+SPXMasking.h"
#import <objc/runtime.h>

static void * SPXCornerRadiiKey = &SPXCornerRadiiKey;

SPXCornerRadii SPXCornerRadiiMake(CGFloat bottomLeft, CGFloat topLeft, CGFloat topRight, CGFloat bottomRight)
{
  SPXCornerRadii cornerRadii = { bottomLeft, topLeft, topRight, bottomRight };
  return cornerRadii;
}

bool SPXCornerRadiiEquals(SPXCornerRadii radii1, SPXCornerRadii radii2)
{
  return (radii1.topLeft == radii2.topLeft &&
          radii1.topRight == radii2.topRight &&
          radii1.bottomLeft == radii2.bottomLeft &&
          radii1.bottomRight == radii2.bottomRight
          );
}

@implementation CALayer (SPXMasking)

- (UIBezierPath *)maskPath
{
  CAShapeLayer *maskLayer = (CAShapeLayer *)self.mask;
  return [UIBezierPath bezierPathWithCGPath:maskLayer.path];
}

- (SPXCornerRadii)cornerRadii
{
  NSValue *value = objc_getAssociatedObject(self, SPXCornerRadiiKey);
  UIEdgeInsets insets = [value UIEdgeInsetsValue];
  SPXCornerRadii radii = SPXCornerRadiiMake(insets.top, insets.left, insets.bottom, insets.right);
  return radii;
}

- (void)setCornerRadii:(SPXCornerRadii)radii
{
  if (SPXCornerRadiiEquals(radii, self.cornerRadii)) {
    return;
  }
  
  UIEdgeInsets insets = UIEdgeInsetsMake(radii.bottomLeft, radii.topLeft, radii.topRight, radii.bottomRight);
  NSValue *value = [NSValue valueWithUIEdgeInsets:insets];
  objc_setAssociatedObject(self, SPXCornerRadiiKey, value, OBJC_ASSOCIATION_ASSIGN);
  [self updateMaskPathWithRadii:radii];
}

- (void)updateMaskPathWithRadii:(SPXCornerRadii)radii
{
  CGFloat bottomLeft = fabsf(radii.bottomLeft), topLeft = fabsf(radii.topLeft), topRight = fabsf(radii.topRight), bottomRight = fabsf(radii.bottomRight);
  UIBezierPath *path = [UIBezierPath bezierPath];
  CGRect rect = self.bounds;
  
  [path moveToPoint:CGPointMake(CGRectGetMinX(rect) + bottomLeft, CGRectGetMaxY(rect) - bottomLeft)];
  {
    if (bottomLeft) {
      [path addArcWithCenter:CGPointMake(CGRectGetMinX(rect) + bottomLeft, CGRectGetMaxY(rect) - bottomLeft)
                      radius:bottomLeft
                  startAngle:90 * M_PI / 180
                    endAngle:180 * M_PI / 180
                   clockwise:YES];
    }
    
    [path addLineToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect))];
    if (topLeft) {
      [path addArcWithCenter:CGPointMake(CGRectGetMinX(rect) + topLeft, CGRectGetMinY(rect) + topLeft)
                      radius:topLeft
                  startAngle:180 * M_PI / 180
                    endAngle:270 * M_PI / 180
                   clockwise:YES];
    }
    
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect))];
    if (topRight) {
      [path addArcWithCenter:CGPointMake(CGRectGetMaxX(rect) - topRight, CGRectGetMinY(rect) + topRight)
                      radius:topRight
                  startAngle:270 * M_PI / 180
                    endAngle:0 * M_PI / 180
                   clockwise:YES];
    }
    
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
    if (bottomRight) {
      [path addArcWithCenter:CGPointMake(CGRectGetMaxX(rect) - bottomRight, CGRectGetMaxY(rect) - bottomRight)
                      radius:bottomRight
                  startAngle:0 * M_PI / 180
                    endAngle:90 * M_PI / 180
                   clockwise:YES];
    }
  }
  [path addLineToPoint:CGPointMake(CGRectGetMinX(rect) + bottomLeft, CGRectGetMaxY(rect))];
  [path closePath];
  
  CAShapeLayer *maskLayer = [CAShapeLayer layer];
  maskLayer.path = path.CGPath;  
  self.mask = maskLayer;
}

@end
