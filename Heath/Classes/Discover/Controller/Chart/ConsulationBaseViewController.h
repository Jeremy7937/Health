//
//  ConsulationBaseViewController.h
//  Heath
//
//  Created by 郭凯 on 16/4/28.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void(^CellSelectedBlock)(NSIndexPath *indexPath);

@interface ConsulationBaseViewController : BaseViewController

@property (nonatomic, copy)CellSelectedBlock selectedBlock;

@end
