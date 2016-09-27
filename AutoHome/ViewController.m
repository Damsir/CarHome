//
//  ViewController.m
//  AutoHome
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "WebViewVC.h"
#import "AHTableView.h"
#import "AHTableView2.h"
#import "AHTableView3.h"
#import "AHTableView4.h"
#import "AHTableView5.h"

@interface ViewController ()<UIScrollViewDelegate,AHBaseView>
{
    AHTableView * pageView1;
    AHTableView2 * pageView2;
    AHTableView3 * pageView3;
    AHTableView4 * pageView4;
    AHTableView5 * pageView5;
    
    NSInteger flag;
    
    NSArray * topBtnTitleArray;
    
    NSInteger selectedTopBtnIndex;
    UIScrollView * topBtnScroll;
    NSMutableArray * topBtnArray;
    UIScrollView *mainScroll;
    
    NSInteger lastContentOffset;
    UILabel * topBtnLine;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    TestViewController * vc = [[TestViewController alloc] init];
//    vc.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    UIDevice * device = [UIDevice currentDevice];
//    NSLog(@"设备名:%@",device.name);
//    NSLog(@"设备类型:%@",device.model);
//    NSLog(@"UUID:%@",device.identifierForVendor);
//    NSLog(@"系统版本:%@",device.systemVersion);
//    NSLog(@"系统名:%@",device.systemName);
//    [self.searchBtn removeFromSuperview];
    
    [self initSelf];
    [self createMainWidow];

}
- (void)initSelf
{
    topBtnTitleArray = [NSArray new];
    topBtnArray = [NSMutableArray new];
    selectedTopBtnIndex = 0;
    lastContentOffset = 0;
}

- (void)createMainWidow
{
    topBtnScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    topBtnScroll.bounces = NO;
    topBtnScroll.showsHorizontalScrollIndicator = NO;
    topBtnScroll.showsVerticalScrollIndicator = NO;
    topBtnScroll.contentSize = CGSizeMake(14*70, topBtnScroll.frame.size.height);
    [self.topBtnView addSubview:topBtnScroll];
    
    topBtnLine = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(topBtnScroll.frame)-3, 40, 2)];
    topBtnLine.backgroundColor = MAINCOLOR;
    [topBtnScroll addSubview:topBtnLine];
    
    topBtnTitleArray = @[@"最新",@"快报",@"视频",@"新闻",@"评测",@"导购",@"行情",@"用车",@"技术",@"文化",@"改装",@"游记",@"原创视频",@"说客"];
    for(int i=0; i<14; i++)
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
        [topBtnScroll addSubview:topBtn];
    }
    
    mainScroll = [[UIScrollView alloc] init];
    mainScroll.frame = CGRectMake(0, CGRectGetMaxY(self.topBtnView.frame), SCREEN_W, SCREEN_H-self.topBtnView.frame.size.height-70);
    mainScroll.contentSize = CGSizeMake(14*SCREEN_W, mainScroll.frame.size.height);
    mainScroll.bounces = NO;
    mainScroll.showsHorizontalScrollIndicator = NO;
    mainScroll.showsVerticalScrollIndicator = NO;
    mainScroll.pagingEnabled = YES;
    mainScroll.alwaysBounceVertical = NO;
    mainScroll.delegate = self;
    [self.view addSubview:mainScroll];
        
    pageView1 = [[AHTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND1];
    pageView1.delegate = self;
    [mainScroll addSubview:pageView1];
}

- (void)pressTopBtn:(UIButton *)btn
{
    mainScroll.contentOffset = CGPointMake((btn.tag-3000)*SCREEN_W, 0);
    [self scrollViewDidEndDecelerating:mainScroll];
    if(selectedTopBtnIndex != 0)
    {
        UIButton * oldButton = (UIButton *)[topBtnScroll viewWithTag:selectedTopBtnIndex];
        [oldButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        oldButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    [btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    //记住上一次点击按钮的tag
    selectedTopBtnIndex = btn.tag;
}

#pragma BaseViewDelegate
-(void)pushWebViewControllerWithDict:(NSDictionary *)dict
{
    WebViewVC * webView = [[WebViewVC alloc] init];
    webView.itemID = dict[@"id"];
    webView.isCreateTabBar = NO;
    webView.navigationType = @"recommend";
    webView.itemType = flag;
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)pushViewController:(UIViewController *)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == mainScroll)
    {
        if(lastContentOffset != scrollView.contentOffset.x)
        {
            lastContentOffset = scrollView.contentOffset.x;
            NSInteger index = mainScroll.contentOffset.x/SCREEN_W;
            if(index >3)
            {
                topBtnScroll.contentOffset = CGPointMake(index*50, 0);
            }
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                topBtnLine.frame = CGRectMake(index*70+14, topBtnLine.frame.origin.y, topBtnLine.frame.size.width, topBtnLine.frame.size.height);
            } completion:^(BOOL finished){
                
            }];
            
            for(int i=0; i<14; i++)
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
            switch (index) {
                case 0:
                    [pageView1 removeFromSuperview];
                    pageView1 = [[AHTableView alloc] initWithFrame:CGRectMake(0, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND1];
                    pageView1.delegate = self;
                    flag = 0;
                    [mainScroll addSubview:pageView1];
                    break;
                case 1:
                    [pageView3 removeFromSuperview];
                    pageView3 = [[AHTableView3 alloc] initWithFrame:CGRectMake(SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND2];
                    pageView3.delegate = self;
                    flag = 1;
                    [mainScroll addSubview:pageView3];
                    break;
                case 2:
                    [pageView2 removeFromSuperview];
                    pageView2 = [[AHTableView2 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND3];
                    pageView2.delegate = self;
                    flag = 2;
                    [mainScroll addSubview:pageView2];
                    break;
                case 3:
                    [pageView4 removeFromSuperview];
                    pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND4];
                    pageView4.delegate = self;
                    flag = 3;
                    [mainScroll addSubview:pageView4];
                    break;
                case 4:
                    [pageView4 removeFromSuperview];
                    pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND5];
                    pageView4.delegate = self;
                    flag = 4;
                    [mainScroll addSubview:pageView4];
                    break;
                case 5:
                    [pageView4 removeFromSuperview];
                    pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND6];
                    pageView4.delegate = self;
                    flag = 5;
                    [mainScroll addSubview:pageView4];
                    break;
                case 6:
                    [pageView4 removeFromSuperview];
                    pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND7];
                    pageView4.delegate = self;
                    flag = 6;
                    [mainScroll addSubview:pageView4];
                    break;
                case 7:
                    [pageView4 removeFromSuperview];
                    pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND8];
                    pageView4.delegate = self;
                    flag = 7;
                    [mainScroll addSubview:pageView4];
                    break;
                case 8:
                    [pageView4 removeFromSuperview];
                    pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND9];
                    pageView4.delegate = self;
                    flag = 8;
                    [mainScroll addSubview:pageView4];
                    break;
                case 9:
                    [pageView4 removeFromSuperview];
                    pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND10];
                    pageView4.delegate = self;
                    flag = 9;
                    [mainScroll addSubview:pageView4];
                    break;
                case 10:
                    [pageView4 removeFromSuperview];
                    pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND11];
                    pageView4.delegate = self;
                    flag = 10;
                    [mainScroll addSubview:pageView4];
                    break;
                case 11:
                    [pageView4 removeFromSuperview];
                    pageView4 = [[AHTableView4 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND12];
                    pageView4.delegate = self;
                    flag = 11;
                    [mainScroll addSubview:pageView4];
                    break;
                case 12:
                    [pageView2 removeFromSuperview];
                    pageView2 = [[AHTableView2 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND13];
                    pageView2.delegate = self;
                    flag = 12;
                    [mainScroll addSubview:pageView2];
                    break;
                case 13:
                    [pageView5 removeFromSuperview];
                    pageView5 = [[AHTableView5 alloc] initWithFrame:CGRectMake(index*SCREEN_W, 0, mainScroll.frame.size.width, mainScroll.frame.size.height) andDifferentPage:AHRECOMMEND14];
                    pageView5.delegate = self;
                    flag = 13;
                    [mainScroll addSubview:pageView5];
                    break;
                default:
                    break;
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end































