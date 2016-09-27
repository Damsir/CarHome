//
//  AHFindCarResultVC.m
//  AutoHome
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHFindCarResultVC.h"
#import "AHFindResultCell.h"
#import "AHFindResultSiftCell.h"
#import "WebViewVC.h"

@interface AHFindCarResultVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * dataArray;
    NSArray * siftDataArray;
    UIView * backView;
    UIView * siftView;
    UITableView * siftTable;
    NSDictionary * dataDict;
    
    NSInteger page;
}

@property (strong, nonatomic)UITableView *table;

@end

@implementation AHFindCarResultVC

- (id)init
{
    if(self = [super init])
    {
        self.loadData = [LoadNetData new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSLog(@"%@",self.loadData.URL);
    [self.topBtnView addSubview:self.backBtn];
    self.titleLab.text = @"筛选结果";
    [self.topBtnView addSubview:self.titleLab];
    
    [self initSelf];
    [self tableRegister];
    [self loadNetData];
    
}

- (void)createNilImageView
{
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBtnView.frame), SCREEN_W, SCREEN_H-self.topBtnView.frame.size.height)];
    [self.view addSubview:backView];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_W-158)/2.0,(SCREEN_H-self.topBtnView.frame.size.height-250)/2.0, 158, 158)];
    imageView.image = [UIImage imageNamed:@"page_icon_empty"];
    [backView addSubview:imageView];
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x, CGRectGetMaxY(imageView.frame)+15, 158, 20)];
    lab.text = @"暂无内容";
    lab.textColor = [UIColor lightGrayColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:lab];
}

- (void)initSelf
{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBtnView.frame)+40, SCREEN_W, SCREEN_H-self.topBtnView.frame.size.height-60) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.table addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.table addFooterWithTarget:self action:@selector(footerLoadMore)];
    
    siftTable = [UITableView new];
    siftTable.dataSource = self;
    siftTable.delegate = self;
    siftTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    dataArray = [NSArray new];
    siftDataArray = [NSArray new];
    
    dataDict = [NSDictionary new];
    
    page = 20;
}

- (void)tableRegister
{
    UINib * nib = [UINib nibWithNibName:@"AHFindResultCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"AHFindResultCell"];
    
    UINib * nib1 = [UINib nibWithNibName:@"AHFindResultSiftCell" bundle:nil];
    [siftTable registerNib:nib1 forCellReuseIdentifier:@"AHFindResultSiftCell"];
}

//刷新
- (void)headerRefresh
{
    [self loadNetData];
}

//ttp://app.api.autohome.com.cn/autov4.9.8/cars/searchcars-pm2-mip0-map0-l-c-b-st-dsc-conf-o2-p1-s20-bid-f-driv-numseats.json

//加载更多
- (void)footerLoadMore
{
    page += 10;
    [self show];
    NSMutableString * newUrl = [NSMutableString stringWithString:self.loadData.URL];
    NSRange range = [self.loadData.URL rangeOfString:[NSString stringWithFormat:@"s%ld",page-10]];
    [newUrl replaceCharactersInRange:range withString:[NSString stringWithFormat:@"s%ld",page]];
    self.loadData.URL = newUrl;
    NSLog(@"%@",self.loadData.URL);
    __weak typeof(*&self)weakSelf = self;
    [self.loadData loadCarInfo2:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [weakSelf.table footerEndRefreshing];
            dataArray = self.loadData.dataDict[@"seriesitems"];
            [weakSelf.table reloadData];
            [weakSelf hide];
        }
    } withJsonUrl:@"result"];
}

- (void)loadNetData
{
    [self show];
    __weak typeof(*&self)weakSelf = self;
    [self.loadData loadCarInfo2:^(BOOL isSuccess, NSError *error) {
        if(isSuccess)
        {
            [weakSelf.table headerEndRefreshing];
            dataArray = self.loadData.dataDict[@"seriesitems"];
            if(dataArray.count != 0)
            {
                [self createMainWindow];
                [weakSelf.table reloadData];
                [weakSelf hide];
            }
            else
            {
                [self createNilImageView];
            }
        }
    } withJsonUrl:@"result"];
}

- (void)createMainWindow
{
    NSArray * topBtnTitle = @[@"关注高",@"价格低",@"价格高"];
    for(int i=0; i<3; i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*SCREEN_W/3.0, CGRectGetMaxY(self.topBtnView.frame), SCREEN_W/3.0, 40);
        [button setTitle:topBtnTitle[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1.0];
        [self.view addSubview:button];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [backView removeFromSuperview];
}

- (void)createCarSiftView
{
    [siftView removeFromSuperview];
    siftView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_W, 100, SCREEN_W-50, SCREEN_H-100)];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        siftView.frame = CGRectMake(50, siftView.frame.origin.y, siftView.frame.size.width, siftView.frame.size.height);
    } completion:^(BOOL finished){
        
    }];
    siftView.layer.borderWidth = 0.25;
    siftView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:siftView];
    
    UIView * siftTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, siftView.frame.size.width, 30)];
    siftTopView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    [siftView addSubview:siftTopView];
    
    UILabel * siftTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 60, siftTopView.frame.size.height)];
    siftTitleLab.text = @"选择车型";
    siftTitleLab.textAlignment = NSTextAlignmentCenter;
    siftTitleLab.textColor = [UIColor blackColor];
    siftTitleLab.font = [UIFont systemFontOfSize:14.0];
    [siftTopView addSubview:siftTitleLab];
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(siftTopView.frame.size.width-60, 0, 60, siftTopView.frame.size.height);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    closeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [closeBtn addTarget:self action:@selector(pressClose) forControlEvents:UIControlEventTouchUpInside];
    [siftTopView addSubview:closeBtn];
    
    siftTable.frame = CGRectMake(0, CGRectGetMaxY(siftTopView.frame), siftView.frame.size.width, siftView.frame.size.height-siftTopView.frame.size.height);
    [siftView addSubview:siftTable];
    
    siftView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [siftView addGestureRecognizer:swipe];
}

- (void)pressClose
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        siftView.frame = CGRectMake( SCREEN_W, siftView.frame.origin.y, siftView.frame.size.width, siftView.frame.size.height);
    } completion:^(BOOL finished){
        [siftView removeFromSuperview];
    }];
}

- (void)swipe:(UIGestureRecognizer *)swipe
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        swipe.view.frame = CGRectMake( SCREEN_W, swipe.view.frame.origin.y, swipe.view.frame.size.width, swipe.view.frame.size.height);
    } completion:^(BOOL finished){
        [swipe.view removeFromSuperview];
    }];
}

- (void)crateHeaderViewWithDict:(NSDictionary *)dict
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, siftView.frame.size.width, 100)];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17.5, 85, 65)];
    [imageView sd_setImageWithURL:dict[@"img"] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [headerView addSubview:imageView];
    
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, imageView.frame.origin.y+5, siftView.frame.size.width-imageView.frame.size.width-20-30, 20)];
    titleLab.text = dict[@"name"];
    titleLab.font = [UIFont systemFontOfSize:16.0];
    [headerView addSubview:titleLab];
    
    UILabel * priceLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.frame.origin.x, CGRectGetMaxY(titleLab.frame)+15, titleLab.frame.size.width, 20)];
    priceLab.text = dict[@"price"];
    priceLab.textColor = [UIColor colorWithRed:212.0/255.0 green:0 blue:16.0/255.0 alpha:1.0];
    priceLab.font = [UIFont systemFontOfSize:15.0];
    [headerView addSubview:priceLab];
    
    UIImageView * indicatorImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame), headerView.frame.size.height/2.0-10, 20, 20)];
    indicatorImage.image = [UIImage imageNamed:@"btn_icon_more"];
    [headerView addSubview:indicatorImage];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressHeaderView:)];
    [headerView addGestureRecognizer:tap];
    
    siftTable.tableHeaderView = headerView;
}

- (void)pressHeaderView:(UIGestureRecognizer *)tap
{
    WebViewVC * webView = [[WebViewVC alloc] init];
    webView.URL = [NSString stringWithFormat:@"%@%@/",SINGLECARDETAIL,dataDict[@"id"]];
    webView.itemType = 200;
    webView.isCreateTabBar = YES;
    webView.navigationType = @"findCar";
    webView.hidesBottomBarWhenPushed = YES;
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.webTitle.text = @"综述";
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == siftTable)
    {
        return siftDataArray.count;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.table)
    {
        return dataArray.count;
    }
    else
    {
        return [[siftDataArray[section] objectForKey:@"specitems"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.table)
    {
        AHFindResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHFindResultCell"];
        NSDictionary * dict = dataArray[indexPath.row];
        [cell setUIWithDict:dict];
        return cell;
    }
    else
    {
        AHFindResultSiftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHFindResultSiftCell"];
        NSDictionary * dict = [[siftDataArray[indexPath.section] objectForKey:@"specitems"] objectAtIndex:indexPath.row];
        [cell setUIWithDict:dict];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.table)
    {
        siftDataArray = [dataArray[indexPath.row] objectForKey:@"specitemgroups"];
        [self createCarSiftView];
        dataDict = dataArray[indexPath.row];
        [self crateHeaderViewWithDict:dataDict];
        [siftTable reloadData];
    }//ttp://app.api.autohome.com.cn/autov4.9.8/cars/specsummary-pm2-s22041-c420100.json
    else
    {
        NSDictionary * dict = [[siftDataArray[indexPath.section] objectForKey:@"specitems"] objectAtIndex:indexPath.row];
        self.loadData.URL = [NSString stringWithFormat:@"%@%@-c420100.json",FINDRESULTURL,dict[@"id"]];
        [self.loadData loadCarInfo2:^(BOOL isSuccess, NSError *error) {
            
            
            WebViewVC * webView = [[WebViewVC alloc] init];
            webView.URL = [NSString stringWithFormat:@"%@%@/",DISCOUNTDETAILURL,[[[siftDataArray[indexPath.section] objectForKey:@"specitems"] objectAtIndex:indexPath.row] objectForKey:@"id"]];
            webView.itemType = 200;
            webView.isCreateTabBar = YES;
            webView.navigationType = @"findCarDetail";
            webView.hidesBottomBarWhenPushed = YES;
            webView.view.backgroundColor = [UIColor whiteColor];
            webView.webTitle.text = @"车型报价";
            
            for (NSDictionary * dict in self.loadData.dataDict[@"dealerlist"]) {
                [webView.mapLatitudeArray addObject:dict[@"lat"]];
                [webView.mapLongtitudeArray addObject:dict[@"lon"]];
                [webView.mapAnnotationTitleArray addObject:dict[@"shortname"]];
                [webView.mapAnnotationSubTitleArray addObject:dict[@"price"]];
            }
            [self.navigationController pushViewController:webView animated:YES];
            
        } withJsonUrl:@"result"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.table)
    {
        return 95.0;
    }
    else
    {
        return 70.0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == siftTable)
    {
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-50, 40)];
        header.backgroundColor = [UIColor whiteColor];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, header.frame.size.width, 10)];
        lab.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [header addSubview:lab];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(lab.frame), header.frame.size.width, 30)];
        label.text = [siftDataArray[section] objectForKey:@"groupname"];
        label.font = [UIFont systemFontOfSize:13.0];
        label.textColor = [UIColor darkGrayColor];
        [header addSubview:label];
        return header;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == siftTable)
    {
        return 40.0;
    }
    else
    {
        return 0;
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
