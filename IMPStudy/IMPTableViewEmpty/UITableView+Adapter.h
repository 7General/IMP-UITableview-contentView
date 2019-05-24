//
//  UIScrollView+Adapter.h
//  IMPStudy
//
//  Created by 王会洲 on 16/12/12.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmptyDataSource;

@protocol EmptyDataSource <NSObject>
@optional
/**返回一个空的占位UIView*/
- (UIView *)responsWithUITableView:(UITableView *)tableview;
@end


@interface UITableView (Adapter)

@property (nonatomic, weak) id<EmptyDataSource>  EmptyDataSource;

- (void)swizzleIfPossible:(SEL)selector;

@end
