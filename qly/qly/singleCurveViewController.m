//
//  singleCurveViewController.m
//  qly
//
//  Created by zxy on 15/7/10.
//  Copyright (c) 2015年 zxy. All rights reserved.
//

#import "singleCurveViewController.h"
#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface singleCurveViewController ()

@end

@implementation singleCurveViewController
@synthesize myScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    screen_width = (double)[UIScreen mainScreen].applicationFrame.size.width;
    screen_height = (double)[UIScreen mainScreen].applicationFrame.size.height;
    float buttonWidth = screen_width * 0.5;
    float buttonHeight = 44 / 568.0 * screen_height;
    float buttonWidth3 = screen_width/3;
    
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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    //type=@"factory";
    if ([type isEqualToString:@"spm"]) {
        titleLabel.text = @"24小时颗粒物曲线变化";
        
        pm2_5		= [[UIButton alloc]init];
        pm2_5.frame				= CGRectMake(screen_width-140,70,52,25.0);
        [pm2_5 setBackgroundImage:[UIImage imageNamed:@"pm2_5"] forState:UIControlStateNormal];
        [pm2_5 addTarget:self action:@selector(select_pm2:) forControlEvents:UIControlEventTouchDown];
        [pm2_5 setBackgroundImage:[UIImage imageNamed:@"pm2_5_selected"] forState:UIControlStateSelected];
        
        //  [self.view addSubview:pm2_5];
        
        [pm2_5 setSelected:YES];
        pmtype=@"pm2.5";
        
        pm10			= [[UIButton alloc]init];
        pm10.frame				= CGRectMake(screen_width-70,70,52,25.0);
        [pm10 setBackgroundImage:[UIImage imageNamed:@"pm10"] forState:UIControlStateNormal];
        [pm10 addTarget:self action:@selector(select_pm10:) forControlEvents:UIControlEventTouchDown];
        [pm10 setBackgroundImage:[UIImage imageNamed:@"pm10_selected"] forState:UIControlStateSelected];
        
        //  [self.view addSubview:pm10];
        
    }
    else if ([type isEqualToString:@"noise"]) {
        titleLabel.text = @"24小时内噪声曲线变化";
        
    }
    else if([type isEqualToString:@"water"]){
        titleLabel.text = @"24小时内地表水曲线变化";
        
        //水流速Button
        speed= [[UIButton alloc] initWithFrame:CGRectMake(0, 64, buttonWidth, buttonHeight)];
        [speed setTitle:@"水流速" forState:UIControlStateNormal];
        [speed setBackgroundImage:[UIImage imageNamed:@"top_button"] forState:UIControlStateNormal];
        [speed setBackgroundImage:[UIImage imageNamed:@"top_button_selected"] forState:UIControlStateSelected];
        speed.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [speed setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [speed setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [speed setTitleColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1] forState:UIControlStateSelected];
        [speed addTarget:self action:@selector(select_speed:)
        forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:speed];
        
        //高锰酸钾Button
        KM =[[UIButton alloc] initWithFrame:CGRectMake(buttonWidth, 64, buttonWidth, buttonHeight)];
        [KM setBackgroundImage:[UIImage imageNamed:@"top_button"] forState:UIControlStateNormal];
        [KM setBackgroundImage:[UIImage imageNamed:@"top_button_selected"] forState:UIControlStateSelected];
        [KM setTitle:@"高锰酸钾" forState:UIControlStateNormal];
        KM.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [KM setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [KM setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [KM setTitleColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1] forState:UIControlStateSelected];
        [KM addTarget:self action:@selector(select_km:)
     forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:KM];
        
        [speed setSelected:YES];
        object_type=@"0";
        
    }
    else if([type isEqualToString:@"factory"]){
        titleLabel.text = @"24小时内污水处理厂曲线变化";
        
        //出水cod Button
        cod= [[UIButton alloc] initWithFrame:CGRectMake(0, 64, buttonWidth3, buttonHeight)];
        [cod setTitle:@"出水COD" forState:UIControlStateNormal];
        [cod setBackgroundImage:[UIImage imageNamed:@"top_button"] forState:UIControlStateNormal];
        [cod setBackgroundImage:[UIImage imageNamed:@"top_button_selected"] forState:UIControlStateSelected];
        cod.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [cod setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [cod setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [cod setTitleColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1] forState:UIControlStateSelected];
        [cod addTarget:self action:@selector(select_cod:)
      forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cod];
        
        //水氨氮 Button
        NH3 =[[UIButton alloc] initWithFrame:CGRectMake(buttonWidth3, 64, buttonWidth3, buttonHeight)];
        [NH3 setBackgroundImage:[UIImage imageNamed:@"top_button"] forState:UIControlStateNormal];
        [NH3 setBackgroundImage:[UIImage imageNamed:@"top_button_selected"] forState:UIControlStateSelected];
        [NH3 setTitle:@"水氨氮" forState:UIControlStateNormal];
        NH3.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [NH3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [NH3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [NH3 setTitleColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1] forState:UIControlStateSelected];
        [NH3 addTarget:self action:@selector(select_nh3:)
      forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:NH3];
        
        
        
        //出水流量 Button
        flow =[[UIButton alloc] initWithFrame:CGRectMake(buttonWidth3*2, 64, buttonWidth3, buttonHeight)];
        [flow setBackgroundImage:[UIImage imageNamed:@"top_button"] forState:UIControlStateNormal];
        [flow setBackgroundImage:[UIImage imageNamed:@"top_button_selected"] forState:UIControlStateSelected];
        [flow setTitle:@"出水流量" forState:UIControlStateNormal];
        flow.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [flow setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [flow setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [flow setTitleColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1] forState:UIControlStateSelected];
        [flow addTarget:self action:@selector(select_flow:)
       forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:flow];
        
        [cod setSelected:YES];
        object_type=@"2";
        
    }
    
    self.navigationItem.titleView = titleLabel;
    
    
    start_show= [[UILabel alloc]initWithFrame:CGRectMake(10,
                                                         70 ,
                                                         110.0,
                                                         35.0)];
    // start_show.text=@"选择开始时间：";
    [start_show setFont:[UIFont fontWithName:@"GeezaPro" size:17]];
    start_show.textColor= [UIColor colorWithRed:58/255.0
                                          green:149/255.0
                                           blue:223/255.0
                                          alpha:1];
    
    
    end_show = [[UILabel alloc]initWithFrame:CGRectMake(90,
                                                        120,
                                                        150.0,
                                                        35.0)];
    // end_show.text=@"选择结束时间：";
    [end_show setFont:[UIFont fontWithName:@"GeezaPro" size:17]];
    end_show.textColor= [UIColor colorWithRed:58/255.0
                                        green:149/255.0
                                         blue:223/255.0
                                        alpha:1];
    
    if([type isEqualToString:@"factory"]||[type isEqualToString:@"water"]){
        end_hour = [[UILabel alloc]initWithFrame:CGRectMake(90,
                                                            120,
                                                            150.0,
                                                            35.0)];
        
    }
    else{
        end_hour = [[UILabel alloc]initWithFrame:CGRectMake(90,
                                                            80,
                                                            150.0,
                                                            35.0)];
        hint = [[UILabel alloc]initWithFrame:CGRectMake(10,
                                                        110,
                                                        200.0,
                                                        35.0)];
        hint.text=@"点击超标点可查看详情";
        [hint setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
        hint.textColor=[UIColor grayColor];
        [self.view addSubview:hint];
        
    }
    [end_hour setFont:[UIFont fontWithName:@"GeezaPro" size:17]];
    end_hour.textColor= [UIColor colorWithRed:58/255.0
                                        green:149/255.0
                                         blue:223/255.0
                                        alpha:1];
    
    if([type isEqualToString:@"factory"]||[type isEqualToString:@"water"]){
        descri = [[UILabel alloc]initWithFrame:CGRectMake(10,
                                                          120,
                                                          230.0,
                                                          35.0)];
        descri.text=@"最新时间：";
    }
    else{
        descri = [[UILabel alloc]initWithFrame:CGRectMake(10,
                                                          80,
                                                          230.0,
                                                          35.0)];
        descri.text=@"最新时间：";
        
    }
    
    [descri setFont:[UIFont fontWithName:@"GeezaPro" size:17]];
    
    descri.textColor= [UIColor colorWithRed:58/255.0
                                      green:149/255.0
                                       blue:223/255.0
                                      alpha:1];
    [self.view addSubview:descri];
    
    
    
    [self setDefaultTime];
    time_type=@"hour";
    x=(screen_width-screen_height+180)/2;
    y=screen_height/3+30;
    width=screen_height-200;
    height=screen_width-100;
    
    if([type isEqualToString:@"water"]){
        picHint = [[UILabel alloc]initWithFrame:CGRectMake(230,
                                                           120,
                                                           200.0,
                                                           35.0)];
        [picHint setFont:[UIFont fontWithName:@"GeezaPro" size:12]];
        picHint.text=@"上图入境端，下图出境端";
        picHint.textColor= [UIColor colorWithRed:192/255.0
                                           green:192/255.0
                                            blue:192/255.0
                                           alpha:1];
        [self.view addSubview:picHint];
        
        csiteID=@"00023209000100";//出境
        csiteID2=@"00023205000100"; //入境
        chart=[self chart1 :start_show.text end:end_show.text csite:csiteID url:@"getWaterHourData" x:10 y:150 width:screen_width-30 height: screen_height/3];
        //chart.transform = CGAffineTransformMakeRotation(DEGREES_RADIANS(90));
        chart.transform = CGAffineTransformIdentity;
        [self.view addSubview:chart];
        
        chart2=[self chart1 :start_show.text end:end_show.text csite:csiteID2 url:@"getWaterHourData" x:10 y:165+screen_height/3 width:screen_width-30 height: screen_height/3];
        chart2.transform = CGAffineTransformIdentity;
        [self.view addSubview:chart2];
    }else if([type isEqualToString:@"factory"]){
        csiteID=@"16115580000001";//处理厂
        url=@"getWaterHourData";
        [self draw];
        
    }else{
        csiteID = [[NSUserDefaults standardUserDefaults] objectForKey:@"csite_id"];
        url=@"getHistoryData";
        [self draw];
    }
    
    
    end_hour.text=[[end_hour.text substringToIndex:14] stringByAppendingString:@"00"];
    [self.view addSubview:end_hour];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jump:) name:@"getDate" object:nil];
}


- (IBAction)select_cod:(id)sender
{
    object_type=@"2";
    [cod setSelected:YES];
    [flow setSelected:NO];
    [NH3 setSelected:NO];
    
    [self draw];
    
}

- (IBAction)select_flow:(id)sender
{
    object_type=@"4";
    [cod setSelected:NO];
    [flow setSelected:YES];
    [NH3 setSelected:NO];
    
    [self draw];
    
}

- (IBAction)select_nh3:(id)sender
{
    object_type=@"3";
    [cod setSelected:NO];
    [flow setSelected:NO];
    [NH3 setSelected:YES];
    
    [self draw];
    
}

- (IBAction)select_speed:(id)sender
{
    object_type=@"0";
    [speed setSelected:YES];
    [KM setSelected:NO];
    
    [self draw];
    
}
- (IBAction)select_km:(id)sender
{
    object_type=@"1";
    [speed setSelected:NO];
    [KM setSelected:YES];
    
    [self draw];
    
}
- (IBAction)select_pm2:(id)sender
{
    pmtype = @"pm2_5";
    [chart removeFromSuperview];
    [self setDefaultTime];
    [self draw];
    [pm2_5 setSelected:YES];
    [pm10 setSelected:NO];
    
}
- (IBAction)select_pm10:(id)sender
{
    pmtype = @"pm10";
    [chart removeFromSuperview];
    [self setDefaultTime];
    [self draw];
    [pm10 setSelected:YES];
    [pm2_5 setSelected:NO];
    
}

-(void)draw{
    [chart removeFromSuperview];
    [chart2 removeFromSuperview];
    
    if([type isEqualToString:@"water"]){
        
        csiteID=@"00023205000100";//出境
        csiteID2=@"00023209000100"; //入境
        chart=[self chart1 :start_show.text end:end_show.text csite:csiteID url:@"getWaterHourData" x:10 y:150 width:screen_width-30 height: screen_height/3];
        //chart.transform = CGAffineTransformMakeRotation(DEGREES_RADIANS(90));
        chart.transform = CGAffineTransformIdentity;
        [self.view addSubview:chart];
        
        chart2=[self chart1 :start_show.text end:end_show.text csite:csiteID2 url:@"getWaterHourData" x:10 y:165+screen_height/3 width:screen_width-30 height: screen_height/3];
        chart2.transform = CGAffineTransformIdentity;
        [self.view addSubview:chart2];
    }else{
        if([type isEqualToString:@"factory"]){
            csiteID=@"16115580000001";//处理厂
            chart=[self chart1 :start_show.text end:end_show.text csite:csiteID url:@"getWaterHourData" x:x y:y width:width height:height];
            
        }else{
            csiteID = [[NSUserDefaults standardUserDefaults] objectForKey:@"csite_id"];
            chart=[self chart1 :start_show.text end:end_show.text csite:csiteID url:@"getHistoryData" x:x y:y width:width height:height];
        }
        chart.transform = CGAffineTransformIdentity;
        chart.transform = CGAffineTransformMakeRotation(DEGREES_RADIANS(90));
        
        [self.view addSubview:chart];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) back {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setDefaultTime
{
    
    starttime = [NSDate dateWithTimeIntervalSinceNow:-60*60*18];
    start_show.text = [starttime.description substringToIndex:16];
    start_show.text = [start_show.text stringByAppendingString:@":00"];
    //   startShow.text = [self dateAddedBy8Hours:start];
    end_show.text = [[NSDate dateWithTimeIntervalSinceNow:0].description substringToIndex:19];
    end_show.text = [self dateAddedBy8Hours:end_show.text];
    end_hour.text= end_show.text;
    hour=[start_show.text substringWithRange:NSMakeRange(11,2)];
    NSLog(@"%@....%@",start_show.text,hour);
}

-(NSString*) dateAddedBy8Hours:(NSString*) time
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 添加8小时
    time = [time substringToIndex:19];
    NSDate *date = [dateFormat dateFromString:time];
    NSDateComponents *dayComponents = [[NSDateComponents alloc] init];
    dayComponents.hour = 16;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    date = [calendar dateByAddingComponents:dayComponents toDate:date options:0];
    time = [date.description substringToIndex:19];
    return time;
}

-(FSLineChart*)chart1:(NSString*) start_time end:(NSString*) end_time csite:(NSString*) csite_id url:(NSString*) url x:(int) x y:(int) y width:(int) width height:(int) height {
    
    srand(time(nil));
    
    NSString *chart_type = nil;
    double standard = 0;
    
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(x,y,width,height)];
    
    //NSLog(@"cccc%@  %@  %@",start_time,end_time,csite_id);
    
    if([type isEqualToString:@"spm"] || [type isEqualToString:@"noise"]){
        if ([type isEqualToString:@"spm"]) {
            if([pmtype isEqualToString:@"pm10"]){
                chart_type = @"pm10";
                standard = 1;
            }
            else{
                chart_type = @"pm2_5";
                standard = 1;
            }
        } else if ([type isEqualToString:@"noise"]) {
            chart_type = @"noise";
        }
        [self show_activity:@"正在加载数据"];
        [[myNetworking sharedClient] GET:url parameters:@{@"csite_id":csite_id,@"begin_time":start_time,@"end_time":end_time, @"time_type":time_type}
                                 success: ^(AFHTTPRequestOperation *operation, id result) {
                                     NSArray *array = result;
                                     //  NSLog(@"%@",result);
                                     if([array count]!=0){
                                         chartData= [[NSMutableArray alloc]init];
                                         for (int i = 0 ; i < array.count; i ++) {
                                             NSDictionary *temp = array[i];
                                             
                                             if([[temp objectForKey:chart_type] doubleValue]>0.00){
                                                 NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:chart_type] doubleValue]];
                                                 
                                                 [chartData addObject:n];
                                             }
                                         }
                                         
                                         // Creating the line chart
                                         
                                         lineChart.verticalGridStep = 4;
                                         lineChart.horizontalGridStep = 10;
                                         lineChart.labelForIndex = ^(NSUInteger item) {
                                             //   NSLog(@"是%@",[NSString stringWithFormat:@"%lu",(unsigned long)item]);
                                             return [NSString stringWithFormat:@"%lu",(unsigned long)item];
                                         };
                                         
                                         lineChart.labelForValue = ^(CGFloat value) {
                                             return [NSString stringWithFormat:@"%.f", value];
                                         };
                                         
                                         [lineChart setChartData:chartData start:[starttime.description substringToIndex:13]];
                                         
                                     }
                                     else{
                                         [self alertWithTitle:@"没有信息" withMsg:@"该监测点没有此项数据"];
                                     }
                                     [self remove_activity];
                                 } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"%@", error);
                                     [self remove_activity];
                                     
                                     [self alertWithTitle:@"加载数据失败" withMsg:@"请稍后重试"];
                                 }];
        return lineChart;
    }
    else{
        
        [self show_activity:@"正在加载数据"];
        
        [[myNetworking sharedClient] GET:url parameters:@{@"csite_id":csite_id,@"end_time":end_time, @"object_type":object_type}
                                 success: ^(AFHTTPRequestOperation *operation, id result) {
                                     NSArray *array = result;
                                     //  NSLog(@"%@，kkk %@ kkk %@",result,end_time,object_type);
                                     if([array count]!=0){
                                         chartData= [[NSMutableArray alloc]init];
                                         for (int i = 0 ; i < array.count; i ++) {
                                             
                                             NSNumber *n=[[NSNumber alloc]initWithFloat:[array[i] doubleValue]];
                                             [chartData addObject:n];
                                             
                                         }
                                         
                                         // Creating the line chart
                                         
                                         lineChart.verticalGridStep = 4;
                                         lineChart.horizontalGridStep = 10;
                                         lineChart.labelForIndex = ^(NSUInteger item) {
                                             return [NSString stringWithFormat:@"%lu",(unsigned long)item];
                                         };
                                         
                                         lineChart.labelForValue = ^(CGFloat value) {
                                             return [NSString stringWithFormat:@"%.f", value];
                                         };
                                         
                                         [lineChart setChartData:chartData start:[starttime.description substringToIndex:13]];
                                         
                                     }
                                     else{
                                         [self alertWithTitle:@"没有信息" withMsg:@"该监测点没有此项数据"];
                                     }
                                     [self remove_activity];
                                 } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"%@", error);
                                     [self remove_activity];
                                     
                                     [self alertWithTitle:@"加载数据失败" withMsg:@"请稍后重试"];
                                 }];
        return lineChart;
        
    }
    
}

- (void) show_activity:(NSString*) title {
    UIView *viewToUse = self.view;
    [DejalBezelActivityView activityViewForView:viewToUse withLabel:title width:100];
}

- (void) remove_activity {
    [DejalBezelActivityView removeViewAnimated:YES];
}

- (void) alertWithTitle:(NSString *)title withMsg:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation

{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    
}

- (BOOL)shouldAutorotate

{
    
    return NO;
    
}

- (NSUInteger)supportedInterfaceOrientations

{
    
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
    
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)jump:(NSNotification*) notification{
    [self show_activity:@"正在加载数据"];
    NSLog(@"here i jump!!!");
    NSDate *obj = [notification object];//获取到传递的对象
    NSString *date=[NSString stringWithFormat:@"%f", [obj timeIntervalSince1970]];
    NSLog(@"choose my date:%@", obj);
    [[NSUserDefaults standardUserDefaults] setValue:@"curve" forKey:@"playback_type"];
    [[NSUserDefaults standardUserDefaults] setValue:date forKey:@"playback_time"];
    //   [[NSUserDefaults standardUserDefaults] setValue:@"1441546618.619412" forKey:@"playback_time"];
    
    self.tabBarController.selectedIndex = 0;
    [self remove_activity];
}
@end
