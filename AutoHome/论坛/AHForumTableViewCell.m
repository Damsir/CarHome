//
//  AHForumTableViewCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHForumTableViewCell.h"

@implementation AHForumTableViewCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    [self.image sd_setImageWithURL:[NSURL URLWithString:dict[@"smallpic"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.title.text = dict[@"title"];
    self.reply.text = [NSString stringWithFormat:@"💬 %@回帖",dict[@"replycounts"]];
    self.reply.textAlignment = NSTextAlignmentRight;
    self.forumKind.text = dict[@"bbsname"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
