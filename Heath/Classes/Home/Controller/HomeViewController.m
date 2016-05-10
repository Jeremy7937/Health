//
//  HomeViewController.m
//  Heath
//
//  Created by 熊伟 on 16/4/7.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "HomeViewController.h"
#import "settingViewController.h"
#import "DKFlexibleMenu.h"
#import "DKFlexibleMenuItem.h"
#import "Define.h"
#import "CategoryViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *FixedMenuView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBarButtonItemWithTitle:@"扫一扫" imageName:nil target:self action:@selector(setting:) isLeft:NO];
    [self setUpFlexible];
    [self setUpCenterView];
}

- (void)setUpFlexible {
    self.FixedMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight - 64 - 49)];
    //view.center = self.view.center;
    //self.FixedMenuView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.FixedMenuView];
    
    [self showFixedMenuInView:self.FixedMenuView AtPoint:self.FixedMenuView.center];
}

- (void)setUpCenterView {
    DKFlexibleMenuItem *centerItem = [[DKFlexibleMenuItem alloc] initWithTitle:@"各项指标正常组" subString:@"2389\n服务人数"];
   // centerItem.backgroundColor = [UIColor grayColor];
    UIView *view = [centerItem buildMenuItemView];
    view.center = self.FixedMenuView.center;
    UIButton *btn = [[UIButton alloc] initWithFrame:view.bounds];
    [view addSubview:btn];
    [btn addTarget:self action:@selector(centerItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.FixedMenuView addSubview:view];
}

- (void)centerItemClick:(UIButton *)centerBtn {
    NSLog(@"_______centerBtnClick");
    CategoryViewController *category = [[CategoryViewController alloc] init];
    category.navTitle = @"正常组";
    [self.navigationController pushViewController:category animated:YES];
}

- (void)showFixedMenuInView:(UIView *)view AtPoint:(CGPoint)point {
    
    DKFlexibleMenuItem *shareItem = [[DKFlexibleMenuItem alloc] initWithTitle:@"肿瘤指标异常组" subString:@"2389\n服务人数"];
    shareItem.backgroundColor = kSetRGBColor(254, 115, 123);
    shareItem.positionCode = 3;
    
    DKFlexibleMenuItem *recommendItem = [[DKFlexibleMenuItem alloc] initWithTitle:@"高血压组" subString:@"2389\n服务人数"];
    
    recommendItem.backgroundColor = kSetRGBColor(148, 204, 106);
    recommendItem.positionCode = 2;
    DKFlexibleMenuItem *deleteItem = [[DKFlexibleMenuItem alloc] initWithTitle:@"重大阳性组" subString:@"2389\n服务人数"];
    
    deleteItem.backgroundColor = kSetRGBColor(233, 200, 80);
    deleteItem.positionCode = 4;
    
    DKFlexibleMenuItem *flexibleItem = [[DKFlexibleMenuItem alloc] initWithTitle:@"其他组" subString:@"2389\n服务人数"];
    flexibleItem.backgroundColor = kSetRGBColor(118, 209, 207);
    flexibleItem.positionCode = 1;
    
    DKFlexibleMenuItem *imageItem = [[DKFlexibleMenuItem alloc] initWithTitle:@"血脂异常组" subString:@"2389\n服务人数"];

    imageItem.backgroundColor = kSetRGBColor(152, 200, 207);
    imageItem.positionCode = 5;
    
    DKFlexibleMenuItem *imageItem2 = [[DKFlexibleMenuItem alloc] initWithTitle:@"糖尿病组" subString:@"2389\n服务人数"];
    imageItem2.backgroundColor = kSetRGBColor(100, 153, 213);
    imageItem2.positionCode = 6;
    
    DKFlexibleMenu *menu = [[DKFlexibleMenu alloc] initWithFrame:view.bounds MenuItems:@[shareItem, recommendItem, flexibleItem, deleteItem, imageItem, imageItem2]];
    
    menu.menuItemSelectedBlock = ^(DKFlexibleMenuItem *item) {

        //NSLog(@"______itemTag:%@",item.title);
        CategoryViewController *category = [[CategoryViewController alloc] init];
        category.navTitle = item.title;
        [self.navigationController pushViewController:category animated:YES];
        
    };
    
    [menu showInView:view AtPoint:point];

}

#pragma mark -- UICollectionViewDelegate

- (void)setting:(UIButton *)btn {
    settingViewController *setting = [[settingViewController alloc] init];
    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
