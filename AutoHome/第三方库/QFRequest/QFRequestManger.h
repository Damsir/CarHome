//
//  QFRequestManger.h
//  Day18网络请求的封装
//
//  Created by Leven on 15/9/8.
//  Copyright (c) 2015年 Leven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFRequest.h"

typedef void (^myblock)(int i);

@interface QFRequestManger : NSObject

+ (void)loadBlock:(myblock)block;

// 对请求做再一次封装(用类方法)
+ (void)requestWith:(NSString *)url success:(successReqBlock)successBlcok failBlock:(failReqBlock)failBlock;

@end
