//
//  AHTabBarController.m
//  AutoHome
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AHTabBarController.h"

@interface AHTabBarController ()

@end

@implementation AHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1.0];
    self.tabBar.translucent = NO;
    
//    NSArray * imageName = @[@"推荐",@"论坛",@"找车",@"发现",@"我的"];
    int i = 0;
    for (UINavigationController * nav in self.viewControllers) {
        UIViewController * vc = nav.viewControllers[0];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:[NSString stringWithFormat:@"item0%d",i+1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"item0%d_selected",i+1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        i++;
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
