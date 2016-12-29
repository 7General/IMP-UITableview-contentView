//
//  MainViewController.m
//  IMPStudy
//
//  Created by 王会洲 on 16/12/12.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**IMP指针study*/
#import <objc/runtime.h>
#import "MainViewController.h"
#import "UIScrollView+Adapter.h"
#import "NSArray+Swizzle.h"
#import "IMPExtensionConst.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,EmptyDataSource>

@property (nonatomic, weak) UITableView * myTableView;
@property (nonatomic, strong) NSMutableArray * myData;

@end

@implementation MainViewController
-(NSMutableArray *)myData {
    if (_myData == nil) {
        _myData = [NSMutableArray new];
    }
    return _myData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDataAfter];
    UITableView * myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.EmptyDataSource = self;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    /**添加按钮*/
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    /**删除按钮*/
    UIButton * DelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    DelBtn.frame = CGRectMake(100, 160, 100, 50);
    DelBtn.backgroundColor = [UIColor greenColor];
    [DelBtn addTarget:self action:@selector(delClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:DelBtn];
}

-(void)addDataAfter{
    [self.myData addObject:@"1"];
    [self.myData addObject:@"12"];
    [self.myData addObject:@"13"];
    [self.myData addObject:@"14"];
}
#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myData.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.myData[indexPath.row];
    return cell;
}


-(void)addClick {
    [self.myData addObject:@"电脑"];
    [self.myTableView reloadData];
}
-(void)delClick {
    if (self.myData.count == 0) return;
    [self.myData removeObjectAtIndex:0];
    [self.myTableView reloadData];
}


#pragma MARK - EmptyDataSource
-(UIView *) ResponsrWithscrollView:(UIScrollView *)scrollView {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton * refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.backgroundColor = [UIColor blueColor];
    refreshButton.frame = CGRectMake(100, 100, 100, 100);
    [refreshButton addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:refreshButton];
    return view;
}

-(void)refreshClick {
    [self addClick];
}










-(NSString *)duanyanchuli {
    ExtensionAssert2(2 == 4, nil);
    NSLog(@"-----duanyanchuli");
    return @"123";
}
-(void)t0 {
    ExtensionAssert(2==3);
    NSLog(@"-----t0");
}

-(void)t1 {
    NSString * str = nil;
    ExtensionAssertParamNotNil(str);
    NSLog(@"-----t1");
}


-(NSString *)t2 {
    NSString * strs = @"456";
    ExtensionAssertParamNotNil2(strs,@"这是真的");


    NSLog(@"-----t2");
    return  @"dddd";
}

//-(id)my_objectAtIndex:(NSUInteger)index {
//    NSLog(@"-------------------");
//    return [self my_objectAtIndex:index];
//}



- (void)swizzleIfPossible:(SEL)selector {
//    if (![self respondsToSelector:selector]) {
//        return;
//    }
    
    NSLog(@"----swizzleIfPossible");
    SEL selctor1 = @selector(btnClick);
    SEL selctor1_1 = NSSelectorFromString(@"btnClick");
    SEL selctor2 = @selector(btnClick2);
    
    [self performSelector:selctor1 withObject:nil afterDelay:0.0];
    [self performSelector:selctor1_1 withObject:nil afterDelay:0.0];
    [self performSelector:@selector(btnClick)];
    [self performSelector:selctor2 withObject:nil afterDelay:0.0];
}
-(void)btnClick {
    NSLog(@"----btnClick");
}

-(void)btnClick2 {
    NSLog(@"----btnClick2");
}






@end
