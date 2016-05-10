//
// Created by drinking on 15/7/8.
// Copyright (c) 2015 drinking. All rights reserved.
//

#import "DKFlexibleMenuItem.h"
#import "Define.h"

@interface DKFlexibleMenuItem()

@end

@implementation DKFlexibleMenuItem {
    
}
- (instancetype)initWithTitle:(NSString *)title Image:(UIImage *)image{
    if (self = [super init]) {
        _image = image;
        _title = title;
        _radius = 60;
        _positionCode = -1;
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title subString:(NSString *)subString {
    if (self = [super init]) {
        _title = title;
        _subTitle = subString;
        _radius = [self getRadius];
        _positionCode = -1;
    }
    
    return self;
}

- (NSInteger)getRadius {
    if (kScreenSizeHeight == 480) {
        //iPhone4,4s
        return 55;
    }else if (kScreenSizeHeight == 568) {
        //iPhone5,5s
        return 55;
        
    }else {
        return 65;
    }
}

- (void)hexagonMask:(UIView *)view {

    CGPoint center = view.center;
    CGFloat dx = (CGFloat) (self.radius * sqrt(3) / 2);
    CGFloat dy = self.radius / 2;

    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(center.x, center.y - self.radius)];
    [trianglePath addLineToPoint:CGPointMake(center.x - dx, center.y - dy)];
    [trianglePath addLineToPoint:CGPointMake(center.x - dx, center.y + dy)];
    [trianglePath addLineToPoint:CGPointMake(center.x, center.y + self.radius)];
    [trianglePath addLineToPoint:CGPointMake(center.x + dx, center.y + dy)];
    [trianglePath addLineToPoint:CGPointMake(center.x + dx, center.y - dy)];
    [trianglePath addLineToPoint:CGPointMake(center.x, center.y - self.radius)];
    [trianglePath closePath];

    CAShapeLayer *triangleMaskLayer = [CAShapeLayer layer];
    [triangleMaskLayer setPath:trianglePath.CGPath];
    view.layer.mask = triangleMaskLayer;
}

- (UIView *)buildMenuItemView {
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _radius*2, _radius*2)];
    
    view.userInteractionEnabled = YES;
    [view setImage:self.backgroundImage];
    view.backgroundColor = self.backgroundColor;
    
//    UIImageView *iv = [[UIImageView alloc] initWithImage:self.image];
//    CGFloat dimension = 18;
//    CGFloat offsetY = 7;
//    iv.frame = CGRectMake(0, 0, dimension, dimension);
//    iv.center = CGPointMake(view.center.x, view.center.y - offsetY);
//    [view addSubview:iv];
//
//
//    CGFloat labelOffsetY = 8;
//    UILabel *label = [[UILabel alloc] init];
//    label.font = [UIFont boldSystemFontOfSize:10];
//    label.textColor = [UIColor whiteColor];
//    label.text = self.title;
//    [label sizeToFit];
//    label.center = CGPointMake(view.center.x, view.center.y + labelOffsetY);
//    [view addSubview:label];
    
    //设置标题位置
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:13];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = self.title;
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(view.center.x, view.center.y - 20);
    [view addSubview:titleLabel];
    
    //设置副标题
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.font = [UIFont systemFontOfSize:10];
    subTitleLabel.textColor = [UIColor blackColor];
    subTitleLabel.text = self.subTitle;
    subTitleLabel.numberOfLines = 2;
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [subTitleLabel sizeToFit];
    subTitleLabel.center = CGPointMake(view.center.x, view.center.y + 15);
    [view addSubview:subTitleLabel];
    
    [self hexagonMask:view];
    return view;
}

@end