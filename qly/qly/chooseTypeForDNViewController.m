//
//  chooseTypeForDNViewController.m
//  hbj_app
//
//  Created by adc on 15/1/14.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import "chooseTypeForDNViewController.h"
#import "naviViewController.h"
#import "DejalActivityView.h"

@interface chooseTypeForDNViewController (){
    naviViewController *navicontroller;
}

@end

@implementation chooseTypeForDNViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    navicontroller = [[naviViewController alloc] init];
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)back_btn_click:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"type"]);
//    loginView *secondview = [[loginView alloc] init];
//    [self presentViewController:secondview animated:YES completion:^{}];
}

//- (IBAction)pollution_btn_click:(id)sender {
//    [[NSUserDefaults standardUserDefaults] setObject:@"pollution_source" forKey:@"type"];
//    
//    [self presentViewController:navicontroller animated:YES completion:nil];
//}

- (IBAction)noise_btn_click:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"water" forKey:@"type"];

    [self presentViewController:navicontroller animated:YES completion:nil];
}

- (IBAction)dust_btn_click:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"factory" forKey:@"type"];

    [self presentViewController:navicontroller animated:YES completion:nil];
}

@end
