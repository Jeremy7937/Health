//
// Created by drinking on 15/7/8.
// Copyright (c) 2015 drinking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface DKFlexibleMenuItem : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) NSString *subTitle;

@property (nonatomic, assign) NSInteger positionCode;


- (UIView *)buildMenuItemView;
- (instancetype)initWithTitle:(NSString *)title Image:(UIImage *)image;

- (instancetype)initWithTitle:(NSString *)title subString:(NSString *)subString;

@end