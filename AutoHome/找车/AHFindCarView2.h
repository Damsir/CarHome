//
//  AHFindCarView2.h
//  AutoHome
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWLCustomSliderNew.h"
#import "LoadNetData.h"
#import "AHBaseView.h"

@interface AHFindCarView2 : AHBaseView<UITableViewDataSource,UITableViewDelegate,GWLCustomSliderNewDelegate>
{
    NSInteger flag;
    
    BOOL isDone;
    BOOL isClear;
    
    UIView * headerView;
    UIView * siftView;
    NSMutableArray * siftTablesArray;
    NSMutableArray * brandListArray;
    UILabel * siftTitleLab;
    NSArray * allTitleArray;
    NSMutableArray * allSubTitleArray;
    NSMutableArray * selectedItemsArray;
    
    NSMutableArray * allIndexPathArray;
    
    UIButton * BottomBtn;
    
    NSArray * dataArray;
        
    NSString * minMoney;
    NSString * maxMoney;
    
    NSArray * suoYinArray;
}

@property(strong,nonatomic) LoadNetData * loadData;
@property(strong,nonatomic) UITableView * table;
@property(nonatomic, weak) GWLCustomSliderNew *customSlider;
@property(nonatomic,strong)UILabel *sliderValueLabel;

@end
