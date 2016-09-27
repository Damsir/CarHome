//
//  AFDiscoverGroupPurchesVC.m
//  AutoHome
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AFDiscoverGroupPurchesVC.h"
#import "AHDiscoverGroupPurchesCell.h"
#import "WebViewVC.h"

@interface AFDiscoverGroupPurchesVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * activityListArray;
}

@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation AFDiscoverGroupPurchesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNavigation];
    [self initSelf];
    [self tableRegister];
    [self loadNetData];
    
}

- (void)createNavigation
{
    [self.searchBtn removeFromSuperview];
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 0, 50, 40);
    [backBtn setTitle:@"＜返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [backBtn addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
    [self.topBtnView addSubview:backBtn];
    
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W/2.0-50, 0, 100, 40)];
    titleLab.text = @"活动/团购";
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.topBtnView addSubview:titleLab];
}

- (void)pressBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)initSelf
{
    self.cityLab.text = @"武汉";
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.table addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.table addFooterWithTarget:self action:@selector(footerLoadMore)];
    self.loadData = [LoadNetData new];
    activityListArray = [NSMutableArray new];
}

- (void)tableRegister
{
    UINib * nib = [UINib nibWithNibName:@"AHDiscoverGroupPurchesCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"AHDiscoverGroupPurchesCell"];
}

//刷新
- (void)headerRefresh
{
    [self loadNetData];
}

//加载更多
- (void)footerLoadMore
{
    [self show];
    self.loadData.differentPage = AHDISCOVERGROUPPURCHES;
    __weak typeof(*&self)weakSelf = self;
    [self.loadData loadMoreCarInfor:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [weakSelf.table footerEndRefreshing];
            [activityListArray addObjectsFromArray:self.loadData.dataDict[@"activitylist"]];
            [weakSelf.table reloadData];
            [weakSelf hide];
        }
    } withJsonUrl:@"result"];
}

- (void)loadNetData
{
    [self show];
    self.loadData.differentPage = AHDISCOVERGROUPPURCHES;
    __weak typeof(*&self)weakSelf = self;
    [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [weakSelf.table headerEndRefreshing];
            activityListArray = [NSMutableArray arrayWithArray:self.loadData.dataDict[@"activitylist"]];
            [weakSelf.table reloadData];
            [weakSelf hide];
        }
    } withJsonUrl:@"result"];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return activityListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AHDiscoverGroupPurchesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHDiscoverGroupPurchesCell"];
    NSDictionary * dict = activityListArray[indexPath.row];
    [cell setUIWithDict:dict];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = activityListArray[indexPath.row];
    WebViewVC * webView = [[WebViewVC alloc] init];
    webView.itemType = 200;
    webView.URL = dict[@"url"];
    webView.isCreateTabBar = NO;
    webView.navigationType = @"recommend";
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    header.backgroundColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1.0];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, SCREEN_W, 30)];
    label.text = @"其他活动";
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:13.0];
    [header addSubview:label];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
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
