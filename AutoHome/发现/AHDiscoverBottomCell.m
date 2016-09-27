//
//  AHDiscoverBottomCell.m
//  AutoHome
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHDiscoverBottomCell.h"
#import "LoadNetData.h"
#import "UIImageView+WebCache.h"
#import "WebViewVC.h"

@implementation AHDiscoverBottomCell

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.appListArray = [NSArray new];
    LoadNetData * loadData = [LoadNetData new];
    loadData.URL = DISCOVERMOREAPP;
    [loadData loadCarInfo2:^(BOOL isSuccess, NSError *error) {
        self.appListArray = loadData.dataDict[@"applist"];
        for(int i=0; i<4; i++)
        {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*(SCREEN_W-160)/4+((2*i)+1)*20, 20, (SCREEN_W-160)/4, (SCREEN_W-160)/4);
            UIImageView * imageview = [UIImageView new];
            [imageview sd_setImageWithURL:[self.appListArray[i] objectForKey:@"iconurl"] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
            [button setImage:imageview.image forState:UIControlStateNormal];
//            button.layer.cornerRadius = 10;
            
            [button addTarget:self action:@selector(pressMoreApp:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 1000+i;
            [self addSubview:button];
            
            UILabel * appName = [[UILabel alloc] initWithFrame:CGRectMake(i*SCREEN_W/4.0, CGRectGetMaxY(button.frame), SCREEN_W/4.0, 20)];
            appName.text = [self.appListArray[i] objectForKey:@"name"];
            appName.textColor = [UIColor darkGrayColor];
            appName.textAlignment = NSTextAlignmentCenter;
            appName.font = [UIFont systemFontOfSize:13.0];
            [self addSubview:appName];
        }
    } withJsonUrl:@"result"];
}

//    downurl : "ttp://app.autohome.com.cn/app/ashx/rd/rd.ashx?id=1261&rd=http%3a%2f%2fapp.club.autohome.com.cn%2fapk%2fclub_autohome_mainapp.apk"

- (void)pressMoreApp:(UIButton *)btn
{
    WebViewVC * webView = [WebViewVC new];
    webView.URL = [self.appListArray[btn.tag-1000] objectForKey:@"downurl"];
    webView.itemType = 200;
    webView.isCreateTabBar = NO;
    webView.navigationType = @"recommend";
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.titleLab.text = [self.appListArray[btn.tag-1000] objectForKey:@"name"];
    [self.delegate pushViewController:webView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
