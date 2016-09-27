//
//  AHFindCarCell.h
//  AutoHome
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface AHFindCarCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property(strong,nonatomic) NSNumber * carID;

@end
