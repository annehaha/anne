//
//  navifourthTableViewController.m
//  qly
//
//  Created by eidision on 15/7/8.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import "navifourthTableViewController.h"
#import "aboutTableViewController.h"

@interface navifourthTableViewController (){
    NSArray *content;
    NSArray *content2;
    //NSArray *imageArray;
    double screen_width;
    double screen_height;
}

@end

@implementation navifourthTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screen_width = (double)[UIScreen mainScreen].applicationFrame.size.width;
    screen_height = (double)[UIScreen mainScreen].applicationFrame.size.height;
    
    self.title = @"设置";
    content = @[@"当前版本", @"检查更新"];
    content2 = @[@"关于"];
    
    //self.tabBarController.tabBarItem
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"   返回"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self action:@selector(back)];
    [backButton setTitleTextAttributes:@{
                                         NSFontAttributeName: [UIFont systemFontOfSize:15],
                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                         }
                              forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [content count];
    }else{
        return [content2 count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    
    NSLog(@"%ld", (long)indexPath.row);
    
    if (indexPath.section == 0) {
        cell.textLabel.text = content[indexPath.row];
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"V %@", [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]];
            cell.userInteractionEnabled = NO;
        }else{
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        cell.textLabel.text = content2[indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    [cell.textLabel setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
    //cell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            aboutTableViewController *aboutVC = [[aboutTableViewController alloc] init];
            UINavigationController *aboutNV = [[UINavigationController alloc] initWithRootViewController:aboutVC];
            [self presentViewController:aboutNV animated:YES completion:nil];
        }
    }else{
    
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:  forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
