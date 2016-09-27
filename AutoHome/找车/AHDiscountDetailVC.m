//
//  AHDiscountDetailVC.m
//  AutoHome
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHDiscountDetailVC.h"
#import "AHDiscountDetailView.h"
#import "AHDiscountDetailCell.h"
#import "WebViewVC.h"

@interface AHDiscountDetailVC ()<UITableViewDataSource,UITableViewDelegate,AHBaseView>

@property (nonatomic, strong) NSArray * listArray;

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong) AHDiscountDetailView * discountDetailView;

@end

@implementation AHDiscountDetailVC

- (id)init
{
    if(self = [super init])
    {
        self.urlDict = [NSDictionary new];
        self.listArray = [NSArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNavigation];
    [self createHeaderView];
    [self createBottomBtn];
    [self tableregister];
    
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
    titleLab.text = @"降价详情";
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.topBtnView addSubview:titleLab];
}

- (void)pressBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createHeaderView
{
    self.discountDetailView = [[[NSBundle mainBundle] loadNibNamed:@"AHDiscountDetail" owner:nil options:nil] firstObject];
    self.discountDetailView.delegate = self;
    self.discountDetailView.frame = CGRectMake(0, 0, SCREEN_W, 495);
    [self.discountDetailView createWindowWithDict:self.urlDict];
    
    __weak typeof (*&self)weakSelf = self;
    self.discountDetailView.block = ^(NSDictionary * dict)
    {
        weakSelf.listArray = [NSArray arrayWithArray:dict[@"list"]];
        [weakSelf.table reloadData];
    };
    
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.bounces = NO;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.table.tableHeaderView = self.discountDetailView;
}

- (void)tableregister
{
    UINib * nib = [UINib nibWithNibName:@"AHDiscountDetailCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"AHDiscountDetailCell"];
}

- (void)createBottomBtn
{
    NSArray * titleArray = @[@"购车计算",@"立即拨打",@"讯最低价"];
    for(int i=0; i<3; i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(SCREEN_W-20)/3.0+(i+1)*5, SCREEN_H-35, (SCREEN_W-20)/3.0, 30);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        button.layer.cornerRadius = 5;
        if(i == 0)
        {
            button.backgroundColor = [UIColor colorWithRed:252.0/255.0 green:131.0/255.0 blue:10.0/255.0 alpha:1.0];
        }
        else if(i == 1)
        {
            button.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:169.0/255.0 blue:88.0/255.0 alpha:1.0];
        }
        else
        {
            button.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:105.0/255.0 blue:198.0/255.0 alpha:1.0];
        }
        [self.view addSubview:button];
    }
}

#pragma mark - BaseViewDelegate
- (void)pushViewController:(UIViewController *)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AHDiscountDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHDiscountDetailCell"];
    NSDictionary * dict = self.listArray[indexPath.row];
    [cell setUIWithDict:dict];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = self.listArray[indexPath.row];
    WebViewVC * webView = [[WebViewVC alloc] init];
    webView.URL = [NSString stringWithFormat:@"%@%@/",DISCOUNTDETAILURL,dict[@"specid"]];
    webView.itemType = 200;
    webView.isCreateTabBar = YES;
    webView.navigationType = @"findCarDetail";
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.webTitle.text = @"车型报价";
    [webView.mapLatitudeArray addObject:[self.urlDict[@"dealer"] objectForKey:@"lat"]];
    [webView.mapLongtitudeArray addObject:[self.urlDict[@"dealer"] objectForKey:@"lon"]];
    [webView.mapAnnotationTitleArray addObject:[self.urlDict[@"dealer"] objectForKey:@"shortname"]];
    [webView.mapAnnotationSubTitleArray addObject:[self.urlDict[@"dealer"] objectForKey:@"specprice"]];
    [self.navigationController pushViewController:webView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 15)];
    header.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:242.0/239.0 alpha:1.0];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    self.tabBarController.tabBar.hidden = NO;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
