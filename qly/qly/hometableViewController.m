//
//  hometableViewController.m
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2015年 zxy. All rights reserved.
//

#import "hometableViewController.h"


#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface hometableViewController (){
    UILabel *titleLabel;
}

@end

@implementation hometableViewController

@synthesize myScrollView;
@synthesize getArray;
@synthesize getArray2;
@synthesize nowTableBtn;
@synthesize hourTableBtn;

NSString *chart_type;



-  (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        
    }
    return self;
}

- (void)loadView
{
    UIView *baseview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view = baseview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    screen_width = (double)[UIScreen mainScreen].applicationFrame.size.width;
    screen_height = (double)[UIScreen mainScreen].applicationFrame.size.height;
    
    float buttonWidth = screen_width * 0.5;
    float buttonHeight = 44 / 568.0 * screen_height;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"corner_button"]
//                                                                              style:UIBarButtonItemStylePlain
//                                                                             target:self
//                                                                             action:@selector(enterinto_choosecsite)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(back)];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //实时数据Button
    nowTableBtn= [[UIButton alloc] initWithFrame:CGRectMake(0, 64, buttonWidth, buttonHeight)];
    [nowTableBtn setTitle:@"实时数据" forState:UIControlStateNormal];
    [nowTableBtn setBackgroundImage:[UIImage imageNamed:@"top_button"] forState:UIControlStateNormal];
    [nowTableBtn setBackgroundImage:[UIImage imageNamed:@"top_button_selected"] forState:UIControlStateSelected];
    nowTableBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [nowTableBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [nowTableBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [nowTableBtn setTitleColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1] forState:UIControlStateSelected];
    [nowTableBtn addTarget:self action:@selector(nowBtn)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nowTableBtn];
    
    //时均值Button
    hourTableBtn =[[UIButton alloc] initWithFrame:CGRectMake(buttonWidth, 64, buttonWidth, buttonHeight)];
    [hourTableBtn setBackgroundImage:[UIImage imageNamed:@"top_button"] forState:UIControlStateNormal];
    [hourTableBtn setBackgroundImage:[UIImage imageNamed:@"top_button_selected"] forState:UIControlStateSelected];
    [hourTableBtn setTitle:@"小时数据" forState:UIControlStateNormal];
    hourTableBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [hourTableBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [hourTableBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [hourTableBtn setTitleColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1] forState:UIControlStateSelected];
    [hourTableBtn addTarget:self action:@selector(hourBtn)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hourTableBtn];
    
    [nowTableBtn setSelected:YES];
}



-(NSMutableArray*) makeOrderedSpotList {
    
    NSMutableArray *spot_list = [[NSUserDefaults standardUserDefaults] objectForKey:@"spot_list"];
    
    NSMutableArray *ordered_spot_list = [[NSMutableArray alloc] initWithCapacity:10];
    
    // remove spot whose data is 0
    for (int i = 0; i < spot_list.count; i++) {
        NSMutableDictionary *spot = [spot_list objectAtIndex:i];
        double data = [[spot objectForKey:chart_type] doubleValue];
        if (data != 0) {
            [ordered_spot_list addObject:spot];
        }
    }
    
    // bubble sort the array by data value in descent order
    if (ordered_spot_list.count <= 0)
        return ordered_spot_list;
    
    for (int i = 0; i < ordered_spot_list.count - 1; i++) {
        for (int j = i; j < ordered_spot_list.count; j++) {
            NSMutableDictionary *spot_first = [ordered_spot_list objectAtIndex:i];
            double data_first = [[spot_first objectForKey:chart_type] doubleValue];
            
            NSMutableDictionary *spot_second = [ordered_spot_list objectAtIndex:j];
            double data_second = [[spot_second objectForKey:chart_type] doubleValue];
            
            if (data_first < data_second) {
                ordered_spot_list[i] = spot_second;
                ordered_spot_list[j] = spot_first;
            }
        }
    }
    return ordered_spot_list;
}

-(void)loadChartNow
{
    NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    chart_type = nil;
    double standard = 0;
    if ([type isEqualToString:@"spm"]) {
        chart_type = @"realtime_dust";
        standard = 150;
    } else if ([type isEqualToString:@"noise"]) {
        chart_type = @"realtime_noise_20min";
        //get current time
        NSDate *date = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:NSCalendarUnitHour fromDate:date];
        
        if ([components hour] >= 6 && [components hour] <= 22) {
            standard = 70;
        } else {
            standard = 55;
        }
        
    }
    getArray = [[NSMutableArray alloc] init];
    getArray2 = [[NSMutableArray alloc] init];
//    NSMutableArray *spot_list = [[NSUserDefaults standardUserDefaults] objectForKey:@"spot_list"];
    double max_height = 0;
    NSMutableArray *ordered_spot_list = [self makeOrderedSpotList];
    for (int i = 0; i < ordered_spot_list.count; i++) {
        NSMutableDictionary *spot = [ordered_spot_list objectAtIndex:i];
        [getArray2 addObject: [spot objectForKey:@"csite_short_name"]];
        NSNumber *n=[[NSNumber alloc]initWithFloat:[[spot objectForKey:chart_type] intValue]];
        [getArray addObject:n];
        
        double height = 0;
        if ([type isEqualToString:@"spm"]) {
            height = [[spot objectForKey:@"realtime_dust"] doubleValue];
        } else if ([type isEqualToString:@"noise"]) {
            height = [[spot objectForKey:@"realtime_noise_20min"] doubleValue];
        }
        
        if (height > max_height) {
            max_height = height;
        }
        
    }
    _values	= [NSMutableArray arrayWithArray:getArray];
    max_height *= 1.2;
    if (max_height <= 1)
        max_height = 1;
    [self paint:max_height];
    [self loadData:standard];
    
}

-(void)loadChartHour
{
    NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    chart_type = nil;
    double standard = 0;
    if ([type isEqualToString:@"spm"]) {
        chart_type = @"hour_dust";
        standard = 150;
    } else if ([type isEqualToString:@"noise"]) {
        chart_type = @"hour_noise";
        //get current time
        NSDate *date = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:NSCalendarUnitHour fromDate:date];
        if ([components hour] >= 6 && [components hour] <= 22) {
            standard = 70;
        } else {
            standard = 55;
        }

    }
    getArray = [[NSMutableArray alloc] init];
    getArray2 = [[NSMutableArray alloc] init];
//    NSMutableArray *spot_list = [[NSUserDefaults standardUserDefaults] objectForKey:@"spot_list"];
    NSMutableArray *ordered_spot_list = [self makeOrderedSpotList];
    double max_height = 0;
    for (int i = 0; i < ordered_spot_list.count; i++) {
        NSMutableDictionary *spot = [ordered_spot_list objectAtIndex:i];
        [getArray2 addObject: [spot objectForKey:@"csite_short_name"]];
        NSNumber *n=[[NSNumber alloc]initWithFloat:[[spot objectForKey:chart_type] intValue]];
        [getArray addObject:n];
        
        double height = 0;
        if ([type isEqualToString:@"spm"]) {
            height = [[spot objectForKey:@"hour_dust"] doubleValue];
        } else if ([type isEqualToString:@"noise"]) {
            height = [[spot objectForKey:@"hour_noise"] doubleValue];
        }
        
        if (height > max_height) {
            max_height = height;
        }
    }
    max_height *= 1.2;
    if (max_height <= 1)
        max_height = 1;
    _values	= [NSMutableArray arrayWithArray:getArray];
    [self paint:max_height];
    [self loadData:standard];
    
}

-(void)paint: (double)max_height
{
    
    _barColors						= @[[UIColor colorWithRed:125/255.0 green:193/255.0 blue:236/255.0 alpha:0.3]];
    _currentBarColor				= 0;
    float chart_width = getArray2.count * 30;
    if (chart_width <= 450)
        chart_width = 450;
    CGRect chartFrame				= CGRectMake(0.0,
                                                 0.0,
                                                 chart_width,
                                                 screen_width / 1.2);
    _chart							= [[SimpleBarChart alloc] initWithFrame:chartFrame];
    
    NSArray *a=  [NSMutableArray arrayWithArray:getArray2];
    [_chart getXSource:a];
    
    _chart.center					= CGPointMake(chart_width / 2.0, screen_width / 2);
    _chart.delegate					= self;
    _chart.dataSource				= self;
    _chart.barShadowOffset			= CGSizeMake(2.0, 1.0);
    _chart.animationDuration		= 0.5;
    _chart.barShadowColor			= [UIColor grayColor];
    _chart.barShadowAlpha			= 0.5;
    _chart.barShadowRadius			= 1.0;
    _chart.barWidth					= 15.0;
    _chart.xLabelType				= SimpleBarChartXLabelTypeVerticle;
    _chart.yLabelType               = SimpleBarChartYLabelTypeVerticle;
//    _chart.xLabelFont               = [UIFont fontWithName:@"Helvetica" size:12.0];
    _chart.incrementValue			= max_height;//10;
    _chart.barTextType				= SimpleBarChartBarTextTypeTop;
    _chart.barTextColor				= [UIColor blackColor];
    _chart.barType                  = SimpleBarChartBarTypeVerticle;
    _chart.gridColor				= [UIColor grayColor];
    
    //滚动条
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:_chart];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(chart_width*1.5, 0);
    //myScrollView.contentSize = CGSizeMake(chart_width, screen_width);
    myScrollView.delegate = self;
    
    //旋转柱状图
    myScrollView.transform = CGAffineTransformIdentity;
    myScrollView.transform = CGAffineTransformMakeRotation(DEGREES_RADIANS(90));
    
    myScrollView.frame = CGRectMake(0, 120, screen_width, chart_width);
    
    [self.view addSubview:myScrollView];
    
}


- (void)loadData:(double) standard
{
    
    NSArray *a=  [NSMutableArray arrayWithArray:getArray2];
    [_chart getXSource:a];
    
    //set data with standard
    [_chart reloadData:standard];
}

#pragma mark SimpleBarChartDataSource

- (NSUInteger)numberOfBarsInBarChart:(SimpleBarChart *)barChart
{
    return _values.count;
}

- (CGFloat)barChart:(SimpleBarChart *)barChart valueForBarAtIndex:(NSUInteger)index
{
    return [[_values objectAtIndex:index] floatValue];
}

- (NSString *)barChart:(SimpleBarChart *)barChart textForBarAtIndex:(NSUInteger)index
{
    return [[_values objectAtIndex:index] stringValue];
}

- (NSString *)barChart:(SimpleBarChart *)barChart xLabelForBarAtIndex:(NSUInteger)index
{
    return [[_values objectAtIndex:index] stringValue];
}

- (UIColor *)barChart:(SimpleBarChart *)barChart colorForBarAtIndex:(NSUInteger)index
{
    return [_barColors objectAtIndex:_currentBarColor];
}

-(void)nowBtn
{
    [myScrollView removeFromSuperview];
    [self loadChartNow];
    [nowTableBtn setSelected:YES];
    [hourTableBtn setSelected:NO];
}

-(void)hourBtn
{
    [myScrollView removeFromSuperview];
    [self loadChartHour];
    [nowTableBtn setSelected:NO];
    [hourTableBtn setSelected:YES];
}

-(void)push
{
    
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
            //[tableView reloadData];
        }
        [[NSUserDefaults standardUserDefaults] setValue:self.spot_list forKey:@"spot_list"];
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        //[self alertWithTitle:@"加载数据失败" withMsg:@"加载数据失败"];
    }];
}

#pragma mark -enterintochoosecsite
//-(void) enterinto_choosecsite
//{
//    chooseCsiteViewController *attentionView = [[chooseCsiteViewController alloc] init];
//    
//    
//    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
//    backbutton.title = @"返回";
//    self.navigationItem.backBarButtonItem = backbutton;
//    
//    //[self.navigationController pushViewController:attentionView animated:NO];
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.75];
//    [self.navigationController pushViewController:attentionView animated:NO];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
//    [UIView commitAnimations];
//    
//}
-(void) back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self assignForAddressInfo];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"type"] isEqualToString:@"spm"]){
        titleLabel.text = [NSString stringWithFormat:@"%@",@"PM10曲线(ug/m\u00B3)" ] ;
    }
    else  if([[[NSUserDefaults standardUserDefaults] objectForKey:@"type"] isEqualToString:@"noise"]){
        titleLabel.text = [NSString stringWithFormat:@"%@",@"噪声曲线(dB)" ] ;
    }
    self.navigationItem.titleView = titleLabel;
    
    [self loadChartNow];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.myScrollView removeFromSuperview];
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
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
