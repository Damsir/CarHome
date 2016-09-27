//
//  WebViewVC.m
//  AutoHome
//
//  Created by qianfeng on 15/10/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "WebViewVC.h"
#import "AHMapVC.h"
#import "UMSocial.h"

@interface WebViewVC ()<UIWebViewDelegate,UMSocialUIDelegate>
{
    UIWebView * webView;
    NSString * webURL;
    float collectBtnSelected;
}

@end

@implementation WebViewVC

- (id)init
{
    if(self = [super init])
    {
        collectBtnSelected = NO;
        self.webTitle = [[UILabel alloc] init];
        self.mapLongtitudeArray = [[NSMutableArray alloc] init];
        self.mapLatitudeArray = [[NSMutableArray alloc] init];
        self.mapAnnotationTitleArray = [[NSMutableArray alloc] init];
        self.mapAnnotationSubTitleArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.searchBtn removeFromSuperview];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 100, self.topBtnView.frame.size.height);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"bar_btn_icon_returntext"] forState:UIControlStateNormal];
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [backBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(pressBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.topBtnView addSubview:backBtn];
    
    self.webTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, SCREEN_W-120, self.topBtnView.frame.size.height)];
    self.webTitle.textColor = [UIColor blackColor];
    self.webTitle.font = [UIFont systemFontOfSize:16.0];
    self.webTitle.textAlignment = NSTextAlignmentCenter;
    [self.topBtnView addSubview:self.webTitle];
    
    if([self.navigationType isEqualToString:@"recommend"])
    {
        [self createCollectionAndShareBtn];
    }
    else if([self.navigationType isEqualToString:@"forum"])
    {
        UIButton * createrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        createrBtn.frame = CGRectMake(SCREEN_W-120, 0, 45, 40);
        [createrBtn setImage:[UIImage imageNamed:@"btn_icon_club_landlord"] forState:UIControlStateNormal];     //btn_icon_club_landlord_a
        [self.topBtnView addSubview:createrBtn];
        [self createCollectionAndShareBtn];
    }
    else if([self.navigationType isEqualToString:@"findCar"])
    {
        UIButton * cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cityBtn.frame = CGRectMake(SCREEN_W-50, 0, 45, self.topBtnView.frame.size.height);
        [cityBtn setTitle:@"武汉" forState:UIControlStateNormal];
        [cityBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        cityBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self.topBtnView addSubview:cityBtn];
        [self createFindCarTabBar];
    }
    else if([self.navigationType isEqualToString:@"findCarDetail"])
    {
        UIButton * cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cityBtn.frame = CGRectMake(SCREEN_W-50, 0, 45, self.topBtnView.frame.size.height);
        [cityBtn setTitle:@"武汉" forState:UIControlStateNormal];
        [cityBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        cityBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self.topBtnView addSubview:cityBtn];
        [self createFindCarDetailTabBar];
    }
    else if([self.navigationType isEqualToString:@"discover"])
    {
        UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(SCREEN_W-50, 0, 45, 40);
        [shareBtn setImage:[UIImage imageNamed:@"but_share_blue_new"] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [self.topBtnView addSubview:shareBtn];
        [self createDiscoverTabBar];
    }
    [self createWebView];
}

- (void)createCollectionAndShareBtn
{
    UIButton * collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectionBtn.frame = CGRectMake(SCREEN_W-90, 0, 45, 40);
    [collectionBtn setImage:[UIImage imageNamed:@"btn_icon_collect_1"] forState:UIControlStateNormal];
    [collectionBtn addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    [self.topBtnView addSubview:collectionBtn];
    
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(SCREEN_W-50, 0, 45, 40);
    [shareBtn setImage:[UIImage imageNamed:@"but_share_blue"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.topBtnView addSubview:shareBtn];
}

- (void)createFindCarTabBar
{
    UIView * tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, SCREEN_W, 50)];
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBarView];
    
    UIButton * collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(0, 0, 60, tabBarView.frame.size.height);
    [collectBtn setImage:[UIImage imageNamed:@"btn_icon_collect_1"] forState:UIControlStateNormal];
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    collectBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [collectBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    collectBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -15, 0, 0);
    collectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 10, 0);
    [collectBtn addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:collectBtn];
    
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(CGRectGetMaxX(collectBtn.frame), 0, 60, tabBarView.frame.size.height);
    [shareBtn setImage:[UIImage imageNamed:@"but_share_blue_new"] forState:UIControlStateNormal];
    [shareBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -33, 0, 0);
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 0);
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:shareBtn];
    
    UIButton * largBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    largBtn.frame = CGRectMake(CGRectGetMaxX(shareBtn.frame), 0, SCREEN_W-collectBtn.frame.size.width-shareBtn.frame.size.width, tabBarView.frame.size.height);
    [largBtn setTitle:@"全系查询" forState:UIControlStateNormal];
    largBtn.backgroundColor = MAINCOLOR;
    [largBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tabBarView addSubview:largBtn];
}

- (void)createFindCarDetailTabBar
{
    UIView * tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, SCREEN_W, 50)];
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBarView];
    
    UIButton * collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(0, 0, 60, tabBarView.frame.size.height);
    [collectBtn setImage:[UIImage imageNamed:@"btn_icon_collect_1"] forState:UIControlStateNormal];
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    collectBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    collectBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -33, 0, 0);
    collectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 0);
    [collectBtn addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:collectBtn];
    
    UIButton * mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mapBtn.frame = CGRectMake(CGRectGetMaxX(collectBtn.frame), 0, 60, tabBarView.frame.size.height);
    [mapBtn setImage:[UIImage imageNamed:@"btn_icon_map_1"] forState:UIControlStateNormal];
    [mapBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [mapBtn setTitle:@"地图" forState:UIControlStateNormal];
    mapBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    mapBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -33, 0, 0);
    mapBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 0);
    [mapBtn addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:mapBtn];
    
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(CGRectGetMaxX(mapBtn.frame), 0, 60, tabBarView.frame.size.height);
    [shareBtn setImage:[UIImage imageNamed:@"but_share_blue_new"] forState:UIControlStateNormal];
    [shareBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -35, 0, 0);
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 0);
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:shareBtn];
    
    UIButton * largBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    largBtn.frame = CGRectMake(CGRectGetMaxX(shareBtn.frame), 0, SCREEN_W-collectBtn.frame.size.width-mapBtn.frame.size.width-shareBtn.frame.size.width, tabBarView.frame.size.height);
    [largBtn setTitle:@"全系查询" forState:UIControlStateNormal];
    largBtn.backgroundColor = MAINCOLOR;
    [largBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tabBarView addSubview:largBtn];
}

- (void)createDiscoverTabBar
{
    UIView * tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, SCREEN_W, 50)];
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBarView];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, SCREEN_W/3.0,tabBarView.frame.size.height);
    [leftBtn setImage:[UIImage imageNamed:@"bar_btn_icon_previous"] forState:UIControlStateNormal];
    [tabBarView addSubview:leftBtn];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), 0, SCREEN_W/3.0, tabBarView.frame.size.height);
    [rightBtn setImage:[UIImage imageNamed:@"bar_btn_icon_next"] forState:UIControlStateNormal];
    [tabBarView addSubview:rightBtn];
    
    UIButton * refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(CGRectGetMaxX(rightBtn.frame), 0, SCREEN_W-leftBtn.frame.size.width-rightBtn.frame.size.width, tabBarView.frame.size.height);
    [refreshBtn setImage:[UIImage imageNamed:@"bar_btn_icon_refresh"] forState:UIControlStateNormal];
    [tabBarView addSubview:refreshBtn];
}

- (void)showMap
{
    AHMapVC * mapVC = [[AHMapVC alloc] init];
    mapVC.hidesBottomBarWhenPushed = YES;
    mapVC.longtitude = self.mapLontitude;
    mapVC.latitude = self.mapLatitude;
    mapVC.annotationTitle = self.mapAnnotationTitle;
    
    mapVC.longtitudeArray = self.mapLongtitudeArray;
    mapVC.latitudeArray = self.mapLatitudeArray;
    mapVC.annotationTitleArray = self.mapAnnotationTitleArray;
    mapVC.annotationSubTitleArray = self.mapAnnotationSubTitleArray;
    
    mapVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)collect:(UIButton *)btn
{
    if(collectBtnSelected == NO)
    {
        [btn setImage:[UIImage imageNamed:@"btn_icon_collected_1"] forState:UIControlStateNormal];
        collectBtnSelected = YES;
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"btn_icon_collect_1"] forState:UIControlStateNormal];
        collectBtnSelected = NO;
    }
}

- (void)share
{
//    56235cff67e58eaf86005ef6 [UIImage imageNamed:@"angry_00.jpg"]
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56235cff67e58eaf86005ef6" shareText:webURL shareImage:[UIImage imageNamed:@"N8K36D4C9741QN(T]PD4P%4"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,nil] delegate:self];
}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        NSLog(@"分享成功");
    }
}

- (void)pressBackBtn
{
    [webView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createWebView
{
    switch (self.itemType) {
        case 1:
            webURL = [NSString stringWithFormat:@"%@%@.html",FASTNEWS,self.itemID];
            break;
        case 2:
            webURL = [NSString stringWithFormat:@"%@%@.html?from=pc",VIDEO,self.itemID];
            break;
        case 3:
            webURL = [NSString stringWithFormat:@"%@%@.html",NEWLEST,self.itemID];
            break;
        case 4:
            webURL = [NSString stringWithFormat:@"%@%@.html",TESK,self.itemID];
            break;
        case 5:
            webURL = [NSString stringWithFormat:@"%@%@.html",GUIDE,self.itemID];
            break;
        case 6:
            webURL = [NSString stringWithFormat:@"%@%@.html",NEWLEST,self.itemID];
            break;
        case 7:
            webURL = [NSString stringWithFormat:@"%@%@.html",USECAR,self.itemID];
            break;
        case 8:
            webURL = [NSString stringWithFormat:@"%@%@.html",TECHNOLOGY,self.itemID];
            break;
        case 9:
            webURL = [NSString stringWithFormat:@"%@%@.html",CULTURE,self.itemID];
            break;
        case 10:
            webURL = [NSString stringWithFormat:@"%@%@.html",CHANGE,self.itemID];
            break;
        case 11:
            webURL = [NSString stringWithFormat:@"%@%@.html",TOUR,self.itemID];
            break;
        case 12:
            webURL = [NSString stringWithFormat:@"%@%@.html?from=pc",SELFDIYV,self.itemID];
            break;
        case 13:
            webURL = [NSString stringWithFormat:@"%@%@.html",TALK,self.itemID];
            break;
        case 100:
            webURL = [NSString stringWithFormat:@"%@%@-%@-%@-1.html",SELECTED,self.bbstype,self.bbsID,self.itemID];
            break;
        case 200:
            webURL = self.URL;
        default:
            break;
    }
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:webURL]];
    webView = [[UIWebView alloc] init];
    webView.delegate = self;
    if(self.isCreateTabBar)
    {
        webView.Frame = CGRectMake(0, CGRectGetMaxY(self.topBtnView.frame), SCREEN_W, self.view.frame.size.height-self.topBtnView.frame.size.height-70);
    }
    else
    {
        webView.Frame = CGRectMake(0, CGRectGetMaxY(self.topBtnView.frame), SCREEN_W, self.view.frame.size.height-self.topBtnView.frame.size.height-20);
    }
    [webView loadRequest:request];
    [self.view addSubview:webView];
}


//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    
//    // 获得web 页面的头title
//    //     通过获得web html 页面的 "document.title"  js代码获取
//    webTitle.text =[webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
