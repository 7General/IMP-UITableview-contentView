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
-(void)gos;
@end


@interface UIScrollView (Adapter)

@property (nonatomic, weak) id<EmptyDataSource>  EmptyDataSource;

@end
