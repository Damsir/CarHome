//
//  AHFindResultCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHFindResultCell.h"

@implementation AHFindResultCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    [self.image sd_setImageWithURL:dict[@"img"] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.title.text = dict[@"name"];
    self.price.text = dict[@"price"];
    [self.totalCount setTitle:[NSString stringWithFormat:@"%@款车型",dict[@"count"]] forState:UIControlStateNormal];
    self.totalCount.layer.cornerRadius = 5;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
