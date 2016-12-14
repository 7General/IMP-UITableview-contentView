//
//  UIScrollView+Adapter.m
//  IMPStudy
//
//  Created by 王会洲 on 16/12/12.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "UIScrollView+Adapter.h"
#import <objc/runtime.h>

static const void * dataSource = &dataSource;

@implementation UIScrollView (Adapter)
@dynamic EmptyDataSource;

-(id<EmptyDataSource>)EmptyDataSource {
    return objc_getAssociatedObject(self, &dataSource);
}

-(void)setEmptyDataSource:(id<EmptyDataSource>)EmptyDataSource {
    objc_setAssociatedObject(self, &dataSource,EmptyDataSource,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self swizzleIfPossible:@selector(reloadData)];
    if ([self isKindOfClass:[UITableView class]]) {
        //        [self swizzleIfPossible:@selector(endUpdates)];
    }
}
//-(void)reloadData {
//    NSLog(@"----------reloadData");
//}

-(void)swizzleIfPossible:(SEL)selector {
    NSLog(@"----------");
    
    
    Class class = dzn_baseClassToSwizzleForTarget(self);
//
//    Method ori_Method =  class_getInstanceMethod(class, @selector(reloadData));
//    Method my_Method = class_getInstanceMethod(class, @selector(myReloadData));
//    //        method_exchangeImplementations(ori_Method, my_Method);
//
//    BOOL didAddMethod = class_addMethod(class,@selector(reloadData), method_getImplementation(my_Method),method_getTypeEncoding(my_Method));
//    if (!didAddMethod) {
//        method_setImplementation(ori_Method, method_getImplementation(my_Method));
//    }
    Method my_Method = class_getInstanceMethod(class, @selector(myReloadData));
    IMP newIMP = method_getImplementation(my_Method);
    [self swizzleSelector:selector withIMP:newIMP];
    
}

-(void)myReloadData {
    NSLog(@"-------myReloadData");
    [self myReloadData];
    NSInteger items = 0;
    
    UITableView *tableView = (UITableView *)self;
    id <UITableViewDataSource> dataSource = tableView.dataSource;
    
    if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        items = [dataSource tableView:tableView numberOfRowsInSection:0];
    }
    NSLog(@"----------%ld",items);
    
}



Class dzn_baseClassToSwizzleForTarget(id target)
{
    if ([target isKindOfClass:[UITableView class]]) {
        return [UITableView class];
    }
    else if ([target isKindOfClass:[UICollectionView class]]) {
        return [UICollectionView class];
    }
    else if ([target isKindOfClass:[UIScrollView class]]) {
        return [UIScrollView class];
    }
    
    return nil;
}


- (IMP)swizzleSelector:(SEL)origSelector
               withIMP:(IMP)newIMP {
    Class class = dzn_baseClassToSwizzleForTarget(self);
    
    Method origMethod = class_getInstanceMethod(class,
                                                origSelector);
    IMP origIMP = method_getImplementation(origMethod);
    
    if(!class_addMethod(class, origSelector, newIMP,
                        method_getTypeEncoding(origMethod)))
    {
        method_setImplementation(origMethod, newIMP);
    }
    
    return origIMP;
}

@end
