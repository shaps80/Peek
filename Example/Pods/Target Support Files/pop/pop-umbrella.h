#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "POP.h"
#import "POPAnimatableProperty.h"
#import "POPAnimation.h"
#import "POPAnimationEvent.h"
#import "POPAnimationExtras.h"
#import "POPAnimationTracer.h"
#import "POPAnimator.h"
#import "POPBasicAnimation.h"
#import "POPCustomAnimation.h"
#import "POPDecayAnimation.h"
#import "POPDefines.h"
#import "POPGeometry.h"
#import "POPLayerExtras.h"
#import "POPPropertyAnimation.h"
#import "POPSpringAnimation.h"

FOUNDATION_EXPORT double popVersionNumber;
FOUNDATION_EXPORT const unsigned char popVersionString[];

