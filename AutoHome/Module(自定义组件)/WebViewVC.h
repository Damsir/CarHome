//
//  WebViewVC.h
//  AutoHome
//
//  Created by qianfeng on 15/10/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WebViewVC : BaseViewController

@property(assign,nonatomic) BOOL isCreateTabBar;
@property(strong,nonatomic) NSString * navigationType;
@property(strong,nonatomic) UILabel * webTitle;

@property(strong,nonatomic) NSNumber * itemID;
@property(assign,nonatomic) NSInteger itemType;
@property(strong,nonatomic) NSNumber * bbsID;
@property(strong,nonatomic) NSString * bbstype;
@property(strong,nonatomic) NSString * URL;

@property(assign,nonatomic) double mapLontitude;
@property(assign,nonatomic) double mapLatitude;
@property(strong,nonatomic) NSString * mapAnnotationTitle;

@property(strong,nonatomic) NSMutableArray * mapLatitudeArray;
@property(strong,nonatomic) NSMutableArray * mapLongtitudeArray;
@property(strong,nonatomic) NSMutableArray * mapAnnotationTitleArray;
@property(strong,nonatomic) NSMutableArray * mapAnnotationSubTitleArray;

@end
