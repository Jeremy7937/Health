//
//  UIImage+image.m
//  Heath
//
//  Created by 熊伟 on 16/4/7.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+ (instancetype)imageWithOriginalName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
