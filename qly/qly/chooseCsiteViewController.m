//
//  chooseCsiteViewController.m
//  hbj_app
//
//  Created by adc on 15/1/6.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import "chooseCsiteViewController.h"
#import "myNetworking.h"
#import "singleTabBarController.h"

@interface chooseCsiteViewController ()

@end

@implementation chooseCsiteViewController
@synthesize spot_list = _spot_list;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView reloadData];
    
    self.view = tableView;
    self.title = @"请选择地点";
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.spot_list = [[NSUserDefaults standardUserDefaults] objectForKey:@"spot_list"];
    
    if (!self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = YES;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return [self.spot_list count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    NSMutableDictionary *spot = [self.spot_list objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
    cell.textLabel.text = [spot objectForKey: @"csite_name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSMutableDictionary *spot = [self.spot_list objectAtIndex:indexPath.row];
    NSString *csite_id = [spot objectForKey:@"csite_id"];
    NSString *csite_name = [spot objectForKey:@"csite_name"];
    
    NSLog(@"herre: %@%@", csite_id, csite_name);
    
    [[NSUserDefaults standardUserDefaults] setObject:csite_id forKey:@"csite_id"];
    [[NSUserDefaults standardUserDefaults] setObject:csite_name forKey:@"csite_name"];
    
    singleTabBarController *secondview = [[singleTabBarController alloc] init];
    [self presentViewController:secondview animated:YES completion:^{}];
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
