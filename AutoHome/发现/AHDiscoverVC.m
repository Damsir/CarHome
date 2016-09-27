//
//  AHDiscoverVC.m
//  AutoHome
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHDiscoverVC.h"
#import "AHDiscoverBottomCell.h"
#import "AFDiscoverGroupPurchesVC.h"
#import "WebViewVC.h"
#import "FindCarVC.h"
#import "AHDiscoverCell.h"

@interface AHDiscoverVC ()<UITableViewDataSource,UITableViewDelegate,AHDiscoverBottomCell>
{
    NSArray * allTitleArray;
    NSString * urlString;
    NSArray * appLIstArray;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation AHDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavigation];
    [self initSelf];
    [self tableRegister];
    [self crateHeaderView];
    
}

- (void)createNavigation
{
    [self.searchBtn removeFromSuperview];
    UILabel * topLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 50, 40)];
    topLab.text = @"发现";
    topLab.textColor = MAINCOLOR;
    [self.topBtnView addSubview:topLab];
    
    UILabel * lineLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 38, 35, 2)];
    lineLab.backgroundColor = MAINCOLOR;
    [self.topBtnView addSubview:lineLab];
}

- (void)initSelf
{
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.table.bounces = NO;
    NSDictionary * dict1 = @{@"image":@"discoveryfunction_14",@"title":@"活动/团购"};
    NSDictionary * dict2 = @{@"image":@"discoveryfunction_6",@"title":@"双11有真相再买车"};
    NSDictionary * dict3 = @{@"image":@"discoveryfunction_13",@"title":@"汽车之家电台"};
    NSDictionary * dict4 = @{@"image":@"discoveryfunction_7",@"title":@"购车计算"};
    NSDictionary * dict5 = @{@"image":@"discoveryfunction_16",@"title":@"爱车估值"};
    NSDictionary * dict6 = @{@"image":@"discoveryfunction_11",@"title":@"车商城"};
    NSDictionary * dict7 = @{@"image":@"discoveryfunction_10",@"title":@"足不出户为爱车养护"};
    NSDictionary * dict8 = @{@"image":@"discoveryfunction_12",@"title":@"电动车之家"};
    NSArray * titleArray1 = @[dict1,dict2];
    NSArray * titleArray2 = @[dict3];
    NSArray * titleArray3 = @[dict4,dict5];
    NSArray * titleArray4 = @[dict6,dict7];
    NSArray * titleArray5 = @[dict8];

    allTitleArray = [[NSArray alloc] initWithObjects:titleArray1,titleArray2,titleArray3,titleArray4,titleArray5, nil];
    
    appLIstArray = [NSArray new];
    self.loadData = [LoadNetData new];
}

- (void)tableRegister
{
    UINib * nib = [UINib nibWithNibName:@"AHDiscoverCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"AHDiscoverCell"];
    
    [self.table registerClass:[AHDiscoverBottomCell class] forCellReuseIdentifier:@"AHDiscoverBottomCell"];
}

- (void)crateHeaderView
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 125)];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressAD:)];
    [imageView addGestureRecognizer:tap];
    self.table.tableHeaderView = imageView;
    
    self.loadData.differentPage = AHDISCOVERAD;
    [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
        [imageView sd_setImageWithURL:self.loadData.dataDict[@"imgurl"] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        urlString = self.loadData.dataDict[@"url"];
        [self.table reloadData];
    } withJsonUrl:@"result"];
}

- (void)pressAD:(UIGestureRecognizer *)tap
{
    [self pushWebViewWithURL:urlString andIsCreateTabBar:YES andNaviType:@"discover" andWebTitle:@"今日推荐"];
}

#pragma mark - AHDiscoverBottomCellDelegate
- (void)pushViewController:(UIViewController *)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section != 5)
    {
        return [allTitleArray[section] count];
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section != 5)
    {
        AHDiscoverCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHDiscoverCell"];
        cell.image.image = [UIImage imageNamed:[allTitleArray[indexPath.section][indexPath.row] objectForKey:@"image"]];
        cell.title.text = [allTitleArray[indexPath.section][indexPath.row] objectForKey:@"title"];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        AHDiscoverBottomCell * cell = [[AHDiscoverBottomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AHDiscoverBottomCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"AHDiscoverBottomCell"];
        cell.delegate = self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        AFDiscoverGroupPurchesVC * groupPurchesVC = [[AFDiscoverGroupPurchesVC alloc] init];
        groupPurchesVC.view.backgroundColor = [UIColor whiteColor];
        groupPurchesVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:groupPurchesVC animated:YES];
    }
    else if(indexPath.section == 0 && indexPath.row == 1)
    {
        [self pushWebViewWithURL:DOUBLE11 andIsCreateTabBar:YES andNaviType:@"discover" andWebTitle:@"双11来临"];
    }
    else if(indexPath.section == 1 || (indexPath.section == 2 && indexPath.row == 0))
    {
        self.table.alpha = 0.3;
        UILabel * noticeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, SCREEN_H/2.0+100, SCREEN_W-20, 20)];
        noticeLab.text = @"功能正在开通中,敬请期待......";
        noticeLab.textAlignment = NSTextAlignmentCenter;
        noticeLab.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
        noticeLab.font = [UIFont systemFontOfSize:16.0];
        [self.view addSubview:noticeLab];
        [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            noticeLab.alpha = 0.0;
        } completion:^(BOOL finished){
            [noticeLab removeFromSuperview];
            self.table.alpha = 1.0;
        }];
    }
    else if(indexPath.section == 2 && indexPath.row == 1)
    {
        [self pushWebViewWithURL:CARVALUE andIsCreateTabBar:YES andNaviType:@"discover" andWebTitle:@"爱车估值"];
    }
    else if(indexPath.section == 3 && indexPath.row == 0)
    {
        [self pushWebViewWithURL:CARMARKET andIsCreateTabBar:YES andNaviType:@"discover" andWebTitle:@"车商城"];
    }
    else if(indexPath.section == 3 && indexPath.row == 1)
    {
        [self pushWebViewWithURL:CARKEEPHEALTH andIsCreateTabBar:YES andNaviType:@"discover" andWebTitle:@"足不出户为爱车养护"];
    }
    else if(indexPath.section == 4)
    {
        [self pushWebViewWithURL:ELECTRICALCAR andIsCreateTabBar:YES andNaviType:@"discover" andWebTitle:@"电动车之家"];
    }
}

- (void)pushWebViewWithURL:(NSString *)url andIsCreateTabBar:(BOOL)isCreateTabBar andNaviType:(NSString *)navaType andWebTitle:(NSString *)webTitle
{
    WebViewVC * webView = [[WebViewVC alloc] init];
    webView.itemType = 200;
    webView.URL = url;
    webView.isCreateTabBar = isCreateTabBar;
    webView.navigationType = navaType;
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.webTitle.text = webTitle;
    [self.navigationController pushViewController:webView animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section != 5)
    {
        return 50.0;
    }
    else
    {
        return 105.0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc] init];
    header.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
    if(section != 5)
    {
        header.frame = CGRectMake(0, 0, SCREEN_W, 15);
    }
    else
    {
        header.frame = CGRectMake(0, 0, SCREEN_W, 38);
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 38)];
        label.text = @"应用推荐";
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:14.0];
        [header addSubview:label];
        
        UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(SCREEN_W-55, 0, 50, 38);
        [moreBtn setTitle:@"更多＞" forState:UIControlStateNormal];
        [moreBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        moreBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [header addSubview:moreBtn];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section != 5)
    {
        return 15.0;
    }
    else
    {
        return 38.0;
    }
}

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
