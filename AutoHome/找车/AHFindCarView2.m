//
//  AHFindCarView2.m
//  AutoHome
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHFindCarView2.h"
#import "AHFindCarSelectCell.h"
#import "AHFindCarSiftCell.h"
#import "LoadNetData.h"

@implementation AHFindCarView2

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
    [self createHeaderView];
    [self initSelf];
    [self tableRegister];
}

- (void)initSelf
{
    flag = 100;
    isDone = NO;
    isClear = NO;
    self.loadData = [LoadNetData new];
    siftTablesArray = [NSMutableArray new];
    brandListArray = [NSMutableArray new];
    NSArray * titleArray1 = @[@"不限",@"微型车",@"小型车",@"紧凑型车",@"中型车",@"中大型车",@"大型车",@"跑车",@"MPV",@"全部SUV",@"小型SUV",@"紧凑型SUV",@"中型SUV",@"中大型SUV",@"大型SUV",@"微面",@"微卡",@"轻客",@"皮卡"];
    NSArray * titleArray2 = @[@"不限",@"中国",@"德国",@"日本",@"美国",@"韩国",@"法国",@"英国",@"意大利",@"瑞典",@"荷兰",@"捷克",@"西班牙"];
    NSArray * titleArray3 = @[@"不限",@"手动",@"自动"];
    NSArray * titleArray4 = @[@"不限",@"两厢",@"三厢",@"掀背",@"旅行版",@"硬顶敞篷车",@"软顶敞篷车",@"硬顶跑车",@"客车",@"货车"];
    NSArray * titleArray5 = @[@"不限",@"天窗",@"电动调节座椅",@"ESP",@"疝气大灯",@"GPS导航",@"定速巡航",@"真皮座椅",@"倒车雷达",@"全自动空调",@"多功能方向盘"];
    NSArray * titleArray6 = @[@"不限",@"1.0L及以下",@"1.1-1.6L",@"1.7-2.0L",@"2.1-2.5L",@"2.6-3.0L",@"3.1-4.0L",@"4.0L以上"];
    NSArray * titleArray7 = @[@"不限",@"汽油",@"柴油",@"电动",@"油电混合"];
    NSArray * titleArray8 = @[@"不限",@"前驱",@"后驱",@"四驱"];
    NSArray * titleArray9 = @[@"不限",@"2座",@"4座",@"5座",@"6座",@"7座",@"7座以上"];
    allTitleArray = [NSArray arrayWithObjects:titleArray1,titleArray2,titleArray3,titleArray4,titleArray5,titleArray6,titleArray7,titleArray8,titleArray9, nil];
    
    suoYinArray = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z", nil];
    
    allSubTitleArray = [NSMutableArray new];
    for(int i=0; i<10; i++)
    {
        NSMutableArray * subTitleArray = [NSMutableArray new];
        [allSubTitleArray addObject:subTitleArray];
    }
    
    selectedItemsArray = [[NSMutableArray alloc] init];
    
    allIndexPathArray = [NSMutableArray new];
    for(int i=0; i<10; i++)
    {
        NSMutableArray * indexPathAry = [NSMutableArray new];
        NSMutableArray * termArray = [NSMutableArray new];
        [allIndexPathArray addObject:indexPathAry];
        [selectedItemsArray addObject:termArray];
    }
    
    dataArray = [NSArray new];
    
    minMoney = @"0";
    maxMoney = @"0";
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, self.frame.size.height-60) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.bounces = NO;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.table.tableHeaderView = headerView;
    [self addSubview:self.table];
    [self createBottomBtn];
    [self createSiftTables];
}

- (void)createBottomBtn
{
    BottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    BottomBtn.frame = CGRectMake(5, CGRectGetMaxY(self.table.frame)+10, SCREEN_W-10, 40);
    BottomBtn.backgroundColor = MAINCOLOR;
    [BottomBtn setTitle:[NSString stringWithFormat:@"筛选找车＞"] forState:UIControlStateNormal];
    [BottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    BottomBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    BottomBtn.layer.cornerRadius = 5.0;
    [BottomBtn addTarget:self action:@selector(pressFindBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:BottomBtn];
}

- (void)createSiftTables
{
    for(int i=0; i<10; i++)
    {
        UITableView * table = [[UITableView alloc] init];
        table.dataSource = self;
        table.delegate = self;
        table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [siftTablesArray addObject:table];
    }
}

- (void)tableRegister
{
    UINib * nib = [UINib nibWithNibName:@"AHFindCarSelectCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"AHFindCarSelectCell"];
    
    for(int i=0; i<10; i++)
    {
        UITableView * table = siftTablesArray[i];
        UINib * nib1 =[UINib nibWithNibName:@"AHFindCarSiftCell" bundle:nil];
        [table registerNib:nib1 forCellReuseIdentifier:@"AHFindCarSiftCell"];
    }
}

- (void)createHeaderView
{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 150)];
    UILabel * header2TopLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 10)];
    header2TopLab.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    [headerView addSubview:header2TopLab];
    UILabel * header2lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 40)];
    header2lab.text = @"价格";
    header2lab.font = [UIFont systemFontOfSize:15.0];
    header2lab.textColor = [UIColor blackColor];
    [headerView addSubview:header2lab];
    GWLCustomSliderNew *customSlider = [GWLCustomSliderNew customSliderWithDefalutMinValue:0 withDefalutMaxValue:100 andMinMaxCanSame:NO];
    customSlider.frame = CGRectMake(0, 70, SCREEN_W, 60);
    customSlider.delegate = self;
    self.customSlider = customSlider;
    [headerView addSubview:self.customSlider];
    
}

- (void)pressFindBtn
{
    [self.delegate pushViewControllerWithURL:self.loadData.URL];
}

- (void)createCarSiftViewWithIndex:(NSInteger)index
{
    [siftView removeFromSuperview];
    [self.delegate stopScroll];
    siftView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W-50, self.frame.size.height-60)];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        siftView.frame = CGRectMake(50, siftView.frame.origin.y, siftView.frame.size.width, siftView.frame.size.height);
    } completion:^(BOOL finished){
        
    }];
    
    siftView.layer.borderWidth = 0.25;
    siftView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    siftView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    [self addSubview:siftView];
    
    UIView * siftTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, siftView.frame.size.width, 40)];
    siftTopView.backgroundColor = [UIColor whiteColor];
    [siftView addSubview:siftTopView];
    
    UIButton * clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(5, 0, 80, siftTopView.frame.size.height);
    [clearBtn setTitle:@"清除全部" forState:UIControlStateNormal];
    [clearBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [clearBtn addTarget:self action:@selector(pressClearAll) forControlEvents:UIControlEventTouchUpInside];
    [siftTopView addSubview:clearBtn];
    
    siftTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 60, siftTopView.frame.size.height)];
    siftTitleLab.textAlignment = NSTextAlignmentCenter;
    siftTitleLab.textColor = [UIColor blackColor];
    siftTitleLab.font = [UIFont systemFontOfSize:14.0];
    [siftTopView addSubview:siftTitleLab];
    
    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(siftTopView.frame.size.width-60, 0, 60, siftTopView.frame.size.height);
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    doneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [doneBtn addTarget:self action:@selector(pressDone) forControlEvents:UIControlEventTouchUpInside];
    [siftTopView addSubview:doneBtn];
    
    UITableView * table = siftTablesArray[index];
    table.frame = CGRectMake(0, CGRectGetMaxY(siftTopView.frame), siftView.frame.size.width, siftView.frame.size.height-siftTopView.frame.size.height);
    [siftView addSubview:table];
    
    self.userInteractionEnabled = YES;
    siftView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [siftView addGestureRecognizer:swipe];
    
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

- (void)pressClearAll
{
    
}

- (void)pressDone
{
    [siftView removeFromSuperview];
    isDone = YES;
    [self.table reloadData];
    [self startLoadData];
}

- (void)startLoadData
{
    NSArray * arry = @[@"-l",@"-c",@"-b",@"-st",@"-dsc",@"-conf",@"-bid",@"-f",@"-driv",@"-numseats"];
    NSMutableString * mstr = [NSMutableString stringWithFormat:@"%@-mip%@-map%@",SELECTCAR,minMoney,maxMoney];
    
    for(int i=0; i<6; i++)
    {
        NSMutableString * str = [NSMutableString stringWithString:[selectedItemsArray[i] componentsJoinedByString:@","]];
        [str insertString:arry[i] atIndex:0];
        [mstr appendString:str];
    }
    [mstr appendString:@"-o2-p1-s20"];
    for(int i=6; i<10; i++)
    {
        NSMutableString * str = [NSMutableString stringWithString:[selectedItemsArray[i] componentsJoinedByString:@","]];
        [str insertString:arry[i] atIndex:0];
        [mstr appendString:str];
    }
    self.loadData.URL = [NSString stringWithFormat:@"%@.json",mstr];
    
    [self.loadData loadCarInfo2:^(BOOL isSuccess, NSError *error) {
        
        [BottomBtn setTitle:[NSString stringWithFormat:@"共%@个车系%@个车型",self.loadData.dataDict[@"rowcount"],self.loadData.dataDict[@"totalspeccount"]] forState:UIControlStateNormal];
        dataArray = self.loadData.dataDict[@"seriesitems"];
        
    } withJsonUrl:@"result"];
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView != self.table)
    {
        if(flag == 0)
        {
            return brandListArray.count;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView != self.table)
    {
        switch (flag) {
            case 0:
                return [[brandListArray[section] objectForKey:@"list"] count];
                break;
            case 1:
                return 19;
                break;
            case 2:
                return 13;
                break;
            case 3:
                return 3;
                break;
            case 4:
                return 10;
                break;
            case 5:
                return 11;
                break;
            case 6:
                return 8;
                break;
            case 7:
                return 5;
                break;
            case 8:
                return 4;
                break;
            case 9:
                return 7;
                break;
            default:
                return 0;
                break;
        }
    }
    else
    {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.table)
    {
        NSArray * titleArray = @[@"品牌",@"级别",@"国别",@"变速箱",@"结构",@"配置",@"排量",@"燃料",@"驱动",@"座位数"];
        AHFindCarSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHFindCarSelectCell"];
        cell.title.text = titleArray[indexPath.row];
        if(isDone == NO)
        {
            cell.subTitle.text = @"不限";
        }
        else
        {
            if([allSubTitleArray[indexPath.row] count] != 0)
            {
                NSString * str = [allSubTitleArray[indexPath.row] componentsJoinedByString:@","];
                cell.subTitle.text = str;
                cell.subTitle.textColor = MAINCOLOR;
            }
            else
            {
                cell.subTitle.text = @"不限";
                cell.subTitle.textColor = [UIColor darkGrayColor];
            }
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell initAttribute];
        return cell;
    }
    else
    {
        AHFindCarSiftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AHFindCarSiftCell"];
        if(flag == 0)
        {
            NSDictionary * dict = [[brandListArray[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row];
            if([allIndexPathArray[flag] indexOfObject:indexPath] != NSNotFound)
            {
                cell.isSelected = 1;
                [cell setUIWithDict:dict];
            }
            else
            {
                cell.isSelected = 0;
                [cell setUIWithDict:dict];
            }
        }
        else
        {
            cell.title.text = [allTitleArray[flag-1] objectAtIndex:indexPath.row];
            if([allIndexPathArray[flag] indexOfObject:indexPath] != NSNotFound)
            {
                cell.isSelected = 1;
                [cell initAttribute];
            }
            else
            {
                cell.isSelected = 0;
                [cell initAttribute];
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.table)
    {
        NSArray * titleArray = @[@"品牌",@"级别",@"国别",@"变速箱",@"结构",@"配置",@"排量",@"燃料",@"驱动",@"座位数"];
        flag = indexPath.row;
        [self createCarSiftViewWithIndex:indexPath.row];
        siftTitleLab.text = titleArray[indexPath.row];
        if(flag == 0)
        {
            self.loadData.differentPage = AHFINDCARBRAND;
            [self.loadData loadCarInfo1:^(BOOL isSuccess, NSError *error) {
                brandListArray = [[NSMutableArray alloc] initWithArray:self.loadData.dataDict[@"brandlist"]];
                NSDictionary * additionDict = @{@"letter":@"##",@"list":@[@{@"name":@"全部品牌"}]};
                [brandListArray insertObject:additionDict atIndex:0];
                [siftTablesArray[indexPath.row] reloadData];
            } withJsonUrl:@"result"];
        }
        else
        {
            [siftTablesArray[indexPath.row] reloadData];
        }
    }
    else
    {
        [allIndexPathArray[flag] addObject:indexPath];
        AHFindCarSiftCell * cell = (AHFindCarSiftCell *)[tableView cellForRowAtIndexPath:indexPath];
        if(cell.isSelected == 0)
        {
            [cell.leftBtn setImage:[UIImage imageNamed:@"btn_icon_select_true_new"] forState:UIControlStateNormal];
            cell.title.textColor = MAINCOLOR;
            cell.isSelected = 1;
            if(indexPath.section == 0 && indexPath.row == 0)
            {
                [selectedItemsArray[flag] removeAllObjects];
                
            }
            else
            {
                if(flag == 0)
                {
                    [allSubTitleArray[0] addObject:[[[brandListArray[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"name"]];
                }
                else
                {
                    [allSubTitleArray[flag] addObject:allTitleArray[flag-1][indexPath.row]];
                }
                if(flag == 0)
                {
                    [selectedItemsArray[6] addObject:[[[brandListArray[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"id"]];
                }
                else if(flag >= 1 && flag <= 4)
                {
                    [selectedItemsArray[flag-1] addObject:[NSNumber numberWithInteger:indexPath.row]];
                }
                else if(flag == 5 || flag == 7 || flag == 8)
                {
                    [selectedItemsArray[flag] addObject:[NSNumber numberWithInteger:indexPath.row]];
                }
                else if(flag == 6)
                {
                    switch (indexPath.row) {
                        case 0:
                            [selectedItemsArray[4] addObject:@""];
                            break;
                        case 1:
                            [selectedItemsArray[4] addObject:@"0~10"];
                            break;
                        case 2:
                            [selectedItemsArray[4] addObject:@"11~16"];
                            break;
                        case 3:
                            [selectedItemsArray[4] addObject:@"17~20"];
                            break;
                        case 4:
                            [selectedItemsArray[4] addObject:@"21~25"];
                            break;
                        case 5:
                            [selectedItemsArray[4] addObject:@"26~30"];
                            break;
                        case 6:
                            [selectedItemsArray[4] addObject:@"31~40"];
                            break;
                        case 7:
                            [selectedItemsArray[4] addObject:@"41~100"];
                            break;
                        default:
                            break;
                    }
                }
                else if(flag == 9)
                {
                    switch (indexPath.row) {
                        case 0:
                            [selectedItemsArray[flag] addObject:@""];
                            break;
                        case 1:
                            [selectedItemsArray[flag] addObject:@"2"];
                            break;
                        case 2:
                            [selectedItemsArray[flag] addObject:@"4"];
                            break;
                        case 3:
                            [selectedItemsArray[flag] addObject:@"5"];
                            break;
                        case 4:
                            [selectedItemsArray[flag] addObject:@"6"];
                            break;
                        case 5:
                            [selectedItemsArray[flag] addObject:@"7"];
                            break;
                        case 6:
                            [selectedItemsArray[flag] addObject:@"8"];
                            break;
                        default:
                            break;
                    }
                }
            }
        }
        else
        {
            [allIndexPathArray[flag] removeObject:indexPath];
            [cell.leftBtn setImage:[[UIImage imageNamed:@"btn_icon_select_fail_new_day"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            cell.title.textColor = [UIColor darkGrayColor];
            cell.isSelected = 0;
            if(flag == 0)
            {
                [allSubTitleArray[0] removeObject:[[[brandListArray[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"name"]];
            }
            else
            {
                [allSubTitleArray[flag] removeObject:allTitleArray[flag-1][indexPath.row]];
            }
            if(flag == 0)
            {
                [selectedItemsArray[6] removeObject:[[[brandListArray[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"id"]];
            }
            else if(flag >= 0 && flag <= 4)
            {
                [selectedItemsArray[flag-1] addObject:[NSNumber numberWithInteger:indexPath.row]];
            }
            else if(flag == 5 || flag == 7 || flag == 8)
            {
                [selectedItemsArray[flag] removeObject:[NSNumber numberWithInteger:indexPath.row]];
            }
            else if(flag == 6)
            {
                switch (indexPath.row) {
                    case 0:
                        [selectedItemsArray[4] removeObject:@""];
                        break;
                    case 1:
                        [selectedItemsArray[4] removeObject:@"0~10"];
                        break;
                    case 2:
                        [selectedItemsArray[4] removeObject:@"11~16"];
                        break;
                    case 3:
                        [selectedItemsArray[4] removeObject:@"17~20"];
                        break;
                    case 4:
                        [selectedItemsArray[4] removeObject:@"21~25"];
                        break;
                    case 5:
                        [selectedItemsArray[4] removeObject:@"26~30"];
                        break;
                    case 6:
                        [selectedItemsArray[4] removeObject:@"31~40"];
                        break;
                    case 7:
                        [selectedItemsArray[4] removeObject:@"41~100"];
                        break;
                    default:
                        break;
                }
            }
            else if(flag == 9)
            {
                switch (indexPath.row) {
                    case 0:
                        [selectedItemsArray[flag] removeObject:@""];
                        break;
                    case 1:
                        [selectedItemsArray[flag] removeObject:@"2"];
                        break;
                    case 2:
                        [selectedItemsArray[flag] removeObject:@"4"];
                        break;
                    case 3:
                        [selectedItemsArray[flag] removeObject:@"5"];
                        break;
                    case 4:
                        [selectedItemsArray[flag] removeObject:@"6"];
                        break;
                    case 5:
                        [selectedItemsArray[flag] removeObject:@"7"];
                        break;
                    case 6:
                        [selectedItemsArray[flag] removeObject:@"8"];
                        break;
                    default:
                        break;
                }
            }
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc] init];
    header.backgroundColor = [UIColor whiteColor];
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-50, 10)];
    lab.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    [header addSubview:lab];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    title.font = [UIFont systemFontOfSize:13.0];
    title.textColor = [UIColor darkGrayColor];
    [header addSubview:title];
    if(tableView != self.table)
    {
        if(flag == 0)
        {
            title.text = [brandListArray[section] objectForKey:@"letter"];
            return header;
        }
        else
        {
            return lab;
        }
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView != self.table)
    {
        if(flag == 0)
        {
            return 30.0;
        }
        else
        {
            return 10.0;
        }
    }
    else
    {
        return 0;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(tableView != self.table)
    {
        if(flag == 0)
        {
            return suoYinArray;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

#pragma mark - GWLCustomSliderNewDelegate
- (void)customSliderValueChanged:(GWLCustomSliderNew *)slider minValue:(NSString *)minValue maxValue:(NSString *)maxValue
{
    if([maxValue isEqualToString:@"100.0"] && [minValue isEqualToString:@"0.0"])
    {
        self.sliderValueLabel.text = @"不限";
        minMoney = @"0";
        maxMoney = @"0";
    }
    else if([maxValue isEqualToString:@"100.0"] && ![minValue isEqualToString:@"0.0"])
    {
        self.sliderValueLabel.text = [NSString stringWithFormat:@"%d万以上",minValue.intValue];
        minMoney = [NSString stringWithFormat:@"%ld",[minValue integerValue]*10000];
        maxMoney = @"0";
    }
    else
    {
        self.sliderValueLabel.text = [NSString stringWithFormat:@"%d-%d万",minValue.intValue,maxValue.intValue];
        minMoney = [NSString stringWithFormat:@"%ld",[minValue integerValue]*10000];
        maxMoney = [NSString stringWithFormat:@"%ld",[maxValue integerValue]*10000];
    }
    [self startLoadData];
}

- (UILabel *)sliderValueLabel {
    if (!_sliderValueLabel) {
        UILabel *sliderValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W-80, 15, 80, 40)];
        sliderValueLabel.textColor = MAINCOLOR;
        sliderValueLabel.font = [UIFont systemFontOfSize:15.0];
        sliderValueLabel.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:sliderValueLabel];
        _sliderValueLabel = sliderValueLabel;
    }
    return _sliderValueLabel;
}

@end

































