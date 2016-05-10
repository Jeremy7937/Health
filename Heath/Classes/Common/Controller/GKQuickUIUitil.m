//
//  GKQuickUIUitil.m
//  Heath
//
//  Created by 郭凯 on 16/4/15.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "GKQuickUIUitil.h"

@implementation GKQuickUIUitil


+ (UIImage *)imageForColor:(UIColor *)color size:(CGSize)size {
        
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;

}
@end
