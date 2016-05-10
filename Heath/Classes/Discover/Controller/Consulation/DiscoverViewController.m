//
//  DiscoverViewController.m
//  Heath
//
//  Created by 熊伟 on 16/4/7.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "DiscoverViewController.h"
#import "MineViewController.h"
#import "TestViewController.h"
//#import "HeaderDemoViewController.h"
#import "GKPopView.h"
#import "ConsulationViewController.h"
#import "ConsulationBaseViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.badgeValue = @"99";
    self.titleArr = @[@"待处理",@"已处理",@"问题反馈"];
    ConsulationBaseViewController *controll1 = [[ConsulationBaseViewController alloc] init];
    controll1.selectedBlock = ^(NSIndexPath *indexPaht) {
        ConsulationViewController *consulate = [[ConsulationViewController alloc] init];
        consulate.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:consulate animated:YES];
    };
    ConsulationBaseViewController *controll2 = [[ConsulationBaseViewController alloc] init];
    ConsulationBaseViewController *controll3 = [[ConsulationBaseViewController alloc] init];
    
    self.controllerArr = @[controll1,controll2,controll3];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
   // self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   // self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
