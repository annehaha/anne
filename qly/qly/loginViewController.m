//
//  loginViewController.m
//  qly
//
//  Created by eidision on 15/7/8.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import "loginViewController.h"
#import "myNetworking.h"
#import "DejalActivityView.h"
#import "plistOperation.h"
#import "chooseTypeForDNViewController.h"

@interface loginViewController (){
    BOOL remember;
    NSInteger flag;
    int connected;
}

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_rememberMark setImage:nil forState:UIControlStateNormal];
    [_rememberMark setImage:[UIImage imageNamed:@"login_selected"] forState:UIControlStateSelected];
    [_rememberMark setImage:[UIImage imageNamed:@"login_non_selected"] forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    remember = YES;
    [_rememberMark setSelected:YES];
    
    flag = 5;
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *documentDirectory = [plistOperation applicationDocumentsDirectory];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"logininfo.plist"];//不应该从资源文件中读取数据，资源文件中的数据没有更改，要从沙箱中的资源文件读取数据
    
    NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];//从资源文件中加载内容
    
    if (userInfoDic) {
        self.userName.text = userInfoDic[@"username"];
        self.userPwd.text = userInfoDic[@"password"];
    }
}

- (IBAction)remember:(id)sender {
    remember = !remember;
    [self.rememberMark setSelected:remember];
    //    if (remember) {
    //        remember = NO;
    //        [self.rememberMark setSelected:NO];
    //    }
    //    else{
    //        remember = YES;
    //        [self.rememberMark setSelected:YES];
    //    }
}

- (IBAction)forget:(id)sender {
    [self alertWithTitle:@"找回密码" withMsg:@"未开放"];
}

- (IBAction)login:(id)sender {
    [self connectedToNetWork];
    if (connected == 0) {
        [self postToServer];
        
        UIView *viewToUse = self.view;
        [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"登录中..." width:100];
    }
    else if(connected == 1){
        [self alertWithTitle:@"网络异常" withMsg:@"网络未连接"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    //将账号密码存储在plist
    [plistOperation createEditableCopyOfDatabaseIfNeeded:@"logininfo.plist"];
    
    NSString *documentDirectory = [plistOperation applicationDocumentsDirectory];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"logininfo.plist"];//不应该从资源文件中读取数据，资源文件中的数据没有更改，要从沙箱中的资源文件读取数据
    NSMutableDictionary *logininfo;
    if (remember) {
        //NSString *userID = [[NSUserDefaults standardUserDefaults] stringForKey:@"userid"];
        if (self.userName != nil && self.userPwd != nil) {
            logininfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.userName.text, @"username", self.userPwd.text, @"password", nil];
        }else{
            NSLog(@"fuck there");
        }
        
        NSLog(@"%@", self.userName.text);
        NSLog(@"%@", self.userPwd.text);
        //NSLog(@"%@", userID);
    }
    
    
    [logininfo writeToFile:path atomically:YES];
}

-(void)postToServer
{
    //login url
    NSString *ask = @"login";
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [[myNetworking sharedClient] GET:ask
                          parameters:@{@"username":self.userName.text,@"password":self.userPwd.text}
                             success:^(AFHTTPRequestOperation *operation, id result){
                                 NSDictionary *tap = result;
                                 
                                 [timer invalidate];
                                 
                                 NSString *state = [tap objectForKey:@"state"];
                                 NSString *user_id = [tap objectForKey:@"id"];
                                 NSString *cityid = [tap objectForKey:@"cityId"];
                                 
                                 
                                 if (!operation.responseString) {
                                     //网络异常
                                     flag = 0;
                                 }else{
                                     //NSMutableDictionary *loginInfo = result;
                                     NSString *loginInfo = result;
                                     switch ([state intValue]) {
                                         case 0:
                                         {
                                             //{state:0, id:1}成功
                                             flag = 3;
#warning here change
                                             [[NSUserDefaults standardUserDefaults] setValue:user_id forKey:@"user_id"];
                                             [[NSUserDefaults standardUserDefaults] setValue:cityid forKey:@"city_id"];
                                             chooseTypeForDNViewController *secondview = [[chooseTypeForDNViewController alloc] init];
                                             [self presentViewController:secondview animated:YES completion:^{}];
                                             
                                             break;
                                         }
                                             
                                         case 1:
                                             //{state:1, id:1}密码错误
                                             flag = 1;
                                             
                                         case 2:
                                             //{state:2, id:1}账号不存在
                                             flag = 2;
                                         default:
                                             break;
                                     }
                                 }
                                 [self performSelector:@selector(removeActivityView) withObject:nil afterDelay:0.4];
                             } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                                 NSLog(@"%@", error);
                             }
     ];
}

- (void)timerFired {
    if (flag == 5) {
        [UIView animateWithDuration:0.3f animations:^{
            [self alertWithTitle:@"网络异常" withMsg:@"登陆超时"];
            
            [DejalBezelActivityView removeViewAnimated:YES];
            [[self class] cancelPreviousPerformRequestsWithTarget:self];
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)removeActivityView
{
    [DejalBezelActivityView removeViewAnimated:YES];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    
    //post账号密码
    //登陆成功
    switch (flag) {
        case 0:
        {
            [self alertWithTitle:@"登陆失败" withMsg:@"网络异常，请检查网络后重试"];
            break;
        }
        case 1:
        {
            [self alertWithTitle:@"登陆失败" withMsg:@"账号密码不匹配"];
            break;
        }
        case 2:
        {
            [self alertWithTitle:@"登陆失败" withMsg:@"账号不存在"];
            break;
        }
        case 3:
        {
            //successfully login
            //            [self alertWithTitle:@"登陆成功" withMsg:@"请稍候..."];
            
            break;
        }
            
        default:
            break;
    }
}

- (void) alertWithTitle:(NSString *)title withMsg:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) connectedToNetWork {
    //检测网络是否可以连接
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                connected = 0;
                NSLog(@"network:YES");
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                connected = 1;
                NSLog(@"network:NO");
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (IBAction)touchView:(id)sender {
    [self.view endEditing:YES];
}
@end
