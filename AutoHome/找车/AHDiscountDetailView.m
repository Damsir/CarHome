//
//  AHDiscountDetailView.m
//  AutoHome
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHDiscountDetailView.h"
#import "UIImageView+WebCache.h"
#import "AHMapVC.h"

@implementation AHDiscountDetailView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.dictForMap = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)createWindowWithDict:(NSDictionary *)dict
{
    self.dictForMap = dict;
    self.loadData = [[LoadNetData alloc] init];
    self.loadData.URL = [NSString stringWithFormat:@"%@%@-n%@-t0-d%@-ss%@-uid0.json",DISCOUNTDETAIL,dict[@"specid"],dict[@"articleid"],[dict[@"dealer"] objectForKey:@"id"],dict[@"seriesid"]];
    [self.loadData loadCarInfo2:^(BOOL isSuccess, NSError *error) {

        [self.topImage sd_setImageWithURL:self.loadData.dataDict[@"specimg"] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        self.title.text = [NSString stringWithFormat:@"%@%@",self.loadData.dataDict[@"seriesname"],self.loadData.dataDict[@"specname"]];
        self.lastPrice.text = [NSString stringWithFormat:@"%@万",self.loadData.dataDict[@"specprice"]];
        self.forePrice.text = [NSString stringWithFormat:@"%@万",self.loadData.dataDict[@"factoryprice"]];
        float lastP = [self.loadData.dataDict[@"specprice"] floatValue];
        float foreP = [self.loadData.dataDict[@"factoryprice"] floatValue];

        self.decreasePrice.text = [NSString stringWithFormat:@"降%.2f万(%.2f％)",foreP-lastP,(foreP-lastP)/foreP];
        self.region.text = self.loadData.dataDict[@"orderrang"];
        self.ordersCount.text = [NSString stringWithFormat:@"该车近30天订单数: %@单",self.loadData.dataDict[@"ordercount"]];
        self.saleTime.text = @"促销时间";
        self.time.text = [NSString stringWithFormat:@"%@~%@",self.loadData.dataDict[@"bsaletime"],self.loadData.dataDict[@"esaletime"]];
        self.place.text = self.loadData.dataDict[@"dealershortname"];
        self.map.text = [dict[@"dealer"] objectForKey:@"address"];
        self.distance.text = [dict[@"dealer"] objectForKey:@"distance"];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMap:)];
        [self.mapView addGestureRecognizer:tap];
        
        self.block(self.loadData.dataDict);
        
    } withJsonUrl:@"result"];
}

- (void)showMap:(UIGestureRecognizer *)tap
{
    AHMapVC * mapVC = [[AHMapVC alloc] init];
    mapVC.hidesBottomBarWhenPushed = YES;
    [mapVC.longtitudeArray addObject:[self.dictForMap[@"dealer"] objectForKey:@"lon"]];
    [mapVC.latitudeArray addObject:[self.dictForMap[@"dealer"] objectForKey:@"lat"]];
    [mapVC.annotationTitleArray addObject:[self.dictForMap[@"dealer"] objectForKey:@"shortname"]];
    [mapVC.annotationSubTitleArray addObject:[self.dictForMap[@"dealer"] objectForKey:@"specprice"]];
    mapVC.view.backgroundColor = [UIColor whiteColor];
    [self.delegate pushViewController:mapVC];
}

@end



























