//
//  CommonLanguageCell.h
//  Heath
//
//  Created by 郭凯 on 16/4/22.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonLanguageModle.h"

typedef void(^SelectedItemBlock)(NSString * title,NSString* isAdd);

@interface CommonLanguageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (nonatomic, copy) SelectedItemBlock selectedBlock;

- (void)showDataWithModel:(CommonLanguageModle *)model index:(NSInteger)index;

@end
