//
//  AHFindCarView1.m
//  AutoHome
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHFindCarView1.h"
#import "AHFindCarCell.h"
#import "AHCarDetailCell.h"
#import "WebViewVC.h"
#import "AppDelegate.h"

@implementation AHFindCarView1

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self createWindow];
    }
    return self;
}

- (void)createWindow
{
    [self initSelf];
    [self createHeaderView];
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, self.frame.size.height) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.bounces = NO;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.table.tableHeaderView = headerView;
    [self addSubview:self.table];
    UINib * nib = [UINib nibWithNibName:@"AHFindCarCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"AHFindCarCell"];
    
    UINib * nib1 = [UINib nibWithNibName:@"AHCarDetailCell" bundle:nil];
    [allTypeTable registerNib:nib1 forCellReuseIdentifier:@"AHCarDetailCell"];
    [self loadNetData];
}

- (void)initSelf
{
    self.loadData = [LoadNetData new];
    allTypeTable = [UITableView new];
    brandListArray = [NSArray new];
    focusListArray = [NSArray new];
    hotBrandDict = [NSDictionary new];
    hotSeriesArray = [NSArray new];
    fctlistArray = [NSArray new];
    segment = [[UISegmentedControl alloc] initWithItems:@[@"在售",@"全部"]];
    flagBrandDict = [NSDictionary new];
    flagHotDict = [NSDictionary new];
    flag = NO;
    pageController = [UIPageControl new];
    suoYinArray = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z", nil];
}

- (void)loadNetData
{
    self.loadData.differentPage = AHFINDCARAD;
    [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            focusListArray = self.loadData.dataDict[@"focusList"];
            if(focusListArray.count != 0)
            {
                [self createADScroll];
            }
            [self.table reloadData];
        }
    } withJsonUrl:@"result"];
    
    self.loadData.differentPage = AHFINDCARBRAND;
    [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
        brandListArray = self.loadData.dataDict[@"brandlist"];
        hotBrandDict = self.loadData.dataDict[@"hotbrand"];
        [self createHotCarView];
        [self.table reloadData];
    } withJsonUrl:@"result"];
    
    self.loadData.differentPage = AHFINDCARMAIN;
    [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
        hotSeriesArray = self.loadData.dataDict[@"hotseries"];
        [self createMainCarView];
        [self.table reloadData];
    } withJsonUrl:@"result"];
    
}

- (void)createADScroll
{
    adScroll.contentSize = CGSizeMake(focusListArray.count*SCREEN_W, adScroll.frame.size.height);
    for(int i=0; i<focusListArray.count; i++)
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_W, 0, SCREEN_W, adScroll.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[focusListArray[i] objectForKey:@"focusimageurl"]]];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressTopAD:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 1000+i;
        [adScroll addSubview:imageView];
    }
    pageController.numberOfPages = focusListArray.count;

}

- (void)pressTopAD:(UIGestureRecognizer *)tap
{
    NSDictionary * dict = focusListArray[tap.view.tag-1000];
    WebViewVC * webView = [[WebViewVC alloc] init];
    webView.itemType = 200;
    webView.URL = dict[@"focusnewsurl"];
    webView.isCreateTabBar = YES;
    webView.navigationType = @"discover";
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    [self.delegate pushViewController:webView];
}

- (void)createHotCarView
{
    int count = 0;
    for(int i=0; i<2; i++)
    {
        for(int j=0; j<5; j++)
        {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(j*(SCREEN_W/5), i*77, SCREEN_W/5, 77)];
            view.backgroundColor = [UIColor whiteColor];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressHotCar:)];
            [view addGestureRecognizer:tap];
            view.tag = 2000+count;
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[[hotBrandDict[@"hotbrandlist"] objectAtIndex:count] objectForKey:@"imgurl"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
            [view addSubview:imageView];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), 60, 17)];
            label.text = [[hotBrandDict[@"hotbrandlist"] objectAtIndex:count] objectForKey:@"name"];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14.0];
            [view addSubview:label];
            [middleBtnView2 addSubview:view];
            count++;
        }
    }
}

- (void)pressHotCar:(UIGestureRecognizer *)tap
{
    flag = YES;
    flagHotDict = [hotBrandDict[@"hotbrandlist"] objectAtIndex:tap.view.tag-2000];
    self.loadData.URL = [NSString stringWithFormat:@"%@%@-t1.json",CARDETAIL,flagHotDict[@"id"]];
    [self createCarTypeView];
}

- (void)createMainCarView
{
    for(int i=0; i<3; i++)
    {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i*(SCREEN_W/3.0), 0, SCREEN_W/3.0, middleBtnView3.frame.size.height)];
        view.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressMainCar:)];
        [view addGestureRecognizer:tap];
        view.tag = 3000+i;
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W/3.0, 90)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[hotSeriesArray[i] objectForKey:@"serieslogo"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        [view addSubview:imageView];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), SCREEN_W/3.0, 20)];
        label.text = [hotSeriesArray[i] objectForKey:@"seriesname"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.0];
        [view addSubview:label];
        [middleBtnView3 addSubview:view];
    }
}

- (void)pressMainCar:(UIGestureRecognizer *)tap
{
    NSDictionary * dict = hotSeriesArray[tap.view.tag-3000];
    WebViewVC * webView = [[WebViewVC alloc] init];
    webView.URL = [NSString stringWithFormat:@"%@%@/",SINGLECARDETAIL,dict[@"seriesid"]];
    webView.itemType = 200;
    webView.isCreateTabBar = YES;
    webView.navigationType = @"findCar";
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.webTitle.text = @"综述";
    [self.delegate pushViewController:webView];
}

- (void)createCarTypeView
{
    [allTypeView removeFromSuperview];
    [self.delegate stopScroll];
    allTypeView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W-50, self.frame.size.height)];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        allTypeView.frame = CGRectMake(50, allTypeView.frame.origin.y, allTypeView.frame.size.width, allTypeView.frame.size.height);
    } completion:^(BOOL finished){

    }];
    
    allTypeView.layer.borderWidth = 0.25;
    allTypeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    allTypeView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    [self addSubview:allTypeView];
    
    UIView * segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, allTypeView.frame.size.width, 40)];
    segmentView.backgroundColor = [UIColor whiteColor];
    [allTypeView addSubview:segmentView];
    
    segment.frame = CGRectMake(5, 5, segmentView.frame.size.width-10, 30);
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(valuechange:) forControlEvents:UIControlEventValueChanged];
    [segmentView addSubview:segment];
    
    allTypeTable.frame = CGRectMake(0, CGRectGetMaxY(segmentView.frame), allTypeView.frame.size.width, allTypeView.frame.size.height-segmentView.frame.size.height-10);
    allTypeTable.dataSource = self;
    allTypeTable.delegate = self;
    allTypeTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [allTypeView addSubview:allTypeTable];
    
    allTypeView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [allTypeView addGestureRecognizer:swipe];
    
    [self.loadData loadCarInfo2:^(BOOL isSuccess, NSError *error) {
        fctlistArray = self.loadData.dataDict[@"fctlist"];
        [allTypeTable reloadData];
    } withJsonUrl:@"result"];
}

- (void)valuechange:(UISegmentedControl *)seg
{
    if(flag == NO)
    {
        if(segment.selectedSegmentIndex == 0)
        {
            self.loadData.URL = [NSString stringWithFormat:@"%@%@-t1.json",CARDETAIL,flagBrandDict[@"id"]];
        }
        else
        {
            self.loadData.URL = [NSString stringWithFormat:@"%@%@-t2.json",CARDETAIL,flagBrandDict[@"id"]];
        }
    }
    else
    {
        if(segment.selectedSegmentIndex == 0)
        {
            self.loadData.URL = [NSString stringWithFormat:@"%@%@-t1.json",CARDETAIL,flagHotDict[@"id"]];
        }
        else
        {
            self.loadData.URL = [NSString stringWithFormat:@"%@%@-t2.json",CARDETAIL,flagHotDict[@"id"]];
        }
    }
    [self.loadData loadCarInfo2:^(BOOL isSuccess, NSError *error) {
        fctlistArray = self.loadData.dataDict[@"fctlist"];
        [allTypeTable reloadData];
    } withJsonUrl:@"result"];
}

- (void)swipe:(UIGestureRecognizer *)swipe
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        swipe.view.frame = CGRectMake( SCREEN_W, swipe.view.frame.origin.y, swipe.view.frame.size.width, swipe.view.frame.size.height);
    } completion:^(BOOL finished){
        [swipe.view removeFromSuperview];
    }];
    [self.delegate starScroll];
}

- (void)createHeaderView
{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 450)];
    headerView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0  blue:239.0/255.0  alpha:1.0];
    
    adScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 110)];
    adScroll.delegate = self;
    adScroll.bounces = NO;
    adScroll.showsVerticalScrollIndicator = NO;
    adScroll.showsHorizontalScrollIndicator = NO;
    adScroll.pagingEnabled = YES;
    [headerView addSubview:adScroll];
    
    pageController.frame = CGRectMake(50, 90, SCREEN_W-100, 20);
    pageController.currentPage = 0;
    pageController.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageController.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageController.userInteractionEnabled =NO;
    [headerView addSubview:pageController];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(adScroll.frame), SCREEN_W, 30)];
    label1.backgroundColor = [UIColor whiteColor];
    label1.text = @"热门品牌";
    label1.textColor = [UIColor grayColor];
    [headerView addSubview:label1];
    
    middleBtnView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), SCREEN_W, 155)];
    middleBtnView2.layer.borderWidth = 0.25;
    middleBtnView2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [headerView addSubview:middleBtnView2];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(middleBtnView2.frame)+10, SCREEN_W, 30)];
    label2.backgroundColor = [UIColor whiteColor];
    label2.text = @"主打车";
    label2.textColor = [UIColor grayColor];
    [headerView addSubview:label2];
    
    middleBtnView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame), SCREEN_W, 115)];
    middleBtnView3.layer.borderWidth = 0.25;
    middleBtnView3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [headerView addSubview:middleBtnView3];
}

#pragma mark - TableViewDelegae
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == allTypeTable)
    {
        return fctlistArray.count;
    }
    else
    {
        return brandListArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == allTypeTable)
    {
        return [[fctlistArray[section] objectForKey:@"serieslist"] count];
    }
    else
    {
        return [[brandListArray[section] objectForKey:@"list"] count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == allTypeTable)
    {
        NSDictionary * dict = [[fctlistArray[indexPath.section] objectForKey:@"serieslist"] objectAtIndex:indexPath.row];
        AHCarDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHCarDetailCell"];
        [cell setUIWithDict:dict];
        return cell;
    }
    else
    {
        NSDictionary * dict = [[brandListArray[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row];
        AHFindCarCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHFindCarCell"];
        [cell setUIWithDict:dict];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.table)
    {
        flag = NO;
        flagBrandDict = [[brandListArray[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row];
        self.loadData.URL = [NSString stringWithFormat:@"%@%@-t1.json",CARDETAIL,flagBrandDict[@"id"]];
        [self createCarTypeView];
    }
    else
    {
        NSDictionary * dict = [[fctlistArray[indexPath.section] objectForKey:@"serieslist"] objectAtIndex:indexPath.row];
        WebViewVC * webView = [[WebViewVC alloc] init];
        webView.URL = [NSString stringWithFormat:@"%@%@/",SINGLECARDETAIL,dict[@"id"]];
        webView.itemType = 200;
        webView.isCreateTabBar = YES;
        webView.navigationType = @"findCar";
        webView.hidesBottomBarWhenPushed = YES;
        webView.view.backgroundColor = [UIColor whiteColor];
        webView.webTitle.text = @"综述";
        [self.delegate pushViewController:webView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc] init];
    header.backgroundColor = [UIColor whiteColor];
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 10)];
    lab.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    [header addSubview:lab];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    title.font = [UIFont systemFontOfSize:13.0];
    title.textColor = [UIColor darkGrayColor];
    [header addSubview:title];
    if(tableView == allTypeTable)
    {
        title.text = [fctlistArray[section] objectForKey:@"name"];
    }
    else
    {
        title.text = [brandListArray[section] objectForKey:@"letter"];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(tableView == self.table)
    {
        return suoYinArray;
    }
    else
    {
        return nil;
    }
}

#pragma ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == adScroll)
    {
        pageController.currentPage = scrollView.contentOffset.x/SCREEN_W;
    }
}

@end



























