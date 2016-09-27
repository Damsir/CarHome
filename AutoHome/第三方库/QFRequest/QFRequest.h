//
//  QFRequest.h
//  Day18网络请求的封装
//
//  Created by Leven on 15/9/8.
//  Copyright (c) 2015年 Leven. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successReqBlock)(NSData *data);
typedef void (^failReqBlock)(NSError *error);
// typedef 定义的block 和属性直接定义的block 区别在于
//  直接定义属性的话别的地方想要使用必须得重新定义,没法用属性定义的
// typedef 的好处就是一个地方定义了,别的地方都可以使用

@interface QFRequest : NSObject 

// 通常做网络请求的封装,封装外部需要传URL 进来,而请求内部需要告诉外部请求成功或者失败

// 定义外面可以访问的URL
@property (nonatomic,strong)NSString *url;

@property (nonatomic,copy) void (^myblock)(int i);

// 请求成功的回调的Block
@property (nonatomic,copy)successReqBlock successReqBlock;
// 请求失败的回调Block
@property (nonatomic,copy)failReqBlock failReqBlock;

// 开始请求的方法
- (void)start;

@end
