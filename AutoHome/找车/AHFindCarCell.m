//
//  AHFindCarCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHFindCarCell.h"

@implementation AHFindCarCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    [self.image sd_setImageWithURL:[NSURL URLWithString:dict[@"imgurl"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.name.text = dict[@"name"];
    self.carID = dict[@"id"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
