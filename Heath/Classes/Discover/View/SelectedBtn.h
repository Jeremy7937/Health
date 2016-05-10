//
//  SelectedBtn.h
//  Heath
//
//  Created by 郭凯 on 16/4/29.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnClickBlock)();

@interface SelectedBtn : UIView

@property (nonatomic, assign)BOOL isSelected;
@property (nonatomic, copy)BtnClickBlock block;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
