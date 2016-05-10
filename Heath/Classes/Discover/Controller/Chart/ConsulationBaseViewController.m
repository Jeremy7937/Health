//
//  ConsulationBaseViewController.m
//  Heath
//
//  Created by 郭凯 on 16/4/28.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "ConsulationBaseViewController.h"
#import "Define.h"
#import "ConsulationViewController.h"
#import "SelectedBtn.h"

@interface ConsulationBaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ConsulationBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight - 48 - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectedBlock) {
        self.selectedBlock(indexPath);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    return [self setUpSectionHeaderView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)setUpSectionHeaderView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor grayColor];
    CGFloat itemsSpace = (kScreenSizeWidth - 50 - 100 -120)/4;
   // SelectedBtn *btn1,*btn2,*btn3;
    SelectedBtn *btn1;
    SelectedBtn *btn2;
    SelectedBtn *btn3;
    
    btn1 = [[SelectedBtn alloc] initWithFrame:CGRectMake(itemsSpace, 7, 50, 30) title:@"全部"];
    btn2 = [[SelectedBtn alloc] initWithFrame:CGRectMake(itemsSpace*2 +50, 7, 100, 30) title:@"输入的问题"];
    btn3 = [[SelectedBtn alloc] initWithFrame:CGRectMake(itemsSpace*3 +50 +100, 7 , 120, 30) title:@"我的客户的问题"];
    
    [view addSubview:btn1];
    [view addSubview:btn2];
    [view addSubview:btn3];
    
   // btn1.backgroundColor = [UIColor yellowColor];
    btn1.block = ^(){
        btn2.isSelected = NO;
        btn3.isSelected = NO;
        NSLog(@"_________btn1Selected");
    };
    
   // btn2.backgroundColor = [UIColor yellowColor];
    btn2.block = ^(){
        
        btn3.isSelected = NO;
        btn1.isSelected = NO;

        NSLog(@"_________btn2Selected");
    };
    
   // btn3.backgroundColor = [UIColor yellowColor];
    btn3.block = ^(){
        btn2.isSelected = NO;
        btn1.isSelected = NO;
        NSLog(@"_________btn3Selected");
    };
    
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
