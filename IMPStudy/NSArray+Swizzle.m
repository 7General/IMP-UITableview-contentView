//
//  NSArray+Swizzle.m
//  IMPStudy
//
//  Created by 王会洲 on 16/12/13.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "NSArray+Swizzle.h"
#import <objc/runtime.h>

@implementation NSArray (Swizzle)

- (id)mylastObject
{
    id ret = [self mylastObject];
    NSLog(@"**********  myLastObject *********** ");
    return ret;
}


-(id)my_objectAtIndex:(NSUInteger)index {
    NSLog(@"--------------111111111-----------");
    if (index < self.count -1) {
        return [self my_objectAtIndex:index];
    }else {
        NSAssert((2 < 1), @"Argument must be not-nil");
        NSLog(@"------------32222222越界访问数组-------------");
        return nil;
    }
    
}


+ (IMP)swizzleSelector:(SEL)origSelector withIMP:(IMP)newIMP {
    Class class = [self class];
    Method origMethod = class_getInstanceMethod(class,
                                                origSelector);
    IMP origIMP = method_getImplementation(origMethod);
    
    if(!class_addMethod(self, origSelector, newIMP,
                        method_getTypeEncoding(origMethod)))
    {
        method_setImplementation(origMethod, newIMP);
    }
    
    return origIMP;
}

@end
