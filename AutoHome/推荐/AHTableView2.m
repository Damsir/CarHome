//
//  AHTableView2.m
//  AutoHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHTableView2.h"
#import "ArticleTableViewCell.h"

@implementation AHTableView2

- (id)initWithFrame:(CGRect)frame andDifferentPage:(AHDIFFERENTPage)page
{
    if(self = [super initWithFrame:frame])
    {
        self.loadData = [LoadNetData new];
        self.loadData.differentPage = page;
        [self initSelf];
        [self createWindow];
    }
    return self;
}

- (void)initSelf
{
    listArray = [NSArray new];
}

- (void)createWindow
{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.table addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.table addFooterWithTarget:self action:@selector(footerLoadMore)];
    [self addSubview:self.table];
    [self tableRegister];
    [self loadHomePageData];
}

- (void)tableRegister
{
    UINib * nib = [UINib nibWithNibName:@"ArticleTableViewCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"ArticleTableViewCell"];
}

//刷新
- (void)headerRefresh
{
    [self loadHomePageData];
}

//加载更多
- (void)footerLoadMore
{
    [self show];
    __weak typeof(*&self)weakSelf = self;
    [self.loadData loadMoreCarInfor:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [weakSelf.table footerEndRefreshing];
            listArray = weakSelf.loadData.dataDict[@"list"];
            [weakSelf.table reloadData];
            [weakSelf hide];
        }
    } withJsonUrl:@"result"];
}

- (void)loadHomePageData
{
    [self show];
    __weak typeof(*&self)weakSelf = self;
    [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [weakSelf.table headerEndRefreshing];
            listArray = weakSelf.loadData.dataDict[@"list"];
            [weakSelf.table reloadData];
            [weakSelf hide];
        }
    } withJsonUrl:@"result"];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleTableViewCell"];
    NSDictionary * dict = listArray[indexPath.row];
    [cell setUIWithDict:dict];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:dict[@"smallimg"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate pushWebViewControllerWithDict:listArray[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}

@end





















