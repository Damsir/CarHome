//
//  AHDiscoverBottomCell.h
//  AutoHome
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@protocol AHDiscoverBottomCell <NSObject>

- (void)pushViewController:(UIViewController *)controller;

@end

@interface AHDiscoverBottomCell : BaseTableViewCell 

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property(strong,nonatomic) NSArray * appListArray;

@property(assign,nonatomic) id delegate;

@end
