//
//  singleTabBarController.m
//  qly
//
//  Created by eidision on 15/7/10.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import "singleTabBarController.h"
#import "CsiteDetailViewController.h"
#import "singleCurveViewController.h"
#import "ViewPhotoViewController.h"
#import "singlePlaybackViewController.h"
//#import "realTimeViewController.h"
#import "videoSelectTableViewController.h"
//#import "VMSNetSDK.h"

@interface singleTabBarController (){
    NSString *videoUser;
    NSString *videoPwd;
    NSString *serverAddr;
}


@end

@implementation singleTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    videoUser = @"admin";
    videoPwd = @"landfun2012";
    serverAddr = @"http://140.207.216.106";
    
    [[NSUserDefaults standardUserDefaults] setObject:videoUser forKey:@"videoUser"];
    
    [[NSUserDefaults standardUserDefaults] setObject:videoPwd forKey:@"videoPwd"];
    
    [[NSUserDefaults standardUserDefaults] setObject:serverAddr forKey:@"videoAddr"];
    
    NSString *csite_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"csite_id"];
    NSLog(@"%@", csite_id);
    
    CsiteDetailViewController *single_detail = [[CsiteDetailViewController alloc] init];
    UINavigationController *single_detail_navi = [[UINavigationController alloc] initWithRootViewController:single_detail];
    UITabBarItem *detailTab = [[UITabBarItem alloc] initWithTitle:@"监测点信息" image:[UIImage imageNamed:@"single_detail"] selectedImage:[UIImage imageNamed:@"single_detail_selected"]];
    
    [single_detail setTabBarItem:detailTab];
    
    singleCurveViewController *single_curve = [[singleCurveViewController alloc] init];
    UINavigationController *single_curve_navi = [[UINavigationController alloc] initWithRootViewController:single_curve];
    
    UITabBarItem *curveTab = [[UITabBarItem alloc] initWithTitle:@"曲线变化" image:[UIImage imageNamed:@"single_curve"] selectedImage:[UIImage imageNamed:@"single_curve_selected"]];
    [single_curve setTabBarItem:curveTab];
    
    ViewPhotoViewController *single_photo  = [[ViewPhotoViewController alloc] init];
    UINavigationController *single_photo_navi = [[UINavigationController alloc] initWithRootViewController:single_photo];
    
    UITabBarItem *photoTab = [[UITabBarItem alloc] initWithTitle:@"抓拍照片" image:[UIImage imageNamed:@"single_capture"] selectedImage:[UIImage imageNamed:@"single_capture_selected"]];
    [single_photo setTabBarItem:photoTab];
    
    //realTimeViewController *realtimeVC = [[realTimeViewController alloc] init];
//    videoSelectTableViewController *realtimeVC = [[videoSelectTableViewController alloc] init];
//    UINavigationController *single_realtimeNV = [[UINavigationController alloc] initWithRootViewController:realtimeVC];
//    
//    UITabBarItem *realtimeTab = [[UITabBarItem alloc] initWithTitle:@"实时视频" image:[UIImage imageNamed:@"single_video"] selectedImage:[UIImage imageNamed:@"single_video_selected"]];
//    [realtimeVC setTabBarItem:realtimeTab];
//    
//    singlePlaybackViewController *single_playback = [[singlePlaybackViewController alloc] init];
//    UINavigationController *single_playback_navi = [[UINavigationController alloc] initWithRootViewController:single_playback];
//    
//    UITabBarItem *playbackTab = [[UITabBarItem alloc] initWithTitle:@"视频回放" image:[UIImage imageNamed:@"single_playback"] selectedImage:[UIImage imageNamed:@"single_playback_selected"]];
//    [single_playback setTabBarItem:playbackTab];
    
//    TakePhotoViewController *single_takephoto = [[TakePhotoViewController alloc] init];
//    UINavigationController *single_takephoto_navi = [[UINavigationController alloc] initWithRootViewController:single_takephoto];
//    
//    UITabBarItem *takephotoTab = [[UITabBarItem alloc] initWithTitle:@"超标抓拍" image:[UIImage imageNamed:@"single_video"] selectedImage:[UIImage imageNamed:@"single_video_selected"]];
//    [single_takephoto setTabBarItem:takephotoTab];
    
    //NSArray *singletabArray = @[single_detail_navi, single_curve_navi, single_photo_navi, single_realtimeNV, single_playback_navi];
    NSArray *singletabArray = @[single_detail_navi, single_curve_navi, single_photo_navi];
    [self setViewControllers:singletabArray animated:YES];
    
    
    
//    [[NSUserDefaults standardUserDefaults] setObject:serverAddr forKey:SERVER_ADDRESS];
//    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:USER_NAME];
//    [[NSUserDefaults standardUserDefaults] setObject:password forKey:PASSWORD];
    
    //[self videoLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void) videoLogin{
    //VMSNetSDK * vmsNetSdk = [VMSNetSDK shareInstance];
    serverAddr = [serverAddr uppercaseString];
    if(![serverAddr hasPrefix:@"HTTP://"])
    {
        serverAddr = [NSString stringWithFormat:@"HTTP://%@",serverAddr];
    }
    
    VMSNetSDK * vmsNetSdk = [VMSNetSDK shareInstance];
    self.serverInfo = [[CMSPInfo alloc] init];
    
    //serverAddr = [serverAddr uppercaseString];
    
    NSLog(@"%@", serverAddr);
    NSMutableArray *LineArray = [[NSMutableArray alloc] init];
    [vmsNetSdk getLineList:serverAddr toLineInfoList:LineArray];
    //这里获得了3个线路，内网，外网，车载，根据网域选择相应线路，我这边代码暂时写默认用第一个可以用的。
    BOOL ret = NO;
    for(CLineInfo *lineInfo in LineArray)
    {
        ret = [vmsNetSdk login:serverAddr toUserName:videoUser toPassword:videoPwd toLineID:lineInfo.lineID toServInfo:self.serverInfo];
        if(ret)
        {
            break;
        }
    }
    
    if(!ret)
    {
        //如果登录不上，可能是新6.x平台，再使用新平台登录方式登录
        ret = [vmsNetSdk loginV40:serverAddr toUserName:videoUser toPassword:videoPwd toServInfo:self.serverInfo];
        if(!ret)
        {
            NSLog(@"login failed ! errno = %d",vmsNetSdk.nLastError);
            return;
        }
    }
    
    NSLog(@"login sucess! sessonId = %@",self.serverInfo.sessionID);
    //保存登录信息
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",vmsNetSdk.version] forKey:@"server_version"];
    [[NSUserDefaults standardUserDefaults] setObject:self.serverInfo forKey:@"server_Info"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
