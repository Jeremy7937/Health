//
//  TextCell.h
//  Heath
//
//  Created by 郭凯 on 16/4/26.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"

@interface TextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;


@property (weak, nonatomic) IBOutlet UIImageView *leftIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightIconImageView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;

- (void)showDataWithIndexPath:(NSIndexPath *)indexPath model:(TextModel *)model;
@end
