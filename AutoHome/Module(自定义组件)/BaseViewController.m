//
//  BaseViewController.m
//  AutoHome
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)init
{
    if(self = [super init])
    {
        self.loadData = [[LoadNetData alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.topBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_W, 40)];
    self.topBtnView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];
    [self.view addSubview:self.topBtnView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, 100, self.topBtnView.frame.size.height);
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:@"bar_btn_icon_returntext"] forState:UIControlStateNormal];
    self.backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [self.backBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(pressBackBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W/2.0-50, 0, 100, self.topBtnView.frame.size.height)];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(SCREEN_W-40, 3, 40, 37);
//    [self.searchBtn setImage:[UIImage imageNamed:@"bar_btn_icon_search"] forState:UIControlStateNormal];
    [self.topBtnView addSubview:self.searchBtn];

}

- (void)pressBackBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

//显示加载提示框
- (void)show
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

//移除加载提示框
- (void)hide
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)headerRefresh
{
    
}

- (void)footerLoadMore
{
    
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
