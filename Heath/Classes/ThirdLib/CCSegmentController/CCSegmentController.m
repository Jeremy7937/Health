//
//  SegmentController.m
//  SegmentController
//  UR: http://www.xiongcaichang.com
//  Created by bear on 16/4/15.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "CCSegmentController.h"
#import "CCPagerItem.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SELECTED_COLOR [UIColor redColor]

#define kButtonItemW (CGFloat)(SCREEN_WIDTH - 80 - 2*kItemSpace)/_titleArr.count
#define kItemSpace 10
#define KTitleH 64

static NSString *ID=@"pager";

@interface CCSegmentController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIView *titleWrap;

@property (nonatomic, assign) CGFloat titleHeight;

@property (nonatomic, strong) NSMutableArray *itemArr;

@property (nonatomic, weak) UIView *sliderView;


@property (nonatomic, assign) NSInteger oldSelectedIndex;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UICollectionView *pagerContainer;


@end

@implementation CCSegmentController

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;

    [self initTitleWrap];

}

-(void)setControllerArr:(NSArray *)controllerArr{
    _controllerArr=controllerArr;
    
     [self initPagerContainer];
}

//- (void)setBadgeValue:(NSString *)badgeValue {
//    _badgeValue = badgeValue;
//}

-(void)initTitleWrap{
    //CGFloat space = 20;
    CGFloat itemW = kButtonItemW;
    //标题容器
    UIView *titleWrap = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KTitleH)];
    titleWrap.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:titleWrap];
    _titleWrap = titleWrap;

    _itemArr = [NSMutableArray array];
    for (int i = 0; i < self.titleArr.count; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [itemButton setTitle:_titleArr[i] forState:UIControlStateNormal];
//        [itemButton setTitleColor:SELECTED_COLOR forState:UIControlStateSelected];
        [itemButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
       // itemButton.backgroundColor = [UIColor yellowColor];
        itemButton.frame = CGRectMake(i*(kItemSpace+itemW) + 40, 24, itemW, 40);
        itemButton.tag = i;
        [itemButton addTarget:self action:@selector(scrollToSelectedIndex:) forControlEvents:UIControlEventTouchUpInside];
        [titleWrap addSubview:itemButton];
        
        if ((i == 0)&& (_badgeValue.length != 0)) {
            //itemButton.backgroundColor = [UIColor yellowColor];
            UILabel *label = [self setBadgeViewWithFrame:CGRectMake(kButtonItemW - 23, 5, 20, 15) title:self.badgeValue];
            [itemButton addSubview:label];
        }

        [_itemArr addObject:itemButton];
    }

    //添加滑块
    UIView *sliderV=[[UIView alloc]initWithFrame:CGRectMake(50, KTitleH-2, itemW, 2)];
    sliderV.backgroundColor=SELECTED_COLOR;
    [self.titleWrap addSubview:sliderV];
    _sliderView=sliderV;

    [self scrollToSelectedIndex:self.itemArr[0]];
}

- (UILabel *)setBadgeViewWithFrame:(CGRect)frame title:(NSString *)number{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    //[label sizeToFit];
    label.text = number;
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = frame.size.height/2;
    label.font = [UIFont systemFontOfSize:12];
    [label sizeToFit];
    if(label.bounds.size.width < 15) {
        CGRect frame = label.frame;
        frame.size.width = 15;
        label.frame = frame;
    }
    return label;
}



-(void)initPagerContainer{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;


    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KTitleH, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    _pagerContainer = collectionView;
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    collectionView.backgroundColor=[UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator=NO;
    [collectionView registerClass:[CCPagerItem class] forCellWithReuseIdentifier:ID];
    
    
}


-(void)scrollToSelectedIndex:(UIButton *) item{


    [self selectButton:item.tag];

    //滚动到选中页面
    [UIView animateWithDuration:0.3 animations:^{
        self.pagerContainer.contentOffset = CGPointMake(SCREEN_WIDTH*item.tag, 0);

    }];

    //保存选中索引
    self.oldSelectedIndex = item.tag;

}


//监听滚动事件判断当前拖动到哪一个了
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

   NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self selectButton:index];

}


//选中按钮的处理
-(void)selectButton:(NSInteger )index{
    //取消选中上一个
    [self.itemArr[self.oldSelectedIndex] setSelected:NO];
    //选中当前
    [self.itemArr[index] setSelected:YES];

    CGFloat itemW = kButtonItemW;


    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.sliderView.frame=CGRectMake(index*(kItemSpace+itemW) + 40, KTitleH-2, itemW, 2);
        [[self.itemArr[_oldSelectedIndex] titleLabel] setFont:[UIFont boldSystemFontOfSize:17]];
        [[self.itemArr[index] titleLabel] setFont:[UIFont boldSystemFontOfSize:17]];
    } completion:^(BOOL finished) {

    }];
    
    //记录当前选中
    self.oldSelectedIndex = index;




}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.controllerArr.count;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

     CCPagerItem  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    UITableViewController *tableVc = self.controllerArr[indexPath.item];


    //判断是否有导航栏来确定内容的高度
    if (self.navigationController.navigationBar) {

        tableVc.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-KTitleH);
    }else{
        tableVc.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KTitleH);
    }
    cell.content = tableVc.view;

    return cell;

}




@end