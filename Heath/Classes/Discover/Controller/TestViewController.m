//
//  TestViewController.m
//  Heath
//
//  Created by 郭凯 on 16/4/18.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "TestViewController.h"
#import "Define.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourthViewController.h"
#import "HeaderView.h"
#import "GKSliderView.h"
#import "MineViewController.h"

#define kHeaderViewHeight 250

@interface TestViewController ()

@property (nonatomic, strong)HeaderView *headerView;
@property (nonatomic, strong)UIView *navView;
@property (nonatomic, strong)GKSliderView *sliderView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpHeaderView];
    [self setUpSlideView];
}

- (void)setUpHeaderView {
    
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
    self.headerView.frame = CGRectMake(0, 0, kScreenSizeWidth, 250);
    __weak TestViewController * weakSelf = self;
    self.headerView.block = ^(){
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.headerView];
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 64)];
    self.navView.backgroundColor = [UIColor grayColor];
    self.navView.alpha = 0.0;
    [self.view addSubview:self.navView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
   // btn.backgroundColor = [UIColor redColor];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget: self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(10, 30, 12, 22);
    [self.navView addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenSizeWidth/2 - 50, 22, 100, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"张三";
    label.tintColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    [self.navView addSubview:label];
}

- (void)backBtnClick:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpSlideView {
//    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 250, kScreenSizeWidth, kScreenSizeHeight-250)];
//    self.tabedSlideView.baseViewController = self;
//    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
//    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
//    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
//    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
//    self.tabedSlideView.tabbarBottomSpacing = 3.0;
//    self.tabedSlideView.delegate = self;
//    self.tabedSlideView.tabbarHeight = 60;
//    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"最新" image:[UIImage imageNamed:@"goodsNew"] selectedImage:[UIImage imageNamed:@"goodsNew_d"]];
//    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"最热" image:[UIImage imageNamed:@"goodsHot"] selectedImage:[UIImage imageNamed:@"goodsHot_d"]];
//    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"价格" image:[UIImage imageNamed:@"goodsPrice"] selectedImage:[UIImage imageNamed:@"goodsPrice_d"]];
//    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
//    [self.tabedSlideView buildTabbar];
//    
//    self.tabedSlideView.selectedIndex = 0;
//    
//    [self.view addSubview:self.tabedSlideView];
    
    NSArray *titleArr = @[@"体检报告",@"照片病例",@"健康咨询",@"日常体征"];
    OneViewController *one = [[OneViewController alloc] init];
    one.scrollHeaderBlock = ^(CGPoint point) {
        [self changeFrameWithViewPoint:point];
    };
    one.selectedBlock = ^(NSIndexPath *indexPath) {
        MineViewController *mine = [[MineViewController alloc] init];
        [self.navigationController pushViewController:mine animated:YES];
    };
    
    TwoViewController *two = [[TwoViewController alloc] init];
    two.scrollHeaderBlock = ^(CGPoint point) {
        [self changeFrameWithViewPoint:point];
    };
    
    ThreeViewController *three = [[ThreeViewController alloc] init];
    three.scrollHeaderBlock = ^(CGPoint point) {
        [self changeFrameWithViewPoint:point];
    };
    
    FourthViewController *four = [[FourthViewController alloc] init];
    four.scrollHeaderBlock = ^(CGPoint point) {
        [self changeFrameWithViewPoint:point];
    };
    
    NSArray *controllerArr = @[one,two,three,four];
    self.sliderView = [[GKSliderView alloc] initWithFrame:CGRectMake(0, 250, kScreenSizeWidth, kScreenSizeHeight - 250) titleArr:titleArr controllerNameArr:controllerArr];
    __weak TestViewController *weakSelf = self;
    self.sliderView.resetBlock = ^(){
        weakSelf.headerView.frame = CGRectMake(0, 0, kScreenSizeWidth, 250);
        weakSelf.sliderView.frame = CGRectMake(0, 250, kScreenSizeWidth, kScreenSizeHeight - 250);
        
        one.tableView.contentOffset = CGPointMake(0, 0);
        two.tableView.contentOffset = CGPointMake(0, 0);
        three.tableView.contentOffset = CGPointMake(0, 0);
        four.tableView.contentOffset = CGPointMake(0, 0);
    };
    
    [self.view addSubview:self.sliderView];
}


-(void)changeFrameWithViewPoint:(CGPoint)point {
        
        self.navView.alpha = point.y / 186.0;
        
        if (point.y <= 0) {
            self.headerView.backBtn.hidden = NO;
        }else {
            self.headerView.backBtn.hidden = YES;
        }
        
        if (point.y <= 186) {
            CGRect headerFrame = self.headerView.frame;
            headerFrame.origin.y = -point.y;
            self.headerView.frame = headerFrame;
            
            CGRect sliderFrame = self.sliderView.frame;
            sliderFrame.origin.y = 250 - point.y;
            sliderFrame.size.height = kScreenSizeHeight - sliderFrame.origin.y;
            self.sliderView.frame = sliderFrame;
        }else {
            NSLog(@"_________change");
            
            self.headerView.frame = CGRectMake(0, -187, kScreenSizeWidth, 250);
            self.sliderView.frame = CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64);
        }
}

- (void)setNavigationBarColor:(UIColor *)color {
    
    CGSize size = CGSizeMake(kScreenSizeWidth, 64);
    
    UIImage *image = GJCFQuickImageByColorWithSize(color,size);
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   // [self setNavigationBarColor:[UIColor clearColor]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   // [self setNavigationBarColor:[UIColor grayColor]];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
