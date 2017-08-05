//
//  NSObject+Peekable.m
//  Peek
//
//  Created by Shahpour Benkau on 05/08/2017.
//

#import "NSObject+Peekable.h"
#import <Peek/Peek-Swift.h>

//#define invokeSuper(context) ([self getImplementationOf:_cmd after:impOfCallingMethod(self, _cmd)]) (self, _cmd, context)

@interface NSObject (PeekableComformance) <Peekable> @end

@implementation NSObject (Peekable)

- (void)preparePeek:(id<Context>)context { }

//- (void)prepareSuper:(id)context
//{
//    IMP superSequentImp = [self getImplementationOf:_cmd after:impOfCallingMethod(self, _cmd)];
//    ((void(*)(id, SEL, id))superSequentImp)(self, _cmd, context);
//}

// Lookup the next implementation of the given selector after the
// default one. Returns nil if no alternate implementation is found.
- (IMP)getImplementationOf:(SEL)lookup after:(IMP)skip
{
    BOOL found = NO;
    
    Class currentClass = object_getClass(self);
    while (currentClass)
    {
        // Get the list of methods for this class
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        
        // Iterate over all methods
        unsigned int i;
        for (i = 0; i < methodCount; i++)
        {
            // Look for the selector
            if (method_getName(methodList[i]) != lookup)
            {
                continue;
            }
            
            IMP implementation = method_getImplementation(methodList[i]);
            
            // Check if this is the "skip" implementation
            if (implementation == skip)
            {
                found = YES;
            }
            else if (found)
            {
                // Return the match.
                free(methodList);
                return implementation;
            }
        }
        
        // No match found. Traverse up through super class' methods.
        free(methodList);
        
        currentClass = class_getSuperclass(currentClass);
    }
    
    return nil;
}

@end
