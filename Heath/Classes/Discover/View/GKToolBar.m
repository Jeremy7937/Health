
//
//  GKToolBar.m
//  Heath
//
//  Created by 郭凯 on 16/4/27.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "GKToolBar.h"
#import "Define.h"
#import "UIView+SDAutoLayout.h"

@implementation GKToolBar

+(GKToolBar *)createView {
    GKToolBar *toolBar = [[GKToolBar alloc] init];
    toolBar.backgroundColor = kSetRGBColor(239, 239, 246);
    
    SSTextView *textView = [[SSTextView alloc] init];
    textView.backgroundColor = [UIColor whiteColor];
    textView.tag = 10;
    textView.placeholder = @"输入内容:";
    textView.returnKeyType = UIReturnKeySend;
    [toolBar addSubview:textView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"短语" forState:UIControlStateNormal];
    [toolBar addSubview:btn];
    btn.tag = 11;
    
    textView.sd_layout.leftSpaceToView(toolBar,10).widthIs(kScreenSizeWidth - 80).topSpaceToView(toolBar,5).bottomSpaceToView(toolBar,5);
    btn.sd_layout.leftSpaceToView(textView,20).rightSpaceToView(toolBar,20).topSpaceToView(toolBar,5).bottomSpaceToView(toolBar,5);
    
    return toolBar;
}

@end
