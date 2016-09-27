//
//  AHFindCarSiftCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHFindCarSiftCell.h"

@implementation AHFindCarSiftCell

- (void)setUIWithDict:(NSDictionary *)dict
{
    [self initAttribute];
    self.title.text = dict[@"name"];
}

- (void)initAttribute
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if(self.isSelected == 0)
    {
        [self.leftBtn setImage:[[UIImage imageNamed:@"btn_icon_select_fail_new_day"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        self.title.textColor = [UIColor darkGrayColor];
    }
    else
    {
        [self.leftBtn setImage:[UIImage imageNamed:@"btn_icon_select_true_new"] forState:UIControlStateNormal];
        self.title.textColor = MAINCOLOR;
    }
    self.leftBtn.layer.cornerRadius = 10.0;
    self.leftBtn.clipsToBounds = YES;
}

- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
