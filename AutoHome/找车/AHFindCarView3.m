//
//  AHFindCarView3.m
//  AutoHome
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHFindCarView3.h"
#import "AHDisountCell.h"

@implementation AHFindCarView3

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self createWindow];
    }
    return self;
}

- (void)createWindow
{
    [self initSelf];
    
    UILabel * topLineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 20)];
    topLineLab.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1.0];
    [self addSubview:topLineLab];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topLineLab.frame), SCREEN_W, self.frame.size.height) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.table addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.table addFooterWithTarget:self action:@selector(footerLoadMore)];
    [self addSubview:self.table];
    UINib * nib = [UINib nibWithNibName:@"AHDisountCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"AHDisountCell"];
    [self loadNetData];
}

- (void)initSelf
{
    self.loadData = [LoadNetData new];
    self.table = [UITableView new];
    carListArray = [NSArray new];
    telDict = [NSDictionary new];
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
    self.loadData.differentPage = AHDISCOUNT;
    __weak typeof(*&self)weakSelf = self;
    [self.loadData loadMoreCarInfor:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [weakSelf.table footerEndRefreshing];
            carListArray = self.loadData.dataDict[@"carlist"];
            [weakSelf.table reloadData];
            [weakSelf hide];
        }
    } withJsonUrl:@"result"];
}

- (void)loadNetData
{
    [self show];
    self.loadData.differentPage = AHDISCOUNT;
    __weak typeof(*&self)weakSelf = self;
    [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [weakSelf.table headerEndRefreshing];
            carListArray = self.loadData.dataDict[@"carlist"];
            [weakSelf.table reloadData];
            [weakSelf hide];
        }
    } withJsonUrl:@"result"];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return carListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = carListArray[indexPath.row];
    AHDisountCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHDisountCell"];
    [cell setUIWithDict:dict];
    cell.phoneCallBtn.tag = 4000+indexPath.row;
    [cell.phoneCallBtn addTarget:self action:@selector(makePhoneCall:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)makePhoneCall:(UIButton *)btn
{
    telDict = carListArray[btn.tag-4000];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"热线电话" message:[telDict[@"dealer"] objectForKey:@"phone"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = carListArray[indexPath.row];
    [self.ownDelegate pushDiscountViewControllerWIthDict:dict];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170.0;
}

#pragma AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        NSLog(@"取消");
    }
    else
    {
        NSString * phoneNum = [NSString stringWithFormat:@"telprompt://%@",[telDict[@"dealer"] objectForKey:@"phone"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]];
    }
}

@end
























