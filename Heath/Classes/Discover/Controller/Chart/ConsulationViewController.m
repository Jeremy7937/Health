//
//  ConsulationViewController.m
//  Heath
//
//  Created by 郭凯 on 16/4/26.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "ConsulationViewController.h"
#import "TestViewController.h"
#import "Define.h"
#import "UserInfoView.h"
#import "TextCell.h"
#import "GKPopView.h"
#import "CommonLanguageModle.h"
#import "GKToolBar.h"
#import "SSTextView.h"
#import "UIView+SDAutoLayout.h"
#import "TextModel.h"

@interface ConsulationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *userInfoView;
@property (nonatomic, strong)GKToolBar *toolBar;
@property (nonatomic, strong)SSTextView *textView;
@property (nonatomic, strong)NSMutableArray *dataArr; //保存常用短语的可变数组
@property (nonatomic, strong)NSMutableArray *textDataArr; //保存聊天记录的可变数组

@end

@implementation ConsulationViewController
{
    BOOL _userViewIsHidden; //userView 是否隐藏
    CGPoint _tableViewOffset; //保存tableView的偏移量，
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _contentStr = @"客户咨询健管师的问题(纯文本样式)客户咨询健管师的问题(纯文本样式)客户咨询健管师的问题(纯文本样式)客户咨询健管师的问题(纯文本样式)客户咨询健管师的问题(纯文本样式)客户咨询健管师的问题(纯文本样式)";
    self.textDataArr = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Text" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in arr) {
        TextModel *model = [[TextModel alloc] init];
        model.content = dict[@"content"];
        model.isReply = dict[@"isReply"];
        [self.textDataArr addObject:model];
    }
    
    self.view.backgroundColor = kSetRGBColor(225, 225, 225);
    [self setUpNavTitleViewWithTitle:@"张三"];
    [self setUpTableView];
    [self setUpUserInfoView];
    [self setUpToolBar];
}

//设置导航titleView 并添加手势
- (void)setUpNavTitleViewWithTitle:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 100, 40)];
   // titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.tintColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
    titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewClick:)];
    [titleLabel addGestureRecognizer:tap];
}

//导航titleView被点击事件
- (void)titleViewClick:(UITapGestureRecognizer *)tap {
    TestViewController *test = [[TestViewController alloc] init];
    
    [self.navigationController pushViewController:test animated:YES];
}

//设置用户信息View
- (void)setUpUserInfoView {
  //  UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, 64)];
    self.userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 64)];
    self.userInfoView.backgroundColor = kSetRGBColor(225, 225, 225);
    [self.view addSubview:self.userInfoView];
    
    UserInfoView *userInfoView = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] lastObject];
    userInfoView.frame = self.userInfoView.bounds;
    [self.userInfoView addSubview:userInfoView];
}

//设置ToolBar
- (void)setUpToolBar {
    
    self.toolBar = [GKToolBar createView];
    [self.view addSubview:self.toolBar];
    self.toolBar.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(46).bottomSpaceToView(self.view,0);
    self.textView = (SSTextView *)[self.toolBar viewWithTag:10];
    self.textView.delegate = self;
    
    UIButton *btn = [self.toolBar viewWithTag:11];
    [btn addTarget:self action:@selector(phraseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //初始化假数据
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

//监听键盘显示事件
- (void)kbWillShow:(NSNotification *)noti{
    
    //每次显示键盘的时候将tableView的偏移量重置
    self.tableView.contentOffset = _tableViewOffset;
    NSLog(@"___________显示键盘,contentY:%lf",_tableViewOffset.y);
    //获取弹出键盘的高度
    CGRect kbendFrame =  [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat kbHeight = kbendFrame.size.height;
    
    if(kbHeight <= 220) { //因为搜狗等第三方的键盘弹出时会调用三次改方法，需要判断
        return;
    }
    self.toolBar.sd_layout.bottomSpaceToView(self.view,kbHeight);
    [self.toolBar updateLayout];

    [self.view layoutIfNeeded];
    NSLog(@"_________%f",kbHeight);
    //根据弹出键盘的高度，修改tableView的偏移量
    CGPoint point = self.tableView.contentOffset;
    point.y += kbHeight;
    self.tableView.contentOffset = point;

    
}
//监听键盘隐藏事件
- (void)kbWillHide:(NSNotification *)noti{
    NSLog(@"_____键盘隐藏,");
    
    CGRect kbendFrame =  [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat kbHeight = kbendFrame.size.height;
    NSLog(@"______%lf",kbHeight);
    
    self.toolBar.sd_layout.bottomSpaceToView(self.view,0);
    [self.toolBar updateLayout];
    [UIView animateWithDuration:0.25 animations:^{
        //self.textView.sd_layout.heightIs(36);
        [self.textView updateLayout];
        //self.toolBar.sd_layout.heightIs(46);
        [self.toolBar updateLayout];
        [self.view layoutIfNeeded];
        
        CGPoint point = self.tableView.contentOffset;
        point.y -= kbHeight;
        self.tableView.contentOffset = point;
    }];
}

//常用短语按钮被点击
- (void)phraseBtnClick:(UIButton *)btn {
    [self.textView resignFirstResponder];
    GKPopView *view = [[GKPopView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight) data:self.dataArr];
    
    view.block = ^(NSString *str) {

        self.textView.text = str;
        [self textViewDidChange:self.textView]; //手动调用代理方法，将TextView高度重置
    };
    [self.navigationController.view addSubview:view];

}

//设置TableView
- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64 - 64 - 40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kSetRGBColor(225, 225, 225);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableViewOffset = self.tableView.contentOffset;
    
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    CGFloat textviewH = 0;
    CGFloat minHeight = 36;
    CGFloat maxHeight = 108;
    
    CGFloat contentHeight = textView.contentSize.height;
    if (contentHeight <minHeight) {
        textviewH = minHeight;
    }else if(contentHeight>maxHeight){
        textviewH = maxHeight;
    }else{
        textviewH = textView.contentSize.height;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.textView.sd_layout.heightIs(textviewH);
        [self.textView updateLayout];
        self.toolBar.sd_layout.heightIs( textviewH+10);
        [self.toolBar updateLayout];
        [self.view layoutIfNeeded];
    }];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"————————发送");
        
        //把textView的内容封装到model中，并添加到可变数组
        NSString *textStr = textView.text;
        TextModel *model = [[TextModel alloc] init];
        model.content = textStr;
        model.isReply = @"1";
        [self.textDataArr addObject:model];
        [self.tableView reloadData]; // 刷新tableView

        textView.text = @""; // 将textView内容清空
        [self textViewDidChange:textView]; //将textView的高度恢复默认
        [textView resignFirstResponder]; //取消第一响应
        
        //计算tableView的高度，根据userView是否显示
        CGFloat tableViewH = 0;
        if (_userViewIsHidden) {
            tableViewH = kScreenSizeHeight - 64 - 48;
        }else {
            tableViewH = kScreenSizeHeight - 64 - 48 - 60;
        }
        //根据tableView高度 改变tableView偏移量，
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint point = self.tableView.contentOffset;
            point.y = self.tableView.contentSize.height - tableViewH;
            self.tableView.contentOffset = point;
        }];
        return NO;
    }
    
    return YES;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //纯文本样式
    static NSString *cellId = @"cellId";
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TextCell" owner:self options:nil] lastObject];
    }
    
    TextModel *model = self.textDataArr[indexPath.row];
    
    [cell showDataWithIndexPath:indexPath model:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextModel *model = self.textDataArr[indexPath.row];
    
//    CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kScreenSizeWidth - 120 - 40, 1000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    //根据文字内容计算size
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize size = [model.content boundingRectWithSize:CGSizeMake(kScreenSizeWidth - 120 - 40, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    if (size.height + 32 < 60) { // 如果文字的高度不到60 设置为60
        return 60;
    }else {
        return size.height + 32;
    }
    
}

#pragma mark -- UIScrollerViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView && ![self.textView isFirstResponder]) {
      //  保存tableView 的偏移量
        _tableViewOffset = scrollView.contentOffset;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (scrollView == self.tableView) {
        
        CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
        if (translation.y>0) {
            
            NSLog(@"______向下滑动，显示View");
            [self showUserInfoView];
        }else if(translation.y<0){
            
            NSLog(@"______向上滑动，隐藏View");
            [self hiddenUserInfoView];
        }
        
        //滑动时，textView如果是第一响应者，取消
        if (self.textView.isFirstResponder) {
            [self.textView resignFirstResponder];
        }

    }

}

//隐藏用户信息View
- (void)hiddenUserInfoView {
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.userInfoView.frame;
        frame.origin.y = -64;
        self.userInfoView.frame = frame;
    }];
    
    //修改tableView的frame
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.origin.y = 0;
    tableViewFrame.size.height = kScreenSizeHeight - 40 -64;
    self.tableView.frame = tableViewFrame;
    
    _userViewIsHidden = YES;
}

//显示用户信息View
- (void)showUserInfoView {
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.userInfoView.frame;
        frame.origin.y = 0;
        self.userInfoView.frame = frame;
    }];
    
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.origin.y = 64;
    tableViewFrame.size.height = kScreenSizeHeight - 64 - 40 -64;
    self.tableView.frame = tableViewFrame;
    
    _userViewIsHidden = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
