//
//  homemapViewController.m
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "homemapViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "myNetworking.h"
#import "QuartzCore/QuartzCore.h"
#import "chooseCsiteViewController.h"
#import "singleTabBarController.h"
//#import "chooseTypeViewController.h"
//#import "chooseTypeForDNViewController.h"
//#import "singleCsiteViewController.h"
#import "DejalActivityView.h"



@interface homemapViewController ()
{
    UIButton *drawButton;
    UIButton *enterButton;
    UIButton *relocateButton;
    UIButton *hourBtn;
    UIButton *realtimeBtn;
    
    double longtSum;
    double latitSum;
    double screen_width;
    double screen_height;
    
    NSMutableDictionary *csite_dict;
    UILabel *titleLabel;
}
@end

@implementation homemapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    csite_dict = [[NSMutableDictionary alloc] init];
    
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
    
    screen_width = (double)[UIScreen mainScreen].applicationFrame.size.width;
    screen_height = (double)[UIScreen mainScreen].applicationFrame.size.height;
    
    longtSum = 0.0;
    latitSum = 0.0;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    self.navigationItem.titleView = titleLabel;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"corner_button"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(enterinto_choosecsite)];

    
    
    float buttonWidth = screen_width * 0.5;
    float buttonHeight = 44 / 568.0 * screen_height;
    
    NSLog(@"%f%f", buttonWidth, buttonHeight);
    
    //实时数据Button
    realtimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, buttonWidth, buttonHeight)];
    [realtimeBtn setTitle:@"实时数据" forState:UIControlStateNormal];
    [realtimeBtn setBackgroundImage:[UIImage imageNamed:@"top_button"] forState:UIControlStateNormal];
    [realtimeBtn setBackgroundImage:[UIImage imageNamed:@"top_button_selected"] forState:UIControlStateSelected];
    realtimeBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [realtimeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [realtimeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [realtimeBtn setTitleColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1] forState:UIControlStateSelected];
    [realtimeBtn addTarget:self action:@selector(realtime:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:realtimeBtn];
    
    //时均值Button
    hourBtn= [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth, 64, buttonWidth, buttonHeight)];
    [hourBtn setBackgroundImage:[UIImage imageNamed:@"top_button"] forState:UIControlStateNormal];
    [hourBtn setBackgroundImage:[UIImage imageNamed:@"top_button_selected"] forState:UIControlStateSelected];
    [hourBtn setTitle:@"小时数据" forState:UIControlStateNormal];
    hourBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [hourBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [hourBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [hourBtn setTitleColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1] forState:UIControlStateSelected];
    [hourBtn addTarget:self action:@selector(hourAverage:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hourBtn];
    
    //init mapview
    //default for mapviewForDay
    self.mapview = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64 + buttonHeight, screen_width, screen_height - 127)];
    self.mapview.delegate = self;
    self.mapview.mapType = MKMapTypeStandard;
    
//    [self relocate];
    [self.view addSubview:self.mapview];
    
    [realtimeBtn setSelected:YES];
    
    //button to relocate
    relocateButton = [[UIButton alloc] init];
    relocateButton.frame = CGRectMake(15 / 320.0 * screen_width, 20 + 0.5 * screen_height, 45 / 320.0 * screen_width, 45 / 320.0 * screen_width);
    [relocateButton setBackgroundImage:[UIImage imageNamed:@"locateicon"] forState:UIControlStateNormal];
    [relocateButton addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:relocateButton];
    [self.view bringSubviewToFront:relocateButton];
    [self.view addSubview:relocateButton];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *temptype = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    if ( [temptype isEqual: @"noise"]) {
        titleLabel.text = @"地图概览（噪声）";
    }else{
        titleLabel.text = @"地图概览（PM10）";
    }
    
    //assign for addressInfo
    [self assignForAddressInfo];
    
    selectionName = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    flag = @"realtime";
    
    if (self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = NO;
    }
}

#pragma mark -preperations
//addressInfo
-(void) assignForRegionCoord
{
    //CLLocationCoordinate2D coordinate = {29.57052, 106.522288};
    if (latitSum == 0.0 || longtSum == 0.0) {
        [self alertWithTitle:@"网络异常" withMsg:@"网络不给力，请稍后重试"];
    }else{
        double latit = latitSum;// / [self.addressInfo count];
        double longt = longtSum;// / [self.addressInfo count];
        CLLocationCoordinate2D coordinate = {latit, longt};
        self.regionCoord = coordinate;
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

-(void) assignForAddressInfo
{
    self.addressInfo = [[NSMutableDictionary alloc] init];
    self.observation = [[NSMutableDictionary alloc] init];
    
    //get location info from web
    NSString *ask = @"getSpotListByUser";
    NSString* user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    [[myNetworking sharedClient] GET:ask parameters:@{@"user_id":user_id, @"with_data":@"1"} success: ^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = result;
        NSLog(@"id:%@", user_id);
        NSLog(@"result:%@", result);
        NSMutableDictionary *tempnoise = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *tempspm = [[NSMutableDictionary alloc] init];
        
        NSMutableArray *spot_list = [[NSMutableArray alloc] init];
        
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
            [spot_list addObject:spot];
            

            NSString *longitude = [temp objectForKey:@"longitude"];
            NSString *latitude = [temp objectForKey:@"latitude"];
            
            longtSum = [longitude doubleValue];
            latitSum = [latitude doubleValue];
            
            NSString *csite_name = [temp objectForKeyedSubscript:@"csite_name"];
            NSString *addr = [temp objectForKey:@"addr"];
            //NSString *spot_id = [temp objectForKey:@"spot_id"];
            NSString *csite_id = [temp objectForKey:@"csite_id"];
            CGPoint point = CGPointMake([latitude doubleValue],
                                        [longitude doubleValue]);
            
            [self.addressInfo setObject:@[addr, [NSValue valueWithCGPoint:point], csite_name] forKey:csite_id];
            [csite_dict setObject:temp forKey:csite_id];
            
            NSString *spm = [temp objectForKey:@"realtime_pm10"];
            NSString *spmhour = [temp objectForKey:@"hour_pm10"];
            NSString *noise = [temp objectForKey:@"realtime_noise_20min"];
            NSString *noisehour = [temp objectForKey:@"hour_noise"];
            
            [tempspm   setObject:@[spm, spmhour] forKey:csite_id];
            [tempnoise setObject:@[noise, noisehour] forKey:csite_id];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:spot_list forKey:@"spot_list"];
        
        [self.observation setObject:tempnoise forKey:@"noise"];
        [self.observation setObject:tempspm forKey:@"spm"];
        [self assignForRegionCoord];
        [self relocate];
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [self alertWithTitle:@"加载数据失败" withMsg:@"加载数据失败"];
    }];
}

//observation
-(void) assignForObservation
{
    self.observation = [[NSMutableDictionary alloc] init];
}

//selectionItems
-(void) assignForSelectionItems
{
    self.selectionItems = @[@"spm", @"noise"];
    //self.selectionItems = [self.observation allKeys];s
}

#pragma mark -mapView
//绘制地图
-(void)loadMap
{
    //example
    //121.434125,31.033182
    NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    currentAnnotations = [[NSMutableArray alloc] init];
    NSDictionary *tempdict = [[NSDictionary alloc] initWithDictionary:self.observation[selectionName]];
    for (NSString *csite_id in tempdict.allKeys) {
        CGPoint temppoint = [self.addressInfo[csite_id][1] CGPointValue];
        double x = temppoint.x;
        double y = temppoint.y;
        CLLocationCoordinate2D tempcoordinate = {x, y};
        AnnotationInMap *annotationInMap = [[AnnotationInMap alloc] initWithCGLocation:tempcoordinate];
        NSArray *temparray = [tempdict objectForKey:csite_id];
        if ([flag isEqualToString:@"realtime"]) {
            if ([type isEqualToString:@"spm"]) {
                annotationInMap.title = [NSString stringWithFormat:@"%d", [temparray[0] intValue]];
                annotationInMap.title = [annotationInMap.title stringByAppendingString:@"μg/m\u00B3"];
            } else if ([type isEqualToString:@"noise"]) {
                annotationInMap.title = [NSString stringWithFormat:@"%.1f", [temparray[0] doubleValue]];
                annotationInMap.title = [annotationInMap.title stringByAppendingString:@"db(A)"];
            }
        } else {
            if ([type isEqualToString:@"spm"]) {
                annotationInMap.title = [NSString stringWithFormat:@"%d", [temparray[1] intValue]];
                annotationInMap.title = [annotationInMap.title stringByAppendingString:@"μg/m\u00B3"];
            } else if ([type isEqualToString:@"noise"]) {
                annotationInMap.title = [NSString stringWithFormat:@"%.1f", [temparray[1] doubleValue]];
                annotationInMap.title = [annotationInMap.title stringByAppendingString:@"db(A)"];
            }
        }
        
        annotationInMap.subtitle = [self.addressInfo objectForKey:csite_id][2] ;//@"ok";
        annotationInMap.tag = csite_id;
        [currentAnnotations addObject:annotationInMap];
        [self.mapview addAnnotation:annotationInMap];
    }
}

//点击实时图触发的函数
-(void)realtime:(id)sender
{
    if ([flag isEqualToString:@"realtime"]) {
        return;
    }
    [realtimeBtn setSelected:YES];
    [hourBtn setSelected:NO];
    
//    [realtimeBtn setBackgroundImage:[UIImage imageNamed:@"map_left_chosen"] forState:UIControlStateNormal];
//    [realtimeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [hourBtn setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
//    [hourBtn setBackgroundImage:[UIImage imageNamed:@"map_right"] forState:UIControlStateNormal];
//    
//    //[self hiddenTableView];
    
    [self.mapview removeAnnotations:currentAnnotations];
    currentAnnotations = nil;
    flag = @"realtime";
    [self loadMap];
}

//点击小时图触发的函数
-(void)hourAverage:(id)sender
{
    if ([flag isEqualToString:@"hour"]) {
        return;
    }
    
    [realtimeBtn setSelected:NO];
    [hourBtn setSelected:YES];
    
//    self.nowButton.backgroundColor = [UIColor greenColor];
//    [realtimeBtn setBackgroundImage:[UIImage imageNamed:@"map_right"] forState:UIControlStateNormal];
//    [realtimeBtn setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
//    [hourBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [hourBtn setBackgroundImage:[UIImage imageNamed:@"map_right_chosen"] forState:UIControlStateNormal];
    
    [self.mapview removeAnnotations:currentAnnotations];
    currentAnnotations = nil;
    flag = @"hour";
    [self loadMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"heavy");
    // Dispose of any resources that can be recreated.
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView
           viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"annotation";
    
    MKAnnotationView *pinView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (pinView == nil) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pinView.canShowCallout = YES;
        //pinView.animatesDrop = YES;
    }
    
    pinView.annotation = annotation;
    
//    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//    if (pinView == nil) {
//        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
//                                                  reuseIdentifier:identifier];
//    }
    
    if ([annotation isKindOfClass:[AnnotationInMap class]]) {
        
        if ([selectionName isEqualToString:@"spm"]) {
            if ([((AnnotationInMap *)annotation).title doubleValue] > 150) {
                //[pinView setImage:[UIImage imageNamed:@"annotation_innormal"]];
                //pinView.pinColor = MKPinAnnotationColorRed;
                pinView.image = [UIImage imageNamed:@"annotation_innormal"];
            }else{
                //[pinView setImage:[UIImage imageNamed:@"annotation_normal"]];
                //pinView.pinColor = MKPinAnnotationColorGreen;
                pinView.image = [UIImage imageNamed:@"annotation_normal"];
            }
        }else{
            //get current time
            NSDate *date = [NSDate date];
            NSCalendar *cal = [NSCalendar currentCalendar];
            NSDateComponents *components = [cal components:NSCalendarUnitHour fromDate:date];
            
            //NSString *strHour = [NSString stringWithFormat:@"hour is %ld", (long)[components hour]];
            //íNSLog(@"%@", strHour);
            
            //NSString *strHour = [NSString stringWithFormat:@"%d" ,[components hour]];
            if ([components hour] >= 6 && [components hour] <= 22) {
                if ([((AnnotationInMap *)annotation).title doubleValue] > 70) {
                    pinView.image = [UIImage imageNamed:@"annotation_innormal"];
                    //NSLog(@"hrer");
                }else{
                    pinView.image = [UIImage imageNamed:@"annotation_normal"];
                }
            }else{
                if ([((AnnotationInMap *)annotation).title doubleValue] > 55) {
                    pinView.image = [UIImage imageNamed:@"annotation_innormal"];
                    
                    NSLog(@"%.1f", [((AnnotationInMap *)annotation).title doubleValue]);
                }else{
                    pinView.image = [UIImage imageNamed:@"annotation_normal"];
                }
            }
            
        }
        //pinView.pinColor = MKPinAnnotationColorRed;
        //pinView.canShowCallout = YES;
        
        pinView.annotation = annotation;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
         [rightButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
         pinView.rightCalloutAccessoryView = rightButton;
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[AnnotationInMap class]] == NO) {
        return;
    }
    AnnotationInMap *annotation = (AnnotationInMap *)view.annotation;
    _choosePlaceId = annotation.tag;
    _portalName = annotation.subtitle;
}

#pragma mark -relocate

-(void) relocate
{
    //精度
    MKCoordinateSpan span= {0.08, 0.08};
    MKCoordinateRegion region = {self.regionCoord, span};
    [self.mapview setRegion:region animated:YES];
    
    if ([currentAnnotations count]) {
        [self.mapview removeAnnotations:currentAnnotations];
    }
    
    currentAnnotations = nil;
    [self loadMap];
}

-(void) refresh
{
    [self assignForAddressInfo];
}

#pragma mark -enterintochoosecsite
-(void) enterinto_choosecsite
{
    chooseCsiteViewController *chooseCsiteVC = [[chooseCsiteViewController alloc] init];
    
    
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"返回";
    self.navigationItem.backBarButtonItem = backbutton;
    
    self.hidesBottomBarWhenPushed = YES;
    
    //[self.navigationController pushViewController:attentionView animated:NO];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:chooseCsiteVC animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
}

#pragma mark -enterintodetail
-(void)push
{
    NSString *csite_id = _choosePlaceId;
    NSMutableDictionary *spot = [csite_dict objectForKey:csite_id];
    NSString *csite_name = [spot objectForKey:@"csite_name"];
    [[NSUserDefaults standardUserDefaults] setObject:csite_id forKey:@"csite_id"];
    [[NSUserDefaults standardUserDefaults] setObject:csite_name forKey:@"csite_name"];
    singleTabBarController *secondview = [[singleTabBarController alloc] init];
    [self presentViewController:secondview animated:YES completion:^{}];
    
//    SceneViewController *sceneViewController = [[SceneViewController alloc] init];
//    sceneViewController.portalID = _choosePlaceId;
//    sceneViewController.portalname = _portalName;
//    //在父视图中才能修改back
//    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
//    backbutton.title = @"地图";
//    
//    self.navigationItem.backBarButtonItem = backbutton;
//    [self.navigationController pushViewController:sceneViewController animated:YES];
}

#pragma mark -back
-(void) back
{
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
-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

- (void) show_activity:(NSString*) title {
    UIView *viewToUse = self.view;
    [DejalBezelActivityView activityViewForView:viewToUse withLabel:title width:100];
}

- (void) remove_activity {
    [DejalBezelActivityView removeViewAnimated:YES];
}

@end
