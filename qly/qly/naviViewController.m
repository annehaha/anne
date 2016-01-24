//
//  naviViewController.m
//  qly
//
//  Created by eidision on 15/7/8.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import "naviViewController.h"
#import "navifirstTableViewController.h"
//#import "navisecondTableViewController.h"
#import "navisecViewController.h"
#import "navithirdTableViewController.h"
#import "navifourthTableViewController.h"

@interface naviViewController ()

@end

@implementation naviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //now four tabs
    
    //横向对比
    navifirstTableViewController *navifirstTVC = [[navifirstTableViewController alloc] init];
    UINavigationController *firstNC = [[UINavigationController alloc] initWithRootViewController:navifirstTVC];
    //    [mapViewController setTitle:@"地图方式查看"];
    UITabBarItem *firstTabBarItem = [[UITabBarItem alloc] initWithTitle:@"横向对比"
                                                                image:[[UIImage imageNamed:@"navi_horizontal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                        selectedImage:[[UIImage imageNamed:@"navi_horizontal_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navifirstTVC setTabBarItem:firstTabBarItem];
    
    //监测详情
    navisecViewController *navisecondTVC = [[navisecViewController alloc] init];
    UINavigationController *secondNC = [[UINavigationController alloc] initWithRootViewController:navisecondTVC];
    //    [mapViewController setTitle:@"地图方式查看"];
    UITabBarItem *secondTabBarItem = [[UITabBarItem alloc] initWithTitle:@"监测详情"
                                                                  image:[[UIImage imageNamed:@"navi_supervision"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                          selectedImage:[[UIImage imageNamed:@"navi_supervision_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navisecondTVC setTabBarItem:secondTabBarItem];
    
    //统计分析
    navithirdTableViewController *navithirdTVC = [[navithirdTableViewController alloc] init];
    UINavigationController *thirdNC = [[UINavigationController alloc] initWithRootViewController:navithirdTVC];
    //    [mapViewController setTitle:@"地图方式查看"];
    UITabBarItem *thirdTabBarItem = [[UITabBarItem alloc] initWithTitle:@"统计分析"
                                                                  image:[[UIImage imageNamed:@"navi_statistic"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                          selectedImage:[[UIImage imageNamed:@"navi_statistic_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navithirdTVC setTabBarItem:thirdTabBarItem];
    
    //设置
    navifourthTableViewController *navifourthTVC = [[navifourthTableViewController alloc] init];
    UINavigationController *fourthNC = [[UINavigationController alloc] initWithRootViewController:navifourthTVC];
    //    [mapViewController setTitle:@"地图方式查看"];
    UITabBarItem *fourthTabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置"
                                                                  image:[[UIImage imageNamed:@"navi_setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                          selectedImage:[[UIImage imageNamed:@"navi_setting_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navifourthTVC setTabBarItem:fourthTabBarItem];
    
    NSArray *navitabArray = @[firstNC, secondNC, thirdNC, fourthNC];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:58/255.0
                                                                                                       green:149/255.0
                                                                                                        blue:223/255.0
                                                                                                       alpha:1]}
                                             forState:UIControlStateSelected];
    [self setViewControllers:navitabArray animated:YES];
    
    //navi background
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_navi"]]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
