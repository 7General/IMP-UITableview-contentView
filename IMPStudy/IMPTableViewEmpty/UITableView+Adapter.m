//
//  UIScrollView+Adapter.m
//  IMPStudy
//
//  Created by 王会洲 on 16/12/12.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#define ResponTag 30000


#import "UITableView+Adapter.h"
#import <objc/runtime.h>

static const void * dataSource = &dataSource;

@implementation UITableView (Adapter)
@dynamic EmptyDataSource;


/**
 +替换两个方法IMP

 @param method1 reloadata
 @param method2 customFunc
 */
+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}
+ (void)exchange {
    Method originalMethod = class_getInstanceMethod(self, @selector(reloadData));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(myReloadData));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

/**
 + 替换两个方法IMP

 @param origSel_ reloadata
 @param altSel_ customFun
 @param error_ error
 @return bool
 */
+ (BOOL)swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError * *)error_ {
    Method origMethod = class_getInstanceMethod(self, origSel_);
    if (! origMethod) {
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, altSel_);
    if (! altMethod) {
        return NO;
    }
    
    class_addMethod(self,
                    origSel_,
                    class_getMethodImplementation(self, origSel_),
                    method_getTypeEncoding(origMethod));
    
    class_addMethod(self,
                    altSel_,
                    class_getMethodImplementation(self, altSel_),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));
    return YES;
}


/**
 - 交换两个方法IMP

 @param selector 要替换的方法
 */
- (void)swizzleIfPossible:(SEL)selector {
    /**交换两个方法*/
    Method ori_Method =  class_getInstanceMethod([UITableView class], @selector(reloadData));
    Method my_Method = class_getInstanceMethod([UITableView class], @selector(myReloadData));
    method_exchangeImplementations(ori_Method, my_Method);
}


/**
 + 获取类的全部方法

 @param obj 类对象
 */
+ (void)LogAllMethodsFromClass:(id)obj {
    u_int count;
    //class_copyMethodList 获取类的所有方法列表
    Method *mothList_f = class_copyMethodList([obj class],&count) ;
    for (int i = 0; i < count; i++) {
        Method temp_f = mothList_f[i];
        // method_getImplementation  由Method得到IMP函数指针
        IMP imp_f = method_getImplementation(temp_f);// method_getName由Method得到SEL
        SEL name_f = method_getName(temp_f);
        
        const char * name_s = sel_getName(name_f);
        // method_getNumberOfArguments  由Method得到参数个数
        int arguments = method_getNumberOfArguments(temp_f);
        // method_getTypeEncoding  由Method得到Encoding 类型
        const char * encoding = method_getTypeEncoding(temp_f);
        
        NSLog(@"方法名：%@\n,参数个数：%d\n,编码方式：%@\n",[NSString stringWithUTF8String:name_s],
              arguments,[NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
    
}


+ (void)load {
    [self swizzleMethod:@selector(reloadData) withMethod:@selector(myReloadData) error:nil];
}


- (id<EmptyDataSource>)EmptyDataSource {
    return objc_getAssociatedObject(self, &dataSource);
}

- (void)setEmptyDataSource:(id<EmptyDataSource>)EmptyDataSource {
    objc_setAssociatedObject(self, &dataSource,EmptyDataSource,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)myReloadData {
    [self myReloadData];

    NSInteger items = 0;
    
    UITableView *tableView = (UITableView *)self;
    id <UITableViewDataSource> dataSource = tableView.dataSource;
    
    if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        items = [dataSource tableView:tableView numberOfRowsInSection:0];
    }
    
    if (0 == items) {
        if (self.EmptyDataSource && [self.EmptyDataSource respondsToSelector:@selector(responsWithUITableView:)]) {
            UIView * responView = [self.EmptyDataSource responsWithUITableView:self];
            responView.tag = ResponTag;
            responView.frame = self.frame;
            [self addSubview:responView];
        }
    } else {
        UIView * customView = [self viewWithTag:ResponTag];
        if (customView) {
            [customView removeFromSuperview];
        }
    }
    
}


@end
