//
//  GKPopView.h
//  Heath
//
//  Created by 郭凯 on 16/4/21.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetStrBlock)(NSString * str);

@interface GKPopView : UIView

@property (nonatomic, copy)GetStrBlock block;

- (instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray *)dataArr;

@end
