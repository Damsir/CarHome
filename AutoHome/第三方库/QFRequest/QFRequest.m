//
//  QFRequest.m
//  Day18网络请求的封装
//
//  Created by Leven on 15/9/8.
//  Copyright (c) 2015年 Leven. All rights reserved.
//

#import "QFRequest.h"

// 在.m文件里面写Interface和在.h文件里面写interface实际没有太大区别,
// 唯一的区别在于,.h文件定义的外边可以访问到,已经看到,.m文件一般不不用爆露给外面看到

@interface QFRequest ()<NSURLConnectionDataDelegate>
{
    NSMutableData *netData; //保存请求的网络数据
}

@end

@implementation QFRequest

- (void)start{

    // 用外部传入的url 作为网络请求的url链接
    NSURL *requestUrl=[NSURL URLWithString:self.url];
    NSURLRequest *request=[NSURLRequest requestWithURL:requestUrl];
    //创建网络请求连接
    NSURLConnection *connection=[NSURLConnection connectionWithRequest:request delegate:self];
    
    netData=[[NSMutableData alloc]init];
    // 开始网络请求
    [connection start];
    
}

#pragma mark ------NSURLConnection的请求代理方法

// 请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [netData setLength:0];
    if(self.failReqBlock){ //block 如果外部没有赋值,直接调用就会出现程序崩溃
      self.failReqBlock(error);
    }
}

// 第一次得到服务器的回应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [netData setLength:0];
}

//每一次请求到的数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    [netData appendData:data];
    
}

// 网络请求结束
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    if(self.successReqBlock){
        self.successReqBlock(netData);
    }
    
}


@end
