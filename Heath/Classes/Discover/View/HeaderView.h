//
//  HeaderView.h
//  Heath
//
//  Created by 郭凯 on 16/5/4.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBtnClickBlock)();

@interface HeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic, copy)BackBtnClickBlock block;

@end
