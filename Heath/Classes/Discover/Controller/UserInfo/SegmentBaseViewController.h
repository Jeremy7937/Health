//
//  SegmentBaseViewController.h
//  Heath
//
//  Created by 郭凯 on 16/4/21.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


//tableView滑动Block
typedef void(^ScrollHeaderViewBlock)(CGPoint point);
//选中tableView某行的block
typedef void(^DidSelectedRowAtIndexPath)(NSIndexPath *indexPath);

@interface SegmentBaseViewController : BaseViewController

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, copy)ScrollHeaderViewBlock scrollHeaderBlock;
@property (nonatomic, copy)DidSelectedRowAtIndexPath selectedBlock;

@end
