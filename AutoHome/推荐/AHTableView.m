//
//  AHTableView.m
//  AutoHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHTableView.h"
#import "ArticleTableViewCell.h"
#import "AHRecommdendPictureCell.h"

@implementation AHTableView

- (id)initWithFrame:(CGRect)frame andDifferentPage:(AHDIFFERENTPage)page
{
    if(self = [super initWithFrame:frame])
    {
        self.loadData = [LoadNetData new];
        self.loadData.differentPage = page;
        [self initSelf];
        [self createWindow];
    }
    return self;
}

- (void)initSelf
{
    focusImage = [NSArray new];
    newsList = [NSArray new];
    topNewsInfo = [NSDictionary new];
    pageController = [UIPageControl new];
}

- (void)createWindow
{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.table addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.table addFooterWithTarget:self action:@selector(footerLoadMore)];
    [self addSubview:self.table];
    [self tableRegister];
    [self loadHomePageData];
}

- (void)tableRegister
{
    UINib * nib1 = [UINib nibWithNibName:@"ArticleTableViewCell" bundle:nil];
    [self.table registerNib:nib1 forCellReuseIdentifier:@"ArticleTableViewCell"];
    
    [self.table registerClass:[AHRecommdendPictureCell class] forCellReuseIdentifier:@"AHRecommdendPictureCell"];
}

- (void)createHeaderView
{
    UIView * headerView = [[UIView alloc] init];
    if(topNewsInfo.count != 0)
    {
        headerView.Frame = CGRectMake(0, 0, SCREEN_W, 250);
    }
    else
    {
        headerView.Frame = CGRectMake(0, 0, SCREEN_W, 160);
    }
    topScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 160)];
    topScroll.delegate = self;
    topScroll.bounces = NO;
    topScroll.showsHorizontalScrollIndicator = NO;
    topScroll.showsVerticalScrollIndicator = NO;
    topScroll.pagingEnabled = YES;
    topScroll.contentSize = CGSizeMake(SCREEN_W*focusImage.count, topScroll.frame.size.height);
    for(int i=0; i<focusImage.count; i++)
    {
        NSDictionary * dict = focusImage[i];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_W, 0, SCREEN_W, topScroll.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"imgurl"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressAD:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        imageView.tag = 1000+i;
        [topScroll addSubview:imageView];
    }
    [headerView addSubview:topScroll];
    
    pageController.frame = CGRectMake(50, 140, SCREEN_W-100, 20);
    pageController.numberOfPages = focusImage.count;
    pageController.currentPage = 0;
    pageController.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageController.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageController.userInteractionEnabled =NO;
    [headerView addSubview:pageController];
    
    UIView * saleView = [[UIView alloc] init];
    if(topNewsInfo.count != 0)
    {
        saleView.Frame = CGRectMake(0, CGRectGetMaxY(topScroll.frame), SCREEN_W, 90);
    }
    [headerView addSubview:saleView];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7, 94, 76)];
    [imageView sd_setImageWithURL:topNewsInfo[@"smallpic"]];
    [saleView addSubview:imageView];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 8, saleView.frame.size.width-CGRectGetMaxX(imageView.frame)-10, 46)];
    title.text = topNewsInfo[@"title"];
    title.font = [UIFont systemFontOfSize:17.0];
    title.numberOfLines = 2;
    title.textColor = [UIColor colorWithRed:255.0/255.0 green:47.0/255.0 blue:18.0/255.0 alpha:1.0];
    [saleView addSubview:title];
    UILabel * time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, CGRectGetMaxY(title.frame)+5, 90, 20)];
    time.text = topNewsInfo[@"time"];
    time.textColor = [UIColor darkGrayColor];
    time.font = [UIFont systemFontOfSize:15.0];
    [saleView addSubview:time];
    UILabel * type = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W-90, time.frame.origin.y, 80, 20)];
    type.text = topNewsInfo[@"type"];
    type.textColor = [UIColor colorWithRed:255.0/255.0 green:47.0/255.0 blue:18.0/255.0 alpha:1.0];
    type.font = [UIFont systemFontOfSize:15.0];
    type.textAlignment = NSTextAlignmentRight;
    [saleView addSubview:type];
    UILabel * line = [[UILabel alloc] init];
    if(topNewsInfo.count != 0)
    {
        line.Frame = CGRectMake(10, CGRectGetMaxY(imageView.frame)+5, SCREEN_W-10, 1);
    }
    line.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:221.0/255.0 alpha:1.0];
    [saleView addSubview:line];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressSale:)];
    [saleView addGestureRecognizer:tap];
    
    self.table.tableHeaderView = headerView;
}

- (void)pressSale:(UIGestureRecognizer *)tap
{
    WebViewVC * webView = [[WebViewVC alloc] init];
    webView.URL = topNewsInfo[@"jumpurl"];
    webView.itemType = 200;
    webView.isCreateTabBar = NO;
    webView.navigationType = @"recommend";
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.titleLab.text = @"最新";
    [self.delegate pushViewController:webView];
}

- (void)pressAD:(UIGestureRecognizer *)tap
{
    NSDictionary * dict = focusImage[tap.view.tag-1000];
    WebViewVC * webView = [[WebViewVC alloc] init];
    switch ([dict[@"mediatype"] integerValue]) {
        case 1:
            webView.URL = [NSString stringWithFormat:@"http://m.autohome.com.cn/drive/201510/%@.html",dict[@"id"]];
            break;
        case 2:
            webView.URL = [NSString stringWithFormat:@"http://v.m.autohome.com.cn/v_0_%@.html?from=pc",dict[@"id"]];
            break;
        case 3:
            webView.URL = [NSString stringWithFormat:@"http://v.m.autohome.com.cn/v_0_%@.html?from=pc",dict[@"id"]];
            break;
        case 4:
            webView.URL = [NSString stringWithFormat:@"http://club.m.autohome.com.cn/bbs/thread-c-%@-%@-1.html",dict[@"pageindex"],dict[@"id"]];
            break;
        case 5:
            webView.URL = [NSString stringWithFormat:@"http://club.m.autohome.com.cn/bbs/thread-c-%@-%@-1.html",dict[@"pageindex"],dict[@"id"]];
            break;
        case 6:
            webView.URL = [NSString stringWithFormat:@"http://car.m.autohome.com.cn/pic/view.html#!/series/3789/i%@",dict[@"id"]];
            break;
        case 7:
            webView.URL = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov4.9.8/content/News/fastnewscontent-n%@-lastid0-o0.json",dict[@"id"]];
            break;
        case 10:
            webView.URL = [NSString stringWithFormat:@"http://car.m.autohome.com.cn/pic/view.html#!/series/3789/i%@",dict[@"id"]];
            break;
        default:
            break;
    }
    webView.itemType = 200;
    webView.isCreateTabBar = NO;
    webView.navigationType = @"recommend";
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.titleLab.text = @"最新";
    [self.delegate pushViewController:webView];
}

//刷新
- (void)headerRefresh
{
    [self loadHomePageData];
}

//加载更多
- (void)footerLoadMore
{
    [self show];
    __weak typeof(*&self)weakSelf = self;
    self.loadData.differentPage = AHRECOMMEND1;
    [self.loadData loadMoreCarInfor:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [weakSelf.table footerEndRefreshing];
            focusImage = weakSelf.loadData.dataDict[@"focusimg"];
            newsList = weakSelf.loadData.dataDict[@"newslist"];
            topNewsInfo = weakSelf.loadData.dataDict[@"topnewsinfo"];
            [weakSelf.table reloadData];
            [weakSelf hide];
            [weakSelf createHeaderView];
        }
    } withJsonUrl:@"result"];
}

- (void)loadHomePageData
{
    [self show];
    __weak typeof(*&self)weakSelf = self;
    self.loadData.differentPage = AHRECOMMEND1;
    [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [weakSelf.table headerEndRefreshing];
            focusImage = weakSelf.loadData.dataDict[@"focusimg"];
            newsList = weakSelf.loadData.dataDict[@"newslist"];
            topNewsInfo = weakSelf.loadData.dataDict[@"topnewsinfo"];
            [weakSelf.table reloadData];
            [weakSelf hide];
            [weakSelf createHeaderView];
        }
    } withJsonUrl:@"result"];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = newsList[indexPath.row];
    if([dict[@"mediatype"] integerValue] == 6)
    {
        AHRecommdendPictureCell * cell = [[AHRecommdendPictureCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AHRecommdendPictureCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"AHRecommdendPictureCell"];
        [cell setUIWithDict:dict];
        return cell;
    }
    else if([dict[@"mediatype"] integerValue] == 10)
    {
        AHRecommdendPictureCell * cell = [[AHRecommdendPictureCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AHRecommdendPictureCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"AHRecommdendPictureCell"];
        [cell setUIWithNewDict:dict];
        return cell;
    }
    else
    {
        ArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleTableViewCell"];
        [cell setUIWithDict:dict];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewVC * webView = [[WebViewVC alloc] init];
    NSDictionary * dict = newsList[indexPath.row];
    switch ([dict[@"mediatype"] integerValue]) {
        case 1:
            webView.URL = [NSString stringWithFormat:@"http://m.autohome.com.cn/drive/201510/%@.html",dict[@"id"]];
            break;
        case 2:
            webView.URL = [NSString stringWithFormat:@"http://shuoke.autohome.com.cn/article/%@.html",dict[@"id"]];
            break;
        case 3:
            webView.URL = [NSString stringWithFormat:@"http://v.m.autohome.com.cn/v_0_%@.html?from=pc",dict[@"id"]];
            break;
        case 4:
            webView.URL = [NSString stringWithFormat:@"http://club.m.autohome.com.cn/bbs/thread-c-%@-%@-1.html",dict[@"jumppage"],dict[@"id"]];
            break;
        case 5:
            webView.URL = [NSString stringWithFormat:@"http://club.m.autohome.com.cn/bbs/thread-c-%@-%@-1.html",dict[@"jumppage"],dict[@"id"]];
            break;
        case 6:
            webView.URL = [NSString stringWithFormat:@"http://car.m.autohome.com.cn/pic/view.html#!/series/3789/i%@",dict[@"id"]];
            break;
        case 7:
            webView.URL = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov4.9.8/content/News/fastnewscontent-n%@-lastid0-o0.json",dict[@"id"]];
            break;
        case 10:
            webView.URL = [NSString stringWithFormat:@"http://car.m.autohome.com.cn/pic/view.html#!/series/3789/i%@",dict[@"id"]];
            break;
        default:
            break;
    }
    webView.itemType = 200;
    webView.isCreateTabBar = NO;
    webView.navigationType = @"recommend";
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.titleLab.text = @"最新";
    [self.delegate pushViewController:webView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = newsList[indexPath.row];
    if([dict[@"mediatype"] integerValue] != 6 && [dict[@"mediatype"] integerValue] != 10)
    {
        return 90.0;
    }
    else
    {
        return 165.0;
    }
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == topScroll)
    {
        pageController.currentPage = scrollView.contentOffset.x/SCREEN_W;
    }
}

@end













