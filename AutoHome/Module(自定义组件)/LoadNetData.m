//
//  LoadNetData.m
//  AutoHome
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LoadNetData.h"
#import "QFRequestManger.h"

@implementation LoadNetData

- (id)init
{
    if(self = [super init])
    {
//        self.dataArray = [[NSMutableArray alloc] init];
        self.dataDict = [[NSMutableDictionary alloc] init];
        self.range = 20;
    }
    return self;
}

- (void)loadCarInfo1:(freshDataBlock)block withJsonUrl:(NSString *)jsonUrl
{
    self.range = 20;
    self.page = 1;
    NSString * url = @"";
    switch (self.differentPage) {
        case AHRECOMMEND1:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND1,self.range];
            break;
        case AHRECOMMEND2:
            url = [NSString stringWithFormat:@"%@%ld-lastid0.json",RECOMMEND2,self.range];
            break;
        case AHRECOMMEND3:
            url = [NSString stringWithFormat:@"%@%ld-lastid0.json",RECOMMEND3,self.range];
            break;
        case AHRECOMMEND4:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND4,self.range];
            break;
        case AHRECOMMEND5:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND5,self.range];
            break;
        case AHRECOMMEND6:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND6,self.range];
            break;
        case AHRECOMMEND7:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND7,self.range];
            break;
        case AHRECOMMEND8:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND8,self.range];
            break;
        case AHRECOMMEND9:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND9,self.range];
            break;
        case AHRECOMMEND10:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND10,self.range];
            break;
        case AHRECOMMEND11:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND11,self.range];
            break;
        case AHRECOMMEND12:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND12,self.range];
            break;
        case AHRECOMMEND13:
            url = [NSString stringWithFormat:@"%@%ld-lastid0.json",RECOMMEND13,self.range];
            break;
        case AHRECOMMEND14:
            url = [NSString stringWithFormat:@"%@%ld-lastid0.json",RECOMMEND14,self.range];
            break;
        case AHFORUM11:
            url = [NSString stringWithFormat:@"%@%ld.json",FORUM11,self.range];
            break;
        case AHFORUMHOT:
            url = [NSString stringWithFormat:@"%@%ld.json",FORUMHOT,self.range];
            break;
        case AHFINDCARBRAND:
            url = FINDCARBRAND;
            break;
        case AHFINDCARAD:
            url = FINDCARAD;
            break;
        case AHFINDCARMAIN:
            url = FINDCARMAIN;
            break;
        case AHFINDCARPROVINCE:
            url = FINDCARPROVINCE;
            break;
        case AHDISCOUNT:
            url = [NSString stringWithFormat:@"%@%ld-s20-l0-minp0-maxp0-lon114.435791-lat30.459583.json",DISCOUNT,self.page];
            break;
        case AHDISCOVERGROUPPURCHES:
            url = [NSString stringWithFormat:@"%@%ld-s20.json",DISCOVERGROUPPURCHES,self.page];
            break;
        case AHDISCOVERAD:
            url = DISCOVERAD;
            break;
        case AHDISCOVERMOREAPP:
            url = DISCOVERMOREAPP;
            break;
        default:
            break;
    }
    [QFRequestManger requestWith:url success:^(NSData *data) {
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.dataDict = [NSMutableDictionary dictionaryWithDictionary:jsonDict[jsonUrl]];
        if(block)
        {
            block(YES,nil);
        }
    } failBlock:^(NSError *error) {
        if(block)
        {
            block(NO,error);
        }
    }];
}

- (void)loadMoreCarInfor:(freshDataBlock)block withJsonUrl:(NSString *)jsonUrl
{
    self.range += 10;
    self.page++;
    NSString * url = @"";
    switch (self.differentPage) {
        case AHRECOMMEND1:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND1,self.range];
            break;
        case AHRECOMMEND2:
            url = [NSString stringWithFormat:@"%@%ld-lastid0.json",RECOMMEND2,self.range];
            break;
        case AHRECOMMEND3:
            url = [NSString stringWithFormat:@"%@%ld-lastid0.json",RECOMMEND3,self.range];
            break;
        case AHRECOMMEND4:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND4,self.range];
            break;
        case AHRECOMMEND5:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND5,self.range];
            break;
        case AHRECOMMEND6:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND6,self.range];
            break;
        case AHRECOMMEND7:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND7,self.range];
            break;
        case AHRECOMMEND8:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND8,self.range];
            break;
        case AHRECOMMEND9:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND9,self.range];
            break;
        case AHRECOMMEND10:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND10,self.range];
            break;
        case AHRECOMMEND11:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND11,self.range];
            break;
        case AHRECOMMEND12:
            url = [NSString stringWithFormat:@"%@%ld-l0.json",RECOMMEND12,self.range];
            break;
        case AHRECOMMEND13:
            url = [NSString stringWithFormat:@"%@%ld-lastid0.json",RECOMMEND13,self.range];
            break;
        case AHRECOMMEND14:
            url = [NSString stringWithFormat:@"%@%ld-lastid0.json",RECOMMEND14,self.range];
            break;
        case AHFORUM11:
            url = [NSString stringWithFormat:@"%@%ld.json",FORUM11,self.range];
            break;
        case AHFORUMHOT:
            url = [NSString stringWithFormat:@"%@%ld.json",FORUMHOT,self.range];
            break;
        case AHFINDCARBRAND:
            url = FINDCARBRAND;
            break;
        case AHFINDCARAD:
            url = FINDCARAD;
            break;
        case AHFINDCARMAIN:
            url = FINDCARMAIN;
            break;
        case AHFINDCARPROVINCE:
            url = FINDCARPROVINCE;
            break;
        case AHDISCOUNT:
            url = [NSString stringWithFormat:@"%@%ld-s20-l0-minp0-maxp0-lon114.435791-lat30.459583.json",DISCOUNT,self.page];
            break;
        case AHDISCOVERGROUPPURCHES:
            url = [NSString stringWithFormat:@"%@%ld-s20.json",DISCOVERGROUPPURCHES,self.page];
            break;
        case AHDISCOVERAD:
            url = DISCOVERAD;
            break;
        case AHDISCOVERMOREAPP:
            url = DISCOVERMOREAPP;
            break;
        default:
            break;
    }
    [QFRequestManger requestWith:url success:^(NSData *data) {
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.dataDict = [NSMutableDictionary dictionaryWithDictionary:jsonDict[jsonUrl]];
        if(block)
        {
            block(YES,nil);
        }
    } failBlock:^(NSError *error) {
        if(block)
        {
            block(NO,error);
        }
    }];
}

- (void)loadCarInfo2:(freshDataBlock)block withJsonUrl:(NSString *)jsonUrl
{
    [QFRequestManger requestWith:self.URL success:^(NSData *data) {
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.dataDict = [NSMutableDictionary dictionaryWithDictionary:jsonDict[jsonUrl]];
        if(block)
        {
            block(YES,nil);
        }
    } failBlock:^(NSError *error) {
        if(block)
        {
            block(NO,error);
        }
    }];
}

@end
