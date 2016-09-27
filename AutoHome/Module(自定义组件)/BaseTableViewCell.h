//
//  BaseTableViewCell.h
//  AutoHome
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface BaseTableViewCell : UITableViewCell

- (void)initAttribute;

- (void)setUIWithDict:(NSDictionary *)dict;

@end
