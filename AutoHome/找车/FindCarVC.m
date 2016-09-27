//
//  FindCarVC.m
//  AutoHome
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#import "FindCarVC.h"
#import "AHFindCarView1.h"
#import "AHFindCarView2.h"
#import "AHFindCarView3.h"
#import "AHDiscountDetailVC.h"
#import "AHFindCarResultVC.h"

@interface FindCarVC ()<UIScrollViewDelegate,AHBaseView,AHFindCarView3>
{
    UIScrollView * backScroll;
    NSInteger selectedTopBtnIndex;
    NSMutableArray * topBtnArray;
    UILabel * topBtnLine;
    NSInteger lastContentOffset;
}

@property(nonatomic,strong)AHFindCarView1 * findCarView1;
@property(nonatomic,strong)AHFindCarView2 * findCarView2;
@property(nonatomic,strong)AHFindCarView3 * findCarView3;

@end

@implementation FindCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.searchBtn removeFromSuperview];
    topBtnArray = [[NSMutableArray alloc] init];
    selectedTopBtnIndex = 0;
    lastContentOffset = 0;

    [self createMainWindow];
    [self createtableViews];
    
}

- (void)createMainWindow
{
    NSArray * topBtnTitleArray = @[@"品牌",@"筛选",@"降价"];
    for(int i=0; i<3; i++)
    {
        UIButton * topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn.frame = CGRectMake(i*70, 3, 70, 37);
        [topBtn setTitle:topBtnTitleArray[i] forState:UIControlStateNormal];
        if(i == 0)
        {
            [topBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            topBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        }
        else
        {
            [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            topBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        }
        [topBtn addTarget:self action:@selector(pressTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        topBtn.tag = 3000+i;
        [topBtnArray addObject:topBtn];
        [self.topBtnView addSubview:topBtn];
    }
    topBtnLine = [[UILabel alloc] initWithFrame:CGRectMake(12, 38, 40, 2)];
    topBtnLine.backgroundColor = MAINCOLOR;
    [self.topBtnView addSubview:topBtnLine];
    
    backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBtnView.frame), SCREEN_W, SCREEN_H-self.topBtnView.frame.size.height-70)];
    backScroll.showsHorizontalScrollIndicator = NO;
    backScroll.showsVerticalScrollIndicator = NO;
    backScroll.bounces = NO;
    backScroll.pagingEnabled = YES;
    backScroll.delegate = self;
    backScroll.contentSize = CGSizeMake(3*SCREEN_W, backScroll.frame.size.height);
    [self.view addSubview:backScroll];
}

- (void)pressTopBtn:(UIButton *)btn
{
    backScroll.contentOffset = CGPointMake((btn.tag-3000)*SCREEN_W, 0);
    [self scrollViewDidEndDecelerating:backScroll];
    if(selectedTopBtnIndex != 0)
    {
        UIButton * oldButton = (UIButton *)[self.topBtnView viewWithTag:selectedTopBtnIndex];
        [oldButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        oldButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    [btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    //记住上一次点击按钮的tag
    selectedTopBtnIndex = btn.tag;
}

- (void)createtableViews
{
    self.findCarView1 = [[AHFindCarView1 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, backScroll.frame.size.height)];
    self.findCarView1.delegate = self;
    [backScroll addSubview:self.findCarView1];
    
    self.findCarView2 = [[AHFindCarView2 alloc] initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, backScroll.frame.size.height)];
    self.findCarView2.delegate = self;
    [backScroll addSubview:self.findCarView2];
    
    self.findCarView3 = [[AHFindCarView3 alloc] initWithFrame:CGRectMake(2*SCREEN_W, 0, SCREEN_W, backScroll.frame.size.height)];
    self.findCarView3.ownDelegate = self;
    [backScroll addSubview:self.findCarView3];
    
}

#pragma mark - AHBaseViewDelegate
- (void)pushViewController:(UIViewController *)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)stopScroll
{
    backScroll.scrollEnabled = NO;
}

- (void)starScroll
{
    backScroll.scrollEnabled = YES;
}

- (void)pushViewControllerWithURL:(NSString *)URL
{
    AHFindCarResultVC * findCarResultVC = [[AHFindCarResultVC alloc] init];
    findCarResultVC.hidesBottomBarWhenPushed = YES;
    findCarResultVC.loadData.URL = URL;
    findCarResultVC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:findCarResultVC animated:YES];
}

#pragma mark - AHFindCarView3Delegate
- (void)pushDiscountViewControllerWIthDict:(NSDictionary *)dict
{
    AHDiscountDetailVC * discountDetailVC = [[AHDiscountDetailVC alloc] init];
    discountDetailVC.hidesBottomBarWhenPushed = YES;
    discountDetailVC.urlDict = dict;
    
    discountDetailVC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:discountDetailVC animated:YES];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == backScroll)
    {
        NSInteger index = backScroll.contentOffset.x/SCREEN_W;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            topBtnLine.frame = CGRectMake(index*70+14, topBtnLine.frame.origin.y, topBtnLine.frame.size.width, topBtnLine.frame.size.height);
        } completion:^(BOOL finished){
            
        }];
        for(int i=0; i<3; i++)
        {
            UIButton * button = topBtnArray[i];
            if(i == index)
            {
                [button setTitleColor:MAINCOLOR forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:17.0];
            }
            else
            {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:16.0];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
