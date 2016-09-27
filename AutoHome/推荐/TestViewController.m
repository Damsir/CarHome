//
//  TestViewController.m
//  AutoHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TestViewController.h"
#import "AHTableView.h"
#import "AHTableView2.h"
#import "AHTableView3.h"
#import "AHTableView4.h"

@interface TestViewController ()<UIScrollViewDelegate>
{
    NSArray * topBtnTitleArray;
    NSInteger selectedTopBtnIndex;
    UIScrollView * topBtnScroll;
    UIScrollView *mainScroll;
    
    AHTableView * pageView1;
    AHTableView2 * pageView2;
    AHTableView3 * pageView3;
    AHTableView4 * pageView4;
    
}
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSelf];
    [self createMainWidow];
}

- (void)initSelf
{
    topBtnTitleArray = [[NSArray alloc] init];
    selectedTopBtnIndex = 0;
}

- (void)createMainWidow
{
    topBtnScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-40, 40)];
    topBtnScroll.bounces = NO;
    topBtnScroll.showsHorizontalScrollIndicator = NO;
    topBtnScroll.showsVerticalScrollIndicator = NO;
    topBtnScroll.contentSize = CGSizeMake(14*60, topBtnScroll.frame.size.height);
    [self.topBtnView addSubview:topBtnScroll];
    
    mainScroll = [[UIScrollView alloc] init];
    mainScroll.frame = CGRectMake(0, CGRectGetMaxY(self.topBtnView.frame), SCREEN_W, self.view.frame.size.height-self.topBtnView.frame.size.height-70);
    
    mainScroll.contentSize = CGSizeMake(14*SCREEN_W, mainScroll.frame.size.height);
    mainScroll.bounces = NO;
    mainScroll.showsHorizontalScrollIndicator = NO;
    mainScroll.showsVerticalScrollIndicator = NO;
    mainScroll.pagingEnabled = YES;
    mainScroll.alwaysBounceVertical = NO;
    mainScroll.delegate = self;
    [self.view addSubview:mainScroll];
    
    pageView1 = [[AHTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND1];
    [mainScroll addSubview:pageView1];
    
}

#pragma ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == mainScroll)
    {
        NSInteger index = mainScroll.contentOffset.x/SCREEN_W;
        switch (index) {
            case 0:
                pageView1 = [[AHTableView alloc] initWithFrame:CGRectMake(0, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND1];
                [mainScroll addSubview:pageView1];
                break;
            case 1:
                pageView3 = [[AHTableView3 alloc] initWithFrame:CGRectMake(SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND2];
                [mainScroll addSubview:pageView3];
                break;
            case 2:
                pageView2 = [[AHTableView2 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND3];
                [mainScroll addSubview:pageView2];
                break;
            case 3:
                pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND4];
                [mainScroll addSubview:pageView4];
                break;
            case 4:
                pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND5];
                [mainScroll addSubview:pageView4];
                break;
            case 5:
                pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND6];
                [mainScroll addSubview:pageView4];
                break;
            case 6:
                pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND7];
                [mainScroll addSubview:pageView4];
                break;
            case 7:
                pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND8];
                [mainScroll addSubview:pageView4];
                break;
            case 8:
                pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND9];
                [mainScroll addSubview:pageView4];
                break;
            case 9:
                pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND10];
                [mainScroll addSubview:pageView4];
                break;
            case 10:
                pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND11];
                [mainScroll addSubview:pageView4];
                break;
            case 11:
                pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND12];
                [mainScroll addSubview:pageView4];
                break;
            case 12:
                pageView2 = [[AHTableView2 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND13];
                [mainScroll addSubview:pageView2];
                break;
            case 13:
                pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND14];
                [mainScroll addSubview:pageView4];
                break;
            default:
                break;
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
