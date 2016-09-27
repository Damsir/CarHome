//
//  BaseTableViewCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)initAttribute
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setUIWithDict:(NSDictionary *)dict
{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
