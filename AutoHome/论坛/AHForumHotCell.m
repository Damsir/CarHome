//
//  AHForumHotCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHForumHotCell.h"

@implementation AHForumHotCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    self.title.text = dict[@"title"];
    self.forumKindAndDate.text = [NSString stringWithFormat:@"%@ %@ ",dict[@"bbsname"],dict[@"postdate"]];
    self.reply.text = [NSString stringWithFormat:@"%@回帖",dict[@"replycounts"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
