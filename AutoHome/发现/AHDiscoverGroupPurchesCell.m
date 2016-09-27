//
//  AHDiscoverGroupPurchesCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHDiscoverGroupPurchesCell.h"

@implementation AHDiscoverGroupPurchesCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    [self.image sd_setImageWithURL:dict[@"imgpath"] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.title.text = dict[@"title"];
    self.TimeAndRage.text = [NSString stringWithFormat:@"%@至%@ : %@",dict[@"starttime"],dict[@"endtime"],dict[@"cityname"]];
    self.endDate.text = @"18天4小时27分钟25秒";
    self.focusCount.text = [NSString stringWithFormat:@"%@人关注",dict[@"pcviews"]];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
