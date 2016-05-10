//
//  GKPopView.m
//  Heath
//
//  Created by 郭凯 on 16/4/21.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "GKPopView.h"
#import "Define.h"
#import "CommonLanguageCell.h"

@interface GKPopView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArr;//网络获取数据
@property (nonatomic, strong)UIView *bgView;//弹出视图
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)NSMutableArray *resultStrArr;//选中的数据
@property (nonatomic, strong)UIView *leftBgView;//左侧弹出视图
@property (nonatomic, copy)NSString *resultStr; //拼接后的字符串结果

@end

@implementation GKPopView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hiddenPopView];
}

- (instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray *)dataArr {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        
        self.dataArr = dataArr;
        self.resultStrArr = [NSMutableArray array];
        [self setUpBaseUI];
    }
    return self;
}

- (void)setUpBaseUI {
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenSizeHeight, kScreenSizeWidth, kScreenSizeHeight - 100)];
    self.bgView.backgroundColor = kSetRGBColor(225, 225, 225);
    [self addSubview:self.bgView];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 5, kScreenSizeWidth-40, 30)];
    CGSize size = CGSizeMake(kScreenSizeWidth-60, 30);
    self.searchBar.backgroundImage = GJCFQuickImageByColorWithSize(kSetRGBColor(225, 225, 225), size);
    self.searchBar.placeholder = @"关键字搜索";
    [self.bgView addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, kScreenSizeWidth, kScreenSizeHeight - 100 - 40 - 50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
   // [self.tableView registerNib:[UINib nibWithNibName:@"CommonLanguageCell" bundle:nil] forCellReuseIdentifier:@"CellId"];
    [self.bgView addSubview:self.tableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, self.bgView.bounds.size.height - 45, kScreenSizeWidth - 40, 40);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor grayColor];
    [self.bgView addSubview:btn];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _bgView.frame;
        frame.origin.y -= frame.size.height;
        _bgView.frame = frame;
        
    }];
    
   // [self setUpLeftBaseUI];
    
}

- (void)setUpLeftBaseUI {
    self.leftBgView = [[UIView alloc] initWithFrame:CGRectMake(-kScreenSizeWidth, 100, kScreenSizeWidth, kScreenSizeHeight - 100)];
    self.leftBgView.backgroundColor = kSetRGBColor(225, 225, 225);
    [self addSubview:self.leftBgView];
    
    _resultStr = @"";
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, kScreenSizeWidth - 20, 200)];
    for (NSString *str in self.resultStrArr) {
        _resultStr = [_resultStr stringByAppendingString:str];
    }
    textView.text = _resultStr;
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = [UIColor blackColor];
    textView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [self.leftBgView addSubview:textView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(20, kScreenSizeHeight - 50 - 100, kScreenSizeWidth/2 - 25, 40);
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.cornerRadius = 5;
    [leftBtn addTarget: self action:@selector(leftViewCancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = [UIColor grayColor];
    [self.leftBgView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(kScreenSizeWidth/2 +5, kScreenSizeHeight - 50 - 100, kScreenSizeWidth/2 - 25, 40);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius = 5;
    [rightBtn addTarget: self action:@selector(leftViewSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = [UIColor grayColor];
    [self.leftBgView addSubview:rightBtn];
    
}

- (void)isHiddenLeftView:(BOOL)isHidden {
    if (isHidden) {
        self.leftBgView.hidden = YES;
        self.leftBgView.frame = CGRectMake(20, kScreenSizeHeight - 50 - 100, kScreenSizeWidth/2 - 25, 40);
    }else {
        self.leftBgView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.leftBgView.frame;
            frame.origin.x += frame.size.width;
            self.leftBgView.frame = frame;
        }];
        
    }
}

- (void)isHiddenBgView:(BOOL)isHidden {
    if(isHidden) {
        self.bgView .hidden = YES;
        self.bgView.frame = CGRectMake(0, kScreenSizeHeight, kScreenSizeWidth, kScreenSizeHeight - 100);
    }else {
        self.bgView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _bgView.frame;
            frame.origin.y -= frame.size.height;
            _bgView.frame = frame;
            
        }];
    }
}

#pragma mark -- leftBgViewBtnClick;
//leftView 取消按钮点击事件
- (void)leftViewCancleBtnClick:(UIButton *)btn {
    [self isHiddenLeftView:YES];
    [self isHiddenBgView:NO];
}
//leftView 确定按钮点击事件
- (void)leftViewSureBtnClick:(UIButton *)btn {
    NSLog(@"__________确认，传值");
    if (self.block) {
        self.block(_resultStr);
    }
    
    [self hiddenPopView];
}

#pragma mark -- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 定义唯一标识
    static NSString *CellIdentifier = @"Cell";
    // 通过唯一标识创建cell实例
    CommonLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommonLanguageCell" owner:self options:nil] lastObject];
    }
    else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    CommonLanguageModle *model = self.dataArr[indexPath.row];
    [cell showDataWithModel:model index:indexPath.row];
    cell.selectedBlock = ^(NSString *title,NSString *isAdd){
        
        if ([isAdd isEqualToString:@"1"]) {
            [self.resultStrArr addObject:title];
        }else {
            [self.resultStrArr removeObject:title];
        }
        
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    NSLog(@"选中%ld行",indexPath.row);
}

- (void)click:(UIButton *)btn {
    NSLog(@"_________确定");
    NSLog(@"___________%@",self.resultStrArr);
    [self setUpLeftBaseUI];
    
    [self isHiddenBgView:YES];
    [self isHiddenLeftView:NO];
}

- (void)hiddenPopView {
    
    for (CommonLanguageModle *model in self.dataArr) {
        
        if ([model.isClick isEqualToString:@"1"]) {
            model.isClick = @"0";
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _bgView.frame;
        frame.origin.y += frame.size.height;
        _bgView.frame = frame;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
@end
