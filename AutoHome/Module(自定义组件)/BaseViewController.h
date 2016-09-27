//
//  BaseViewController.h
//  AutoHome
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "LoadNetData.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController

@property(strong,nonatomic) UIView * topBtnView;

@property(strong,nonatomic) UIButton * searchBtn;

@property(strong,nonatomic) UIButton * backBtn;

@property(strong,nonatomic) UILabel * titleLab;

@property(strong,nonatomic) LoadNetData * loadData;

//下拉刷新
- (void)headerRefresh;
//上拉加载更多
- (void)footerLoadMore;

//提示框的加载和隐藏
- (void)show;

- (void)hide;

@end










