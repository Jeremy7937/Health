//
//  SegmentBaseViewController.m
//  Heath
//
//  Created by 郭凯 on 16/4/21.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "SegmentBaseViewController.h"
#import "Define.h"
#import "MineViewController.h"

@interface SegmentBaseViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation SegmentBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.view.backgroundColor = [UIColor redColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight - 124) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    //self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据，第%ld行",indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectedBlock) {
        self.selectedBlock(indexPath);
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //  NSLog(@"_____y:%lf",scrollView.contentOffset.y);
    
    if (self.scrollHeaderBlock) {
        self.scrollHeaderBlock(scrollView.contentOffset);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
