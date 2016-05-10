//
//  Define.h
//  Heath
//
//  Created by 郭凯 on 16/4/15.
//  Copyright © 2016年 TY. All rights reserved.
//

#ifndef Define_h
#define Define_h
#import "GKQuickUIUitil.h"

#define kScreenSizeWidth [UIScreen mainScreen].bounds.size.width
#define kScreenSizeHeight [UIScreen mainScreen].bounds.size.height

/**
 *  按照aColor颜色创建一张size大小的图片
 *
 */
#define GJCFQuickImageByColorWithSize(aColor,size) [GKQuickUIUitil imageForColor:aColor size:size]

#define kSetRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#endif /* Define_h */
