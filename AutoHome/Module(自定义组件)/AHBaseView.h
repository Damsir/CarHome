//
//  AHBaseView.h
//  AutoHome
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "LoadNetData.h"
#import "WebViewVC.h"

@protocol AHBaseView <NSObject>

@optional
- (void)stopScroll;

- (void)starScroll;

- (void)pushViewController:(UIViewController *)controller;

- (void)pushViewControllerWithDataArray:(NSArray *)dataArray;

- (void)pushViewControllerWithURL:(NSString *)URL;

- (void)pushWebViewControllerWithDict:(NSDictionary *)dict;

@end

@interface AHBaseView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(assign,nonatomic) id<AHBaseView> delegate;

@property(strong,nonatomic) LoadNetData * loadData;

@property(strong,nonatomic) UITableView * table;

//下拉刷新
- (void)headerRefresh;
//上拉加载更多
- (void)footerLoadMore;

//提示框的加载和隐藏
- (void)show;

- (void)hide;

@end
