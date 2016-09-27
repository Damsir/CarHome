//
//  AHForumHotCell.h
//  AutoHome
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface AHForumHotCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *forumKindAndDate;
@property (weak, nonatomic) IBOutlet UILabel *reply;

@end
