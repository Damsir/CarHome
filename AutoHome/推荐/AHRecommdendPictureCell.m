//
//  AHRecommdendPictureCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHRecommdendPictureCell.h"

@implementation AHRecommdendPictureCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createWindow];
    }
    return self;
}

- (void)createWindow
{
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width-10, 35)];
    self.title.font = [UIFont systemFontOfSize:18.0];
    [self addSubview:self.title];
    self.image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.title.frame)+5, (SCREEN_W-40)/3, 80)];
    [self addSubview:self.image1];
    self.image2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image1.frame)+10, CGRectGetMaxY(self.title.frame)+5, (SCREEN_W-40)/3, 80)];
    [self addSubview:self.image2];
    self.image3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image2.frame)+10, CGRectGetMaxY(self.title.frame)+5, (SCREEN_W-40)/3, 80)];
    [self addSubview:self.image3];
    
    self.createTime = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.image1.frame)+10, 90, 20)];
    self.createTime.font = [UIFont systemFontOfSize:13.0];
    self.createTime.textColor = [UIColor darkGrayColor];
    [self addSubview:self.createTime];
    
    self.replyCount = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W-90, CGRectGetMaxY(self.image1.frame)+10, 80, 20)];
    self.replyCount.font = [UIFont systemFontOfSize:13.0];
    self.replyCount.textColor = [UIColor darkGrayColor];
    self.replyCount.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.replyCount];
    
}

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    self.title.text = dict[@"title"];
    self.createTime.text = dict[@"time"];
    self.replyCount.text = [NSString stringWithFormat:@"💬 %@评论",dict[@"replycount"]];
    
    NSMutableString * url = [NSMutableString stringWithString:dict[@"indexdetail"]];
    NSRange range = {0,11};
    [url deleteCharactersInRange:range];
    NSArray * imagesArray = [url componentsSeparatedByString:@","];
    [self.image1 sd_setImageWithURL:imagesArray[0] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [self.image2 sd_setImageWithURL:imagesArray[1] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [self.image3 sd_setImageWithURL:imagesArray[2] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
}

- (void)setUIWithNewDict:(NSDictionary *)dict
{
    [self initAttribute];
    self.title.text = dict[@"title"];
    self.createTime.text = dict[@"time"];
    self.replyCount.text = [NSString stringWithFormat:@"💬 %@评论",dict[@"replycount"]];
    
    NSMutableString * url = [NSMutableString stringWithString:dict[@"indexdetail"]];
    NSArray * imagesArray = [url componentsSeparatedByString:@"㊣"];
    [self.image1 sd_setImageWithURL:imagesArray[0] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [self.image2 sd_setImageWithURL:imagesArray[1] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [self.image3 sd_setImageWithURL:imagesArray[2] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
}

@end

















