//
//  MineViewController.m
//  Heath
//
//  Created by 郭凯 on 16/4/15.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "MineViewController.h"
#import "GKPopView.h"
#import "Define.h"
#import "CommonLanguageModle.h"

@interface MineViewController ()
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UILabel *resultLabel;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //[self setUpSlideView];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(100, 300, 50, 30);
    [button2 setTitle:@"张三" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor redColor];
    [button2 addTarget: self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, kScreenSizeWidth - 60, 150)];
    self.resultLabel.numberOfLines = 0;
    [self.view addSubview:self.resultLabel];
    
    self.dataArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CommonLanguage" ofType:@"plist"];
    NSArray *arr = [[NSArray arrayWithContentsOfFile:path] firstObject];
    
    for (NSDictionary *dict in arr) {
        CommonLanguageModle *model = [[CommonLanguageModle alloc] init];
        model.title = dict[@"content"];
        model.isClick = dict[@"isClick"];
        [self.dataArr addObject:model];
    }
}

- (void)buttonClick:(UIButton *)btn {
    GKPopView *view = [[GKPopView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight) data:self.dataArr];
    
    view.block = ^(NSString *str) {
        self.resultLabel.text = str;
    };
    [self.navigationController.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
