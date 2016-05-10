//
//  BaseViewController.m
//  Heath
//
//  Created by 熊伟 on 16/4/7.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "BaseViewController.h"
#import "GKQuickUIUitil.h"
#import "Define.h"

@interface BaseViewController ()

@property (nonatomic,strong)UILabel *titleLabel;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [[UINavigationBar appearance] setBarTintColor:kSetRGBColor(151, 151, 151)];
//    CGSize size = CGSizeMake(kScreenSizeWidth, 64);
//    
//    UIImage *image = GJCFQuickImageByColorWithSize([UIColor yellowColor],size);
//    
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setStrNavTitle:(NSString *)title {
    UIView *navTitleView = (self.navigationItem.titleView);
    
    if ([navTitleView isKindOfClass:[UILabel class]]) {
        self.titleLabel = (UILabel *)navTitleView;
        self.titleLabel.text = title;
    }else {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.text = title;
        self.navigationItem.titleView = _titleLabel;
    }
    
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.titleLabel sizeToFit];
}

- (void)addBarButtonItemWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action isLeft:(BOOL)isLeft {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (isLeft) {
        btn.frame = CGRectMake(0, 0, 16, 30);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }else {
        btn.frame = CGRectMake(0, 0, 16, 25);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        if (title) {
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTintColor:[UIColor whiteColor]];
        }
    }else if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        btn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    //btn.backgroundColor = [UIColor redColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    }else {
        self.navigationItem.rightBarButtonItem = item;
    }
    

}

@end
