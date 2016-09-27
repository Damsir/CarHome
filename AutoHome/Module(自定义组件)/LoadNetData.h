//
//  LoadNetData.h
//  AutoHome
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, AHDIFFERENTPage)
{
    AHRECOMMEND1,
    AHRECOMMEND2,
    AHRECOMMEND3,
    AHRECOMMEND4,
    AHRECOMMEND5,
    AHRECOMMEND6,
    AHRECOMMEND7,
    AHRECOMMEND8,
    AHRECOMMEND9,
    AHRECOMMEND10,
    AHRECOMMEND11,
    AHRECOMMEND12,
    AHRECOMMEND13,
    AHRECOMMEND14,
    
    AHFORUM11,
    AHFORUMHOT,
    
    AHFINDCARBRAND,
    AHFINDCARAD,
    AHFINDCARMAIN,
    
    AHFINDCARPROVINCE,
    
    AHDISCOUNT,
    AHDISCOVERGROUPPURCHES,
    
    AHDISCOVERAD,
    AHDISCOVERMOREAPP
};

typedef void(^freshDataBlock)(BOOL isSuccess,NSError * error);

@interface LoadNetData : NSObject

@property(strong,nonatomic) NSMutableDictionary * dataDict;

@property(assign,nonatomic) AHDIFFERENTPage differentPage;

@property(assign,nonatomic) NSInteger range;

@property(assign,nonatomic) NSInteger page;

@property(strong,nonatomic) NSString * URL;

- (void)loadCarInfo1:(freshDataBlock)block withJsonUrl:(NSString *)jsonUrl;

- (void)loadMoreCarInfor:(freshDataBlock)block withJsonUrl:(NSString *)jsonUrl;

- (void)loadCarInfo2:(freshDataBlock)block withJsonUrl:(NSString *)jsonUrl;

@end








