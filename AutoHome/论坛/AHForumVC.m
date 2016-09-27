//
//  AHForumVC.m
//  AutoHome
//
//  Created by qianfeng on 15/9/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHForumVC.h"
#import "AHForumTableViewCell.h"
#import "QFRequestManger.h"
#import "AHForumHotCell.h"
#import "WebViewVC.h"

@interface AHForumVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSArray * forumHotList;
    UIScrollView * backScroll;
    UITableView * table1;
    UITableView * table2;
    NSDictionary * resultDict;
    NSMutableArray * listArray;
    
    NSInteger selectedTopBtnIndex;
    NSMutableArray * topBtnArray;
    UILabel * topBtnLine;
    NSInteger lastContentOffset;
    
    UIScrollView * topBtnScroll;
    NSMutableArray * middleBtnArray;
    NSInteger selectedMiddleBtnIndex;
}

@end

@implementation AHForumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSelf];
    [self createWindow];
    [self tableRegister];
    [self loadNetData];
}

- (void)initSelf
{
    forumHotList = [NSArray new];
    self.loadData = [LoadNetData new];
    self.loadData.differentPage = AHFORUM11;
    resultDict = [NSDictionary new];
    listArray = [NSMutableArray new];
    
    topBtnArray = [NSMutableArray new];
    selectedTopBtnIndex = 0;
    lastContentOffset = 0;
    
    selectedMiddleBtnIndex = 0;
    middleBtnArray = [NSMutableArray new];
}

- (void)tableRegister
{
    UINib * nib1 = [UINib nibWithNibName:@"AHForumTableViewCell" bundle:nil];
    [table1 registerNib:nib1 forCellReuseIdentifier:@"AHForumTableViewCell"];
    
    UINib * nib2 = [UINib nibWithNibName:@"AHForumHotCell" bundle:nil];
    [table2 registerNib:nib2 forCellReuseIdentifier:@"AHForumHotCell"];
}

- (void)pressTopBtn:(UIButton *)btn
{
    backScroll.contentOffset = CGPointMake((btn.tag-3000)*SCREEN_W, 0);
    [self scrollViewDidEndDecelerating:backScroll];
    if(selectedTopBtnIndex != 0)
    {
        UIButton * oldButton = (UIButton *)[self.topBtnView viewWithTag:selectedTopBtnIndex];
        [oldButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        oldButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    [btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    //记住上一次点击按钮的tag
    selectedTopBtnIndex = btn.tag;
}

- (void)createWindow
{
    NSArray * topBtnTitleArray = @[@"精选日报",@"热帖"];
    for(int i=0; i<2; i++)
    {
        UIButton * topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn.frame = CGRectMake(i*100, 3, 100, 37);
        [topBtn setTitle:topBtnTitleArray[i] forState:UIControlStateNormal];
        if(i == 0)
        {
            [topBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            topBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        }
        else
        {
            [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            topBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        }
        [topBtn addTarget:self action:@selector(pressTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        topBtn.tag = 3000+i;
        [topBtnArray addObject:topBtn];
        [self.topBtnView addSubview:topBtn];
    }
    
    topBtnLine = [[UILabel alloc] initWithFrame:CGRectMake(12, 38, 70, 2)];
    topBtnLine.backgroundColor = MAINCOLOR;
    [self.topBtnView addSubview:topBtnLine];
    
    backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBtnView.frame), SCREEN_W, SCREEN_H-self.topBtnView.frame.size.height-70)];
    backScroll.delegate = self;
    backScroll.bounces = NO;
    backScroll.pagingEnabled = YES;
    backScroll.showsHorizontalScrollIndicator = NO;
    backScroll.showsVerticalScrollIndicator = NO;
    backScroll.contentSize = CGSizeMake(2*SCREEN_W, backScroll.frame.size.height);
    [self.view addSubview:backScroll];
    
    UIView * middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    middleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    middleView.layer.borderWidth = 0.3;
    [backScroll addSubview:middleView];
    
    NSArray * topScrllTitleArray = @[@"全部",@"汽车之家十年",@"媳妇当车模",@"美人“记”",@"论坛名人堂",@"论坛讲师",@"精挑细选",@"现身说法",@"高端阵地",@"电动车",@"汇买车",@"行车点评",@"超级试驾员",@"海外购车",@"经典老车",@"妹子选车",@"优惠购车",@"原创大片",@"顶配风采",@"改装有理",@"养车有道",@"首发阵营",@"新车直播",@"历史选题",@"精彩视频",@"摩友天地",@"蜜月中旅",@"甜蜜婚礼",@"摄影课堂",@"车友聚会",@"单车部落",@"杂谈俱乐部",@"华北游记",@"西南游记",@"东北游记",@"西北游记",@"华中游记",@"华南游记",@"华东游记",@"港澳台游记",@"海外游记",@"沧海遗珠",];
    topBtnScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    topBtnScroll.bounces = NO;
    topBtnScroll.showsVerticalScrollIndicator = NO;
    topBtnScroll.showsHorizontalScrollIndicator = NO;
    topBtnScroll.pagingEnabled = NO;
    topBtnScroll.contentSize = CGSizeMake(42*90, topBtnScroll.frame.size.height);
    [middleView addSubview:topBtnScroll];
    for(int i=0; i<42; i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*90, 3, 90, 37);
        [button setTitle:topScrllTitleArray[i] forState:UIControlStateNormal];
        if(i == 0)
        {
            [button setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        }
        else
        {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        }
        [button addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000+i;
        [middleBtnArray addObject:button];
        [topBtnScroll addSubview:button];
    }
    
    table1 = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(middleView.frame), SCREEN_W, backScroll.frame.size.height-40)];
    table1.dataSource = self;
    table1.delegate = self;
    table1.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [table1 addHeaderWithTarget:self action:@selector(headerRefresh)];
    [table1 addFooterWithTarget:self action:@selector(footerLoadMore)];
    [backScroll addSubview:table1];
    
    table2 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, backScroll.frame.size.height) style:UITableViewStylePlain];
    table2.dataSource = self;
    table2.delegate = self;
    table2.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [table2 addHeaderWithTarget:self action:@selector(headerRefresh)];
    [table2 addFooterWithTarget:self action:@selector(footerLoadMore)];
    [backScroll addSubview:table2];
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 20)];
    header.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:203.0/255.0 blue:214.0/255.0 alpha:1.0];
    UILabel * headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, SCREEN_W, 20)];
    headerTitle.text = @"24小时内热门";
    headerTitle.textColor = [UIColor darkGrayColor];
    headerTitle.font = [UIFont systemFontOfSize:13.0];
    [header addSubview:headerTitle];
    table2.tableHeaderView = header;
    
}

- (void)pressBtn:(UIButton *)btn
{
    if(btn.tag != 1000)
    {
        UIButton * button = (UIButton *)[topBtnScroll viewWithTag:1000];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    if(selectedMiddleBtnIndex != 0)
    {
        UIButton * oldButton = (UIButton *)[topBtnScroll viewWithTag:selectedMiddleBtnIndex];
        [oldButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        oldButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    [btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    //记住上一次点击按钮的tag
    selectedMiddleBtnIndex = btn.tag;
    
    NSArray * array = @[@"0",@"233",@"104",@"110",@"172",@"230",@"121",@"106",@"118",@"210",@"199",@"198",@"168",@"113",@"109",@"191",@"196",@"107",@"105",@"122",@"194",@"119",@"112",@"120",@"227",@"184",@"108",@"124",@"123",@"185",@"186",@"214",@"218",@"223",@"221",@"222",@"220",@"224",@"219",@"225",@"226",@"212"];
    NSString * url = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.9.8/club/jingxuantopic-pm2-c%@-p1-s20.json",array[btn.tag-1000]];
    [QFRequestManger requestWith:url success:^(NSData *data) {
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        resultDict = jsonDict[@"result"];
        listArray = resultDict[@"list"];
        [table1 reloadData];
    } failBlock:^(NSError *error) {
        
    }];
}

//刷新
- (void)headerRefresh
{
    [self loadNetData];
}

//加载更多
- (void)footerLoadMore
{
    [self show];
    __weak typeof(*&self)weakSelf = self;
    [self.loadData loadMoreCarInfor:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [table1 footerEndRefreshing];
            [listArray addObjectsFromArray:weakSelf.loadData.dataDict[@"list"]];
            [table1 reloadData];
            [weakSelf hide];
        }
    } withJsonUrl:@"result"];
}

- (void)loadNetData
{
    [self show];
    __weak typeof(*&self)weakSelf = self;
    [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [table1 headerEndRefreshing];
            listArray = [NSMutableArray arrayWithArray:weakSelf.loadData.dataDict[@"list"]];
            [table1 reloadData];
            [weakSelf hide];
        }
    } withJsonUrl:@"result"];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == table1)
    {
        return listArray.count;
    }
    else
    {
        return forumHotList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == table1)
    {
        AHForumTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHForumTableViewCell"];
        NSDictionary * dict = listArray[indexPath.row];
        [cell setUIWithDict:dict];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        AHForumHotCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHForumHotCell"];
        NSDictionary * dict = forumHotList[indexPath.row];
        [cell setUIWithDict:dict];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewVC * webView = [[WebViewVC alloc] init];
    NSDictionary * dict = [[NSDictionary alloc] init];
    if(tableView == table1)
    {
        dict = listArray[indexPath.row];
        webView.bbstype = dict[@"bbstype"];
    }
    else
    {
        dict = forumHotList[indexPath.row];
        webView.bbstype = @"c";
    }
    webView.itemID = dict[@"topicid"];
    webView.bbsID = dict[@"bbsid"];
    webView.itemType = 100;
    webView.isCreateTabBar = NO;
    webView.navigationType = @"forum";
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:webView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == table1)
    {
        return 90;
    }
    else
    {
        return 70;
    }
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == backScroll)
    {
        NSInteger index = backScroll.contentOffset.x/SCREEN_W;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            if(index == 1)
            {
                topBtnLine.frame = CGRectMake(index*100+30, topBtnLine.frame.origin.y, 40, topBtnLine.frame.size.height);
            }
            else
            {
                topBtnLine.frame = CGRectMake(index*100+14, topBtnLine.frame.origin.y, 70, topBtnLine.frame.size.height);
            }
        } completion:^(BOOL finished){
            
        }];
        for(int i=0; i<2; i++)
        {
            UIButton * button = topBtnArray[i];
            if(i == index)
            {
                [button setTitleColor:MAINCOLOR forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:17.0];
            }
            else
            {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:16.0];
            }
        }
        if(backScroll.contentOffset.x == 0)
        {
            self.loadData.differentPage = AHFORUM11;
            [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
                if(isSuccess)
                {
                    listArray = self.loadData.dataDict[@"list"];
                    [table1 reloadData];
                }
            } withJsonUrl:@"result"];
        }
        else if(backScroll.contentOffset.x == SCREEN_W)
        {
            self.loadData.differentPage = AHFORUMHOT;
            [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
                forumHotList = self.loadData.dataDict[@"list"];
                [table2 reloadData];
            } withJsonUrl:@"result"];
        }
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
