//
//  QFRequestManger.m
//  Day18网络请求的封装
//
//  Created by Leven on 15/9/8.
//  Copyright (c) 2015年 Leven. All rights reserved.
//

#import "QFRequestManger.h"

@implementation QFRequestManger

+ (void)requestWith:(NSString *)url success:(successReqBlock)successBlcok failBlock:(failReqBlock)failBlock{

    QFRequest *qf=[[QFRequest alloc]init];
    qf.url=url;
    qf.successReqBlock=successBlcok;
    qf.failReqBlock=failBlock;
    [qf start];

}

@end
