//
//  singlePlaybackViewController.m
//  qly
//
//  Created by eidision on 15/7/10.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import "singlePlaybackViewController.h"

@interface singlePlaybackViewController ()

@end

@implementation singlePlaybackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.tabBarController.tabBarItem
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"   返回"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(back)];
    [backButton setTitleTextAttributes:@{
                                         NSFontAttributeName: [UIFont systemFontOfSize:15],
                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                         }
                              forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
    
    NSString *csite_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"csite_id"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) back {
    //[self dismissViewControllerAnimated:YES completion:nil];
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
