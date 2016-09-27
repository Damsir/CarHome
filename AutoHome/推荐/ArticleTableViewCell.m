//
//  ArticleTableViewCell.m
//  AutoHome
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    [self.image sd_setImageWithURL:[NSURL URLWithString:dict[@"smallpic"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.title.text = dict[@"title"];
    self.time.text = dict[@"time"];
    self.reply.text = [NSString stringWithFormat:@"💬 %@评论",dict[@"replycount"]];
    self.reply.textAlignment = NSTextAlignmentRight;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
