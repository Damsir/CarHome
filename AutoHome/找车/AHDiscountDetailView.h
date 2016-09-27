//
//  AHDiscountDetailView.h
//  AutoHome
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadNetData.h"
#import "AHBaseView.h"

@interface AHDiscountDetailView : AHBaseView

@property(strong,nonatomic) LoadNetData * loadData;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *lastPrice;
@property (weak, nonatomic) IBOutlet UILabel *forePrice;
@property (weak, nonatomic) IBOutlet UILabel *decreasePrice;
@property (weak, nonatomic) IBOutlet UILabel *region;
@property (weak, nonatomic) IBOutlet UILabel *ordersCount;
@property (weak, nonatomic) IBOutlet UILabel *saleTime;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *map;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@property(copy,nonatomic) void (^block)(NSDictionary * dict);

- (void)createWindowWithDict:(NSDictionary *)dict;

@property(strong,nonatomic) NSDictionary * dictForMap;

@property(copy,nonatomic) void (^CheckMoreInfo)(BOOL isSelected);

@end
