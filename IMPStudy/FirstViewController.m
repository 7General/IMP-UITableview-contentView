//
//  FirstViewController.m
//  IMPStudy
//
//  Created by zzg on 2018/12/17.
//  Copyright © 2018年 王会洲. All rights reserved.
//

#import "FirstViewController.h"
#import "MainViewController.h"

@interface FirstViewController ()
@property (nonatomic, strong) MainViewController * mainView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    MainViewController *mainView = [[MainViewController alloc] init];
    [self.navigationController pushViewController:mainView animated:YES];
}

@end
