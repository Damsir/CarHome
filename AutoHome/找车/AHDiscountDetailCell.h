//
//  AHDiscountDetailCell.h
//  AutoHome
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface AHDiscountDetailCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *lastPrice;
@property (weak, nonatomic) IBOutlet UILabel *forePrice;
@property (weak, nonatomic) IBOutlet UILabel *decreasePrice;
@property (weak, nonatomic) IBOutlet UIButton *caculateBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *lowestPriceBtn;

@end
