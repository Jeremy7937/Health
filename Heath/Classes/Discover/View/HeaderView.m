//
//  HeaderView.m
//  Heath
//
//  Created by 郭凯 on 16/5/4.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)backBtnClick:(id)sender {
    
    if (self.block) {
        self.block();
    }
}

@end
