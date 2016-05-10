//
//  HZTabBarController.m
//  Heath
//
//  Created by 熊伟 on 16/4/6.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "HZTabBarController.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "UIImage+image.h"
#import "HZNavigationController.h"
#import "Define.h"

@interface HZTabBarController ()

@end

@implementation HZTabBarController

+(void) initialize {
    
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpAllChildViewController];
}

- (void)setUpAllChildViewController {
    HomeViewController *home = [[HomeViewController alloc] init];
   // home.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"tabbar_home"];
    UIImage *selectedImage = [UIImage imageWithOriginalName:@"tabbar_home_selected"];
    NSString *title = @"首页";
    [self setUpOneClildViewController:home image:image selectedImage:selectedImage title:title];
    
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    //discover.view.backgroundColor = [UIColor greenColor];
    [self setUpOneClildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    profile.view.backgroundColor = [UIColor grayColor];
    [self setUpOneClildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我的"];

    
}

- (void)setUpOneClildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    
    //vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
   // vc.navigationItem.title = title;
    vc.title = title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
   // nav.navigationBar setBackgroundImage:<#(nullable UIImage *)#> forBarMetrics:<#(UIBarMetrics)#>
    CGSize size = CGSizeMake(kScreenSizeWidth, 64); 
    
    UIImage *myImage = GJCFQuickImageByColorWithSize([UIColor grayColor],size);
    
    [nav.navigationBar setBackgroundImage:myImage forBarMetrics:UIBarMetricsDefault];

    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
