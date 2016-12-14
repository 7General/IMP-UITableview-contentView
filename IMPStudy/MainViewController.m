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
//    myTableView.EmptyDataSource = self;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(goClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
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


-(void)goClick {

    [self.myData addObject:@"电脑"];
    [self.myTableView reloadData];
    
    
    
    
    
//    Class clas = objc_getClass("__NSArrayI");
//    Method ori_Method =  class_getInstanceMethod(clas, @selector(objectAtIndex:));
//    Method my_Method = class_getInstanceMethod(clas, @selector(my_objectAtIndex:));
//    method_exchangeImplementations(ori_Method, my_Method);
//    
//    NSArray *array = @[@"0",@"1",@"2",@"3",@"4"];
//    NSString *string = [array objectAtIndex:10];
//    NSLog(@"TEST RESULT : %@",string);
    
    
//    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
//    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(my_objectAtIndex:));
//    method_exchangeImplementations(fromMethod, toMethod);
    
   

//    Method ori_Method =  class_getInstanceMethod([NSArray class], @selector(lastObject));
//    Method my_Method = class_getInstanceMethod([NSArray class], @selector(mylastObject));
//    method_exchangeImplementations(ori_Method, my_Method);
//    
//    
//    NSArray *array = @[@"0",@"1",@"2",@"3"];
//    NSString *string = [array lastObject];
//    NSLog(@"TEST RESULT : %@",string);
    
    
    //NSLog(@"----------------%@",[self duanyanchuli]);
    
    [self duanyanchuli];
    [self t0];
    [self t1];
    [self t2];
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
