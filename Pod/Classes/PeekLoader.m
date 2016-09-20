//
//  PeekLoader.m
//  Peek
//
//  Created by Shaps Benkau on 20/09/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

#import "PeekLoader.h"
#import <objc/runtime.h>

@interface PeekLoader ()
+ (instancetype)shared;
@property (nonatomic, strong) Peek *peek;
@end

static IMP __peek_original_Method_Imp = NULL;
void _peek_motionBegan_Imp(id self, SEL _cmd, UIEventSubtype type, UIEvent* event)
{
  if (__peek_original_Method_Imp == NULL) {
    [[[PeekLoader shared] peek] handleShake:type];
  } else {
    ((void(*)(id,SEL, UIEventSubtype, UIEvent*))__peek_original_Method_Imp)(self, _cmd, type, event);
  }
}

@implementation PeekLoader

+ (void)load
{
  [[NSNotificationCenter defaultCenter]
   addObserver:[PeekLoader shared]
   selector:@selector(peek_applicationDidFinishLaunching)
   name:UIApplicationDidFinishLaunchingNotification
   object:nil];
}

+ (instancetype)shared
{
  static PeekLoader *_sharedInstance = nil;
  static dispatch_once_t oncePredicate;
  dispatch_once(&oncePredicate, ^{
    _sharedInstance = [[self alloc] init];
  });
  
  return _sharedInstance;
}

- (void)peek_applicationDidFinishLaunching
{
  UIApplication *application = [UIApplication sharedApplication];
  NSObject <UIApplicationDelegate> *delegate = application.delegate;
  
  self.peek = application.keyWindow.peek;
  self.peek.enabled = true;
  NSLog(@"Peek Enabled.");
  
  SEL selector = @selector(motionBegan:withEvent:);
  
  Method m = class_getInstanceMethod([application.delegate class], @selector(motionBegan:withEvent:));
  
  if ([delegate methodForSelector:selector] != [[delegate superclass] instanceMethodForSelector:selector]) {
    __peek_original_Method_Imp = method_setImplementation(m, (IMP)_peek_motionBegan_Imp);
  } else {
    method_setImplementation(m, (IMP)_peek_motionBegan_Imp);
  }
}

@end
