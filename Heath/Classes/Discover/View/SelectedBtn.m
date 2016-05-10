//
//  SelectedBtn.m
//  Heath
//
//  Created by 郭凯 on 16/4/29.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "SelectedBtn.h"

@implementation SelectedBtn
{
    NSString *_title;
    UIButton *_btn;
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        _title = title;
        [self setUpBaseUI];
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected {
    _btn.selected = isSelected;
}
- (void)setUpBaseUI {
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = self.bounds;
    [_btn setTitle:_title forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateSelected];
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _btn.selected = _isSelected;
    [self addSubview:_btn];
    
}

- (void)btnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (self.block) {
        self.block();
    }
}

@end
