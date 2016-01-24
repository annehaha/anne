//
//  comparisonViewController.m
//  qly
//
//  Created by eidision on 15/7/8.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import "comparisonViewController.h"
#import "homemapViewController.h"
#import "homedataViewController.h"
#import "hometableViewController.h"

@interface comparisonViewController ()

@end

@implementation comparisonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //地图Tab
    homemapViewController *mapViewController = [[homemapViewController alloc] init];
    UINavigationController *homemapNav = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    //    [mapViewController setTitle:@"地图方式查看"];
    UITabBarItem *mapTabBarItem = [[UITabBarItem alloc] initWithTitle:@"地图概览"
                                                                image:[[UIImage imageNamed:@"map"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                        selectedImage:[[UIImage imageNamed:@"map_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [mapViewController setTabBarItem:mapTabBarItem];
    
    //图表Tab
    hometableViewController *tableViewController = [[hometableViewController  alloc] init];
    UINavigationController *hometableNav = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    //    [tableViewController setTitle:@"曲线对比"];
    UITabBarItem *tableTabBarItem = [[UITabBarItem alloc] initWithTitle:@"曲线对比"
                                                                  image:[[UIImage imageNamed:@"curve"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                          selectedImage:[[UIImage imageNamed:@"curve_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tableViewController setTabBarItem:tableTabBarItem];
    
    //数据Tab
    homedataViewController  *dataViewController = [[homedataViewController  alloc] init];
    UINavigationController *homedataNav = [[UINavigationController alloc] initWithRootViewController:dataViewController];
    //    [dataViewController setTitle:@"数据对比"];
    UITabBarItem *dataTabBarItem = [[UITabBarItem alloc] initWithTitle:@"数据对比"
                                                                 image:[[UIImage imageNamed:@"data"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                         selectedImage:[[UIImage imageNamed:@"data_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [dataViewController setTabBarItem:dataTabBarItem];
    
    NSArray *homeTabArray = @[homemapNav, hometableNav, homedataNav];
    [self setViewControllers:homeTabArray animated:YES];
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
