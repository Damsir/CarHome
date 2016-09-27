//
//  AHMapVC.h
//  AutoHome
//
//  Created by qianfeng on 15/10/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"


@interface AHMapVC : BaseViewController

@property(assign,nonatomic) double longtitude;

@property(assign,nonatomic) double latitude;

@property(strong,nonatomic) NSString * annotationTitle;

@property(strong,nonatomic) NSMutableArray * latitudeArray;

@property(strong,nonatomic) NSMutableArray * longtitudeArray;

@property(strong,nonatomic) NSMutableArray * annotationTitleArray;

@property(strong,nonatomic) NSMutableArray * annotationSubTitleArray;

@end
