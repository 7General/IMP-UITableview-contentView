//
//  NSArray+Swizzle.h
//  IMPStudy
//
//  Created by 王会洲 on 16/12/13.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Swizzle)
- (id)mylastObject;
- (id)my_objectAtIndex:(NSUInteger)index;

+ (IMP)swizzleSelector:(SEL)origSelector withIMP:(IMP)newIMP;
@end
