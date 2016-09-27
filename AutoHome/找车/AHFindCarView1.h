//
//  AHFindCarView1.h
//  AutoHome
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadNetData.h"
#import "AHBaseView.h"

@interface AHFindCarView1 : AHBaseView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIScrollView * adScroll;
    UIView * middleBtnView1;
    UIView * middleBtnView2;
    UIView * middleBtnView3;
    UIView * headerView;
    
    NSArray * brandListArray;
    NSArray * focusListArray;
    NSDictionary * hotBrandDict;
    NSArray * hotSeriesArray;
    
    UIView * allTypeView;
    UITableView * allTypeTable;
    NSArray * fctlistArray;
    
    UISegmentedControl * segment;
    NSDictionary * flagBrandDict;
    NSDictionary * flagHotDict;
    BOOL flag;
    
    UIPageControl * pageController;
    NSArray * suoYinArray;
}

@property(strong,nonatomic) UITableView * table;

@property(strong,nonatomic) LoadNetData * loadData;

@end
