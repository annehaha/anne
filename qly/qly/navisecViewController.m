//
//  navisecViewController.m
//  qly
//
//  Created by eidision on 15/7/10.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import "navisecViewController.h"
#import "singleTabBarController.h"
#import "myNetworking.h"

@interface navisecViewController (){
    UITableView *tableView;
}

@end

@implementation navisecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //[tableView reloadData];
    
    self.view = tableView;
    self.title = @"监测详情";
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    //self.spot_list = [[NSUserDefaults standardUserDefaults] objectForKey:@"spot_list"];
    //if (self.spot_list == nil) {
    [self assignForAddressInfo];
    //}
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
}

-(void) assignForAddressInfo
{
    self.spot_list = [[NSMutableArray alloc] init];
    
    //get location info from web
    NSString *ask = @"getSpotListByUser";
    NSString* user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    [[myNetworking sharedClient] GET:ask parameters:@{@"user_id":user_id, @"with_data":@"1"} success: ^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = result;
        NSLog(@"id:%@", user_id);
        
        for (int i = 0 ; i < array.count; i ++) {
            NSDictionary *temp = array[i];
            
            // for global spot_list
            NSMutableDictionary *spot = [[NSMutableDictionary alloc] init];
            [spot setObject: [temp objectForKey:@"spot_id"] forKey: @"spot_id"];
            [spot setObject: [temp objectForKey:@"csite_name"] forKey: @"csite_name"];
            [spot setObject: [temp objectForKey:@"csite_short_name"] forKey: @"csite_short_name"];
            [spot setObject: [temp objectForKey:@"csite_id"] forKey: @"csite_id"];
            [spot setObject: [temp objectForKey:@"realtime_pm10"] forKey: @"realtime_dust"];
            [spot setObject: [temp objectForKey:@"hour_pm10"] forKey: @"hour_dust"];
            [spot setObject: [temp objectForKey:@"realtime_noise_20min"] forKey: @"realtime_noise_20min"];
            [spot setObject: [temp objectForKey:@"hour_noise"] forKey: @"hour_noise"];
            [self.spot_list addObject:spot];
            
            
//            NSString *longitude = [temp objectForKey:@"longitude"];
//            NSString *latitude = [temp objectForKey:@"latitude"];
            
//            double longtSum = [longitude doubleValue];
//            double latitSum = [latitude doubleValue];
//            
//            NSString *csite_name = [temp objectForKeyedSubscript:@"csite_name"];
//            NSString *addr = [temp objectForKey:@"addr"];
//            //NSString *spot_id = [temp objectForKey:@"spot_id"];
//            NSString *csite_id = [temp objectForKey:@"csite_id"];
//            CGPoint point = CGPointMake([latitude doubleValue],
//                                        [longitude doubleValue]);
//            
//            //[csite_dict setObject:temp forKey:csite_id];
//            
//            NSString *spm = [temp objectForKey:@"realtime_dust"];
//            NSString *spmhour = [temp objectForKey:@"hour_dust"];
//            NSString *noise = [temp objectForKey:@"realtime_noise_20min"];
//            NSString *noisehour = [temp objectForKey:@"hour_noise"];
            [tableView reloadData];
        }
        [[NSUserDefaults standardUserDefaults] setValue:self.spot_list forKey:@"spot_list"];
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [self alertWithTitle:@"加载数据失败" withMsg:@"加载数据失败"];
    }];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *spot = [self.spot_list objectAtIndex:indexPath.row];
    NSString *csite_id = [spot objectForKey:@"csite_id"];
    NSString *csite_name = [spot objectForKey:@"csite_name"];
    [[NSUserDefaults standardUserDefaults] setObject:csite_id forKey:@"csite_id"];
    [[NSUserDefaults standardUserDefaults] setObject:csite_name forKey:@"csite_name"];
    
    singleTabBarController *secondview = [[singleTabBarController alloc] init];
    [self presentViewController:secondview animated:YES completion:nil];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) alertWithTitle:(NSString *)title withMsg:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
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
