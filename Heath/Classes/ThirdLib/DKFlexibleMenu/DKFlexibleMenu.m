// Created by drinking on 15/7/8.
// Copyright (c) 2015 drinking. All rights reserved.
//

#import "DKFlexibleMenu.h"
#import "DKFlexibleMenuItem.h"

@interface DKFlexibleMenu ()

@property(nonatomic, strong) NSArray *menuItems;
@property(nonatomic, assign) CGPoint showFromPoint;

@end

@implementation DKFlexibleMenu {

}

- (instancetype)initWithFrame:(CGRect)frame MenuItems:(NSArray *)items {
    if (self = [super initWithFrame:frame]) {
        _menuItems = items;

//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu)];
//        [self addGestureRecognizer:tap];
//        [self commonInit];
    }
    return self;
}

- (void)commonInit {

}

- (void)setUpMenuItems {

    DKFlexibleMenuItem *item = self.menuItems[0];

    if (item.positionCode == -1) {
        NSArray *finalPoints = [self calculateAvailablePoints:self.menuItems.count Radius:item.radius];

        [self.menuItems enumerateObjectsUsingBlock:^(DKFlexibleMenuItem *item, NSUInteger idx, BOOL *stop) {
            UIView *iv = [item buildMenuItemView];
            iv.center = [finalPoints[idx] CGPointValue];

            UIButton *button = [[UIButton alloc] initWithFrame:iv.bounds];
            [iv addSubview:button];
            [button addTarget:self action:@selector(didMenuItemSelected:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = idx;
            iv.alpha = 0;
            [self addSubview:iv];
            [self displayShowAnimation:iv delay:idx * 0.1];
        }];
    } else {
        [self.menuItems enumerateObjectsUsingBlock:^(DKFlexibleMenuItem *item, NSUInteger idx, BOOL *stop) {
            UIView *iv = [self rePositionMenuItem:item];
            UIButton *button = [[UIButton alloc] initWithFrame:iv.bounds];
            [iv addSubview:button];
            [button addTarget:self action:@selector(didMenuItemSelected:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = idx;
            iv.alpha = 0;
            [self addSubview:iv];
            [self displayShowAnimation:iv delay:idx * 0.1];
        }];
    }

}

- (UIView *)rePositionMenuItem:(DKFlexibleMenuItem *)item {

    UIView *view = [item buildMenuItemView];

    if (item.positionCode == 0) {
        return view;
    }

    if (item.positionCode == -1) {

    }

    CGPoint offset = [self calculateOffsetPoint:item.positionCode Radius:item.radius];
    view.center = CGPointMake(self.showFromPoint.x + offset.x, self.showFromPoint.y + offset.y);

    return view;
}

/***
* direction code:
* left top 1
* left 2
* left bottom 3
* right botom 4
* right 5
* right top 6
*/

- (CGPoint)calculateOffsetPoint:(NSInteger)positionCode Radius:(CGFloat)radius {

    CGFloat padding = 2;
    radius = radius + padding;
    CGPoint offset = CGPointZero;

    do {
        NSInteger direction = positionCode % 10;

        if (direction == 1 || direction == 3) {
            offset.x -= radius * sqrt(3) / 2;
        } else if (direction == 4 || direction == 6) {
            offset.x += radius * sqrt(3) / 2;
        } else {
            double distance = radius * sqrt(3);
            offset.x += direction == 2 ? -distance : distance;
        }

        if (direction == 1 || direction == 6) {
            offset.y -= radius * 1.5;
        } else if (direction == 4 || direction == 3) {
            offset.y += radius * 1.5;
        } else {
            // don't offset y
        }
        positionCode = positionCode / 10;
    } while (positionCode % 10 != 0);

    return offset;
}

- (BOOL)outOfBounds:(CGPoint)point Radius:(CGFloat)radius inView:(UIView *)view {

    CGFloat d = 0.866 * radius; // 0.866 equals to sqrt(3)/2
    CGRect rect = CGRectMake(point.x - d, point.y - d, 2 * d, 2 * d);
    return !CGRectContainsRect(view.frame, rect);
}


- (NSArray *)calculateAvailablePoints:(NSInteger)count Radius:(CGFloat)radius {

    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:count];
    NSMutableArray *directionOffsets = [[NSMutableArray alloc] initWithCapacity:6];

    for (int j = 1; j < 7; ++j) {
        CGPoint offset = [self calculateOffsetPoint:j Radius:radius];
        [directionOffsets addObject:[NSValue valueWithCGPoint:offset]];
    }

    NSInteger level = 1;
    while (array.count < count) {

        // start from right cell
        CGPoint startPoint = CGPointZero;
        CGPoint startOffset = [directionOffsets[4] CGPointValue];
        for (NSInteger j = level; j > 0; --j) {
            startPoint.x += startOffset.x;
            startPoint.y += startOffset.y;
        }

        for (NSInteger i = 1; i < 7; ++i) {
            CGPoint offset = [directionOffsets[i - 1] CGPointValue];
            for (NSInteger j = 0; j < level; ++j) {
                startPoint.x += offset.x;
                startPoint.y += offset.y;

                CGPoint finalPoint = CGPointMake(self.showFromPoint.x + startPoint.x, self.showFromPoint.y + startPoint.y);
                if (![self outOfBounds:finalPoint Radius:radius inView:self]) {
                    [array addObject:[NSValue valueWithCGPoint:finalPoint]];
                    if ([array count] == count) return array;
                }
            }

        }

        level++;

    }

    return array;
}

- (void)didMenuItemSelected:(UIButton *)gesture {
    DKFlexibleMenuItem *item = gesture.tag < self.menuItems.count ? self.menuItems[gesture.tag] : nil;
    if (self.menuItemSelectedBlock && item) {
        self.menuItemSelectedBlock(item);
    }
   // [self hideMenu];
}

- (void)showInView:(UIView *)view AtPoint:(CGPoint)point {
    [view addSubview:self];
    self.showFromPoint = point;
    [self setUpMenuItems];
}

//- (void)hideMenu {
//    [self removeFromSuperview];
//
//}

- (void)displayShowAnimation:(UIView *)view delay:(CGFloat)second {

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.beginTime = CACurrentMediaTime() + second;
    animation.duration = 0.3;
    animation.repeatCount = 1;
    animation.fromValue = @(0.5);
    animation.toValue = @(1.0);
    [view.layer addAnimation:animation forKey:@"scale-layer"];

    view.alpha = 0;
    [UIView animateKeyframesWithDuration:0.5
                                   delay:second
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  view.alpha = 1;
                              } completion:nil];

}

@end