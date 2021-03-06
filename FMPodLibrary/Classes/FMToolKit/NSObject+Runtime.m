//
//  NSObject+Runtime.m
//
//  Created by jack zhou on 7/19/13.
//  Copyright (c) 2013 JZ. No rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (BOOL)addInstanceMethodWithSelectorName:(NSString *)selectorName block:(void(^)(id))block
{
    // don't accept nil name
    NSParameterAssert(selectorName);
    
    // don't accept NULL block
    NSParameterAssert(block);
    
    // See http://stackoverflow.com/questions/6357663/casting-a-block-to-a-void-for-dynamic-class-method-resolution
    
#if MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_7
    void *impBlockForIMP = (void *)objc_unretainedPointer(block);
#else
    id impBlockForIMP = (__bridge id)objc_unretainedPointer(block);
#endif
    
    IMP myIMP = imp_implementationWithBlock(impBlockForIMP);
    
    SEL selector = NSSelectorFromString(selectorName);
    return class_addMethod(self, selector, myIMP, "v@:");
}


#pragma mark - Method Swizzling

+ (void)swizzleMethod:(SEL)selector withMethod:(SEL)otherSelector
{
	// my own class is being targetted
	Class c = [self class];
    
	// get the methods from the selectors
	Method originalMethod = class_getInstanceMethod(c, selector);
    Method otherMethod = class_getInstanceMethod(c, otherSelector);
    
    if (class_addMethod(c, selector, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod)))
	{
		class_replaceMethod(c, otherSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
	}
	else
	{
		method_exchangeImplementations(originalMethod, otherMethod);
	}
}

+ (void)swizzleClassMethod:(SEL)selector withMethod:(SEL)otherSelector
{
	// my own class is being targetted
	Class c = [self class];
    
	// get the methods from the selectors
	Method originalMethod = class_getClassMethod(c, selector);
    Method otherMethod = class_getClassMethod(c, otherSelector);
    
    method_exchangeImplementations(originalMethod, otherMethod);
}

@end
