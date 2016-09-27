//
//  AHMapVC.m
//  AutoHome
//
//  Created by qianfeng on 15/10/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHMapVC.h"
#import <MapKit/MapKit.h>

@interface AHMapVC ()<MKMapViewDelegate>
{
    MKMapView * map;
}

@end

@implementation AHMapVC

- (id)init
{
    if(self = [super init])
    {
        self.latitudeArray = [[NSMutableArray alloc] init];
        self.longtitudeArray = [[NSMutableArray alloc] init];
        self.annotationTitleArray = [[NSMutableArray alloc] init];
        self.annotationSubTitleArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.topBtnView addSubview: self.backBtn];
    [self showMap];
    
}

- (void)showMap
{
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBtnView.frame), SCREEN_W, SCREEN_H-self.topBtnView.frame.size.height)];
    map.delegate = self;
    [self.view addSubview:map];
    
    [map setMapType:MKMapTypeStandard];
    
    NSMutableArray * pointsArray = [[NSMutableArray alloc] init];
    for(int i=0; i<self.longtitudeArray.count; i++)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.latitudeArray[i] doubleValue], [self.longtitudeArray[i] doubleValue]);
        MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.5, 0.5));
        [map setRegion:region];
        
        MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
        [point setTitle:self.annotationTitleArray[i]];
        [point setSubtitle:[NSString stringWithFormat:@"%@万",self.annotationSubTitleArray[i]]];
        [point setCoordinate:coordinate];
        [pointsArray addObject:point];
    }
    [map addAnnotations:pointsArray];
}

#pragma mark - MapViewDelegate
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [mapView removeFromSuperview];
    [self.view addSubview:mapView];
}

- (void)viewWillAppear:(BOOL)animated
{
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [map removeAnnotations:map.annotations];
    [map removeFromSuperview];
    map.delegate = nil;
    map = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"hello");
    [map removeAnnotations:map.annotations];
    [map removeFromSuperview];
    map.delegate = nil;
    map = nil;
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
