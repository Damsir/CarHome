//
//  AHDiscountDetailCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHDiscountDetailCell.h"

@implementation AHDiscountDetailCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    [self.image sd_setImageWithURL:dict[@"specimg"] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.title.text = dict[@"name"];
    self.lastPrice.text = [NSString stringWithFormat:@"%@万",dict[@"price"]];
    self.forePrice.text = [NSString stringWithFormat:@"%@万",dict[@"factoryprice"]];
    self.decreasePrice.text = [NSString stringWithFormat:@"降%.2f万",[dict[@"range"] doubleValue]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
