//
//  videoSelectTableViewController.m
//  qly
//
//  Created by eidision on 15/7/11.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import "videoSelectTableViewController.h"
#import "CustomResourceTableViewCell.h"
//#import "RealPlayViewController.h"
//#import "realTimeViewController.h"
#import "VMSNetSDK.h"

@interface videoSelectTableViewController (){
    NSMutableArray *newCameraArray;
    NSMutableArray *_resourceArray; //保存tableView显示的数据
    NSString *serverAddr;
    CMSPInfo *serverInfo;
    id data;
}

@end

@implementation videoSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _resourceArray = [[NSMutableArray alloc] init];
    serverAddr = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoAddr"];
    serverInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"server_Info"];
    
    
#warning fjdlskafjdkls
    
    int controlUnitID = 1;
    //here you should avert the id
    //[[NSUserDefaults standardUserDefaults] objectForKey:@"csite_id"];
    
    //get camera info
    [[VMSNetSDK shareInstance] getCameraListFromCtrlUnit:serverAddr
                                             toSessionID:serverInfo.sessionID
                                         toControlUnitID:controlUnitID
                                            toNumPerOnce:20
                                               toCurPage:1
                                            toCameraList:_resourceArray];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectVideo = @"selectV";
    
    CustomResourceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectVideo];
    if(cell == nil)
    {
        if(indexPath.row >= [_resourceArray count])
        {
            return nil;
        }
        
        data = [_resourceArray objectAtIndex:indexPath.row];
        
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([CustomResourceTableViewCell class]) bundle:nil];
        
        cell = [[nib instantiateWithOwner:self options:nil] lastObject];
        //cell.delegate = self;
        [cell setCellContent:data withServerInfo:serverInfo];
        //cell.fatherDataID = _currentControlUnitID;
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            RealPlayViewController *realplayViewCtr = [[RealPlayViewController alloc] initWithNibName:NSStringFromClass([RealPlayViewController class]) bundle:nil withServerInfo:serverInfo withCameraInfo:data];
//            [self presentViewController:realplayViewCtr animated:YES completion:nil];
//            //[self pushViewController:realplayViewCtr animated:YES];
//        }
//    }
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
