//
//  AHTableView.h
//  AutoHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHBaseView.h"

@interface AHTableView : AHBaseView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIScrollView * topScroll;
    NSArray * focusImage;
    NSArray * newsList;
    NSDictionary * topNewsInfo;
    UIPageControl * pageController;
}

- (id)initWithFrame:(CGRect)frame andDifferentPage:(AHDIFFERENTPage)page;

@end
