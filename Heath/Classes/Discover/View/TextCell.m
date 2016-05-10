//
//  TextCell.m
//  Heath
//
//  Created by 郭凯 on 16/4/26.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "TextCell.h"
#import "Define.h"

@implementation TextCell
{
    TextModel *_model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)showDataWithIndexPath:(NSIndexPath *)indexPath model:(TextModel *)model{
    _model = model;
    
    self.backImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
    [self.backImageView addGestureRecognizer:tap];
    
    if ([model.isReply isEqualToString:@"1"]) {
        //回复的Cell
        //根据内容的size改变气泡的大小
//        CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kScreenSizeWidth - 120 - 40, 1000.0f) lineBreakMode:NSLineBreakByWordWrapping];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGSize size = [model.content boundingRectWithSize:CGSizeMake(kScreenSizeWidth - 120 - 40, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        self.leftConstraint.constant = kScreenSizeWidth - 120 - size.width - 40;
        
        self.leftIconImageView.hidden = YES;
        self.rightIconImageView.hidden = NO;
        
        self.contentLabel.text = model.content;
        UIImage *image = [UIImage imageNamed:@"SenderAppCardNodeBkg"];
        self.backImageView.image = [image stretchableImageWithLeftCapWidth:21 topCapHeight:30];
        
    }else if([model.isReply isEqualToString:@"0"]){
        
//        CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kScreenSizeWidth - 120 - 40, 1000.0f) lineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
         CGSize size = [model.content boundingRectWithSize:CGSizeMake(kScreenSizeWidth - 120 - 40, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        self.rightConstraint.constant = kScreenSizeWidth - 120 - size.width - 40;
        
        self.rightIconImageView.hidden = YES;
        self.leftIconImageView.hidden = NO;
        
        NSString *contentStr = model.content;
        self.contentLabel.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row,contentStr];
        UIImage *image = [UIImage imageNamed:@"ReceiverTextNodeBkg"];
        self.backImageView.image = [image stretchableImageWithLeftCapWidth:21 topCapHeight:30];

    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)cellClick:(UITapGestureRecognizer *)tap {
    NSLog(@"________%@",_model.content);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
