//
//  AHBaseView.m
//  AutoHome
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHBaseView.h"

@implementation AHBaseView

//显示加载提示框
- (void)show
{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

//移除加载提示框
- (void)hide
{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}

- (void)headerRefresh
{
    
}

- (void)footerLoadMore
{
    
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}

@end
