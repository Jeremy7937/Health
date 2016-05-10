//
//  BaseViewController.h
//  Heath
//
//  Created by 熊伟 on 16/4/7.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//设置导航栏标题
- (void)setStrNavTitle:(NSString *)title;

//设置导航按钮
- (void)addBarButtonItemWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action isLeft:(BOOL)isLeft;

@end
