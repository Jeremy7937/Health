//
// Created by drinking on 15/7/8.
// Copyright (c) 2015 drinking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DKFlexibleMenuItem;

typedef  void(^DKFlexibleMenuItemSelectedBlock)(DKFlexibleMenuItem *item);

@interface DKFlexibleMenu : UIView

@property (nonatomic, copy) DKFlexibleMenuItemSelectedBlock menuItemSelectedBlock;

- (instancetype)initWithFrame:(CGRect)frame MenuItems:(NSArray *)items;
- (void)showInView:(UIView *)view AtPoint:(CGPoint)point;

@end