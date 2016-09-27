//
//  AHFindCarView3.h
//  AutoHome
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadNetData.h"
#import "AHBaseView.h"

@protocol AHFindCarView3 <NSObject>

- (void)pushDiscountViewControllerWIthDict:(NSDictionary *)dict;

@end

@interface AHFindCarView3 : AHBaseView<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UIView * headerView;
    NSArray * carListArray;
    
    NSDictionary * telDict;
}

@property(strong,nonatomic) UITableView * table;

@property(strong,nonatomic) LoadNetData * loadData;

@property(assign,nonatomic) id<AHFindCarView3> ownDelegate;

@end
