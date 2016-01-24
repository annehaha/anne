//
//  analysisViewController.m
//  qly
//
//  Created by anne on 15/7/10.
//  Copyright (c) 2015年 zxy. All rights reserved.
//

#import "analysisViewController.h"


@interface analysisViewController ()

@end

@implementation analysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    //颗粒物报表
    monthReportViewController  *month = [[monthReportViewController  alloc] init];
    UINavigationController *monthNav = [[UINavigationController alloc] initWithRootViewController: month];
    //    [dataViewController setTitle:@"数据对比"];
    UITabBarItem *dataTabBarItem = [[UITabBarItem alloc] initWithTitle:@"颗粒物报表"
                                                                 image:[[UIImage imageNamed:@"spm_report"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                         selectedImage:[[UIImage imageNamed:@"spm_report_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [month setTabBarItem:dataTabBarItem];
    
    //颗粒物分布
    spmDistributionViewController *spmVC = [[spmDistributionViewController alloc]  init];
    UINavigationController *spmNav = [[UINavigationController alloc] initWithRootViewController:spmVC];
    //    [tableViewController setTitle:@"曲线对比"];
    UITabBarItem *spmTabBarItem = [[UITabBarItem alloc] initWithTitle:@"颗粒物分布"
                                                                image:[[UIImage imageNamed:@"distribution"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                        selectedImage:[[UIImage imageNamed:@"distribution_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [spmVC setTabBarItem:spmTabBarItem];
    
    
    //夜间噪声
    nightNoiseViewController *nightNoiseVC = [[nightNoiseViewController alloc]  init];
    UINavigationController *nightNoiseNav = [[UINavigationController alloc] initWithRootViewController:nightNoiseVC];
    //    [tableViewController setTitle:@"曲线对比"];
    UITabBarItem *nightNoiseTabBarItem = [[UITabBarItem alloc] initWithTitle:@"夜间噪声"
                                                                       image:[[UIImage imageNamed:@"night_noise"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                               selectedImage:[[UIImage imageNamed:@"night_noise_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nightNoiseVC setTabBarItem:nightNoiseTabBarItem];
    
    //噪声分布
    noiseDistributionViewController *nightDisVC = [[noiseDistributionViewController alloc]  init];
    UINavigationController *nightDisNav = [[UINavigationController alloc] initWithRootViewController:nightDisVC];
    //    [tableViewController setTitle:@"曲线对比"];
    UITabBarItem *nightDisTabBarItem = [[UITabBarItem alloc] initWithTitle:@"噪声分布"
                                                                     image:[[UIImage imageNamed:@"noise_distribution"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             selectedImage:[[UIImage imageNamed:@"noise_distribution_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nightDisVC setTabBarItem:nightDisTabBarItem];
    
    
    
    
    NSArray *analysisTabArray = @[monthNav,spmNav,nightNoiseNav,nightDisNav];
    [self setViewControllers:analysisTabArray animated:YES];
    
    NSString* city_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"city_id"];
    NSLog(@"sssss%@",city_id);
    
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
