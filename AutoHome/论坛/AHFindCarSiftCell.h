//
//  AHFindCarSiftCell.h
//  AutoHome
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface AHFindCarSiftCell : BaseTableViewCell

@property(assign,nonatomic) int isSelected;
@property(strong,nonatomic) NSString * itemType;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
