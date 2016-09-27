//
//  AHFindResultSiftCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHFindResultSiftCell.h"

@implementation AHFindResultSiftCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    self.title.text = dict[@"name"];
    self.conform.text = dict[@"description"];
    self.price.text = dict[@"price"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
