//
//  AHTableView2.h
//  AutoHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHBaseView.h"

@interface AHTableView2 : AHBaseView
{
    NSArray * listArray;
}

- (id)initWithFrame:(CGRect)frame andDifferentPage:(AHDIFFERENTPage)page;

@end
