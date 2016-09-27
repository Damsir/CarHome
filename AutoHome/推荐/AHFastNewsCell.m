//
//  AHFastNewsCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHFastNewsCell.h"

@implementation AHFastNewsCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    self.typeName.text = dict[@"typename"];
    self.state.text = @"播报结束";
    self.title.text = dict[@"title"];
    self.reviewCount.text = [NSString stringWithFormat:@"%@位观众",dict[@"reviewcount"]];
    [self.image sd_setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.createTime.text = dict[@"createtime"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
