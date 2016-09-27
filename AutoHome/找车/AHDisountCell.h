//
//  AHDisountCell.h
//  AutoHome
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface AHDisountCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *dealerPrice;
@property (weak, nonatomic) IBOutlet UILabel *fctPrice;
@property (weak, nonatomic) IBOutlet UILabel *decreasePrice;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UILabel *region;
@property (weak, nonatomic) IBOutlet UILabel *shortName;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *orderRange;
@property (weak, nonatomic) IBOutlet UIButton *caculateBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *inquireBtn;

@property(strong,nonatomic) NSDictionary * dataDict;

@end
