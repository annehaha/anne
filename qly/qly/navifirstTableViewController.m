//
//  navifirstTableViewController.m
//  qly
//
//  Created by eidision on 15/7/8.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import "navifirstTableViewController.h"
#import "comparisonViewController.h"

@interface navifirstTableViewController (){
    NSArray *content;
    comparisonViewController *comparisonVC;
    NSArray *imageArray;
}

@end

@implementation navifirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"横向对比";
    
    content = @[@"地图概览", @"曲线对比", @"数据对比"];
    imageArray = @[@"horizontal_map" , @"horizontal_curve", @"horizontal_data"];
    comparisonVC = [[comparisonViewController alloc] init];
    
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
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [content count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.textLabel.text = content[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [cell.textLabel setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
    cell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [comparisonVC setSelectedIndex:indexPath.row];
    [self presentViewController:comparisonVC animated:YES completion:nil];
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"返回";
    self.navigationItem.backBarButtonItem = backbutton;
}

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
