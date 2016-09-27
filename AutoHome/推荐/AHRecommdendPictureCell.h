//
//  AHRecommdendPictureCell.h
//  AutoHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface AHRecommdendPictureCell : BaseTableViewCell

@property(strong,nonatomic) UILabel * title;

@property(strong,nonatomic) UIImageView * image1;

@property(strong,nonatomic) UIImageView * image2;

@property(strong,nonatomic) UIImageView * image3;

@property(strong,nonatomic) UILabel * createTime;

@property(strong,nonatomic) UILabel * replyCount;

- (void)setUIWithNewDict:(NSDictionary *)dict;

@end
