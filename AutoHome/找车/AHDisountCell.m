//
//  AHDisountCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHDisountCell.h"

@implementation AHDisountCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    self.dataDict = [[NSDictionary alloc] initWithDictionary:dict];
    [self initAttribute];
    [self.image sd_setImageWithURL:[NSURL URLWithString:dict[@"specpic"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.title.text = [NSString stringWithFormat:@"%@ %@",dict[@"seriesname"],dict[@"specname"]];
    self.dealerPrice.text = [NSString stringWithFormat:@"%@万",dict[@"dealerprice"]];
    self.fctPrice.text = [NSString stringWithFormat:@"%@万",dict[@"fctprice"]];
    self.decreasePrice.text = [NSString stringWithFormat:@"降%.2f万",[dict[@"fctprice"] floatValue]-[dict[@"dealerprice"] floatValue]];
    self.middleView.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
    self.region.text = [dict[@"dealer"] objectForKey:@"city"];
    self.shortName.text = [dict[@"dealer"] objectForKey:@"shortname"];
    self.distance.text = [NSString stringWithFormat:@"距离%@",[dict[@"dealer"] objectForKey:@"distance"]];
    self.orderRange.text = dict[@"orderrange"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
