//
//  nightNoiseViewController.m
//  qly
//
//  Created by anne on 15/7/10.
//  Copyright (c) 2015年 zxy. All rights reserved.
//

#import "nightNoiseViewController.h"

#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface nightNoiseViewController ()<UIComboBoxDelegate>
@property (weak, nonatomic) IBOutlet UIComboBox *myComboBox;
@end

@implementation nightNoiseViewController

@synthesize myScrollView;
@synthesize getArray;
@synthesize getArray2;
@synthesize pick;
@synthesize spot_list = _spot_list;

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
    
    screen_width = (double)[UIScreen mainScreen].applicationFrame.size.width;
    screen_height = (double)[UIScreen mainScreen].applicationFrame.size.height;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    
    int timeBtnWidth = 90;
    int timeBtnHeight = 30;
    float timeLblX = screen_width/20;
    int timeBtnY = 60;
    int checkBtnX = (screen_width - timeBtnWidth * 3) / 2;
    
    float buttonWidth = (screen_width -timeLblX-230)/1.5;
    float buttonHeight = buttonWidth/2.3;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(back)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"夜间噪声(dB)";
    
    self.navigationItem.titleView = titleLabel;
    
    
    startLbl= [[UILabel alloc]initWithFrame:CGRectMake(timeLblX,
                                                       timeBtnHeight + timeBtnY ,
                                                       110.0,
                                                       25.0)];
    startLbl.text=@"选择开始时间：";
    [startLbl setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
    startLbl.textColor= [UIColor colorWithRed:58/255.0
                                        green:149/255.0
                                         blue:223/255.0
                                        alpha:1];
    [self.view addSubview:startLbl];
    
    endLbl = [[UILabel alloc]initWithFrame:CGRectMake(timeLblX,
                                                      timeBtnHeight + timeBtnY + 30,
                                                      110.0,
                                                      25.0)];
    endLbl.text=@"选择结束时间：";
    [endLbl setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
    endLbl.textColor= [UIColor colorWithRed:58/255.0
                                      green:149/255.0
                                       blue:223/255.0
                                      alpha:1];
    [self.view addSubview:endLbl];
    
    cite = [[UILabel alloc]initWithFrame:CGRectMake(timeLblX,
                                                    timeBtnHeight + timeBtnY + 60,
                                                    110.0,
                                                    25.0)];
    cite.text=@"监测地点：";
    [cite setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
    cite.textColor= [UIColor colorWithRed:58/255.0
                                    green:149/255.0
                                     blue:223/255.0
                                    alpha:1];
    [self.view addSubview:cite];
    
    startShow = [[UILabel alloc]initWithFrame:CGRectMake(timeLblX+120,timeBtnHeight + timeBtnY ,110,25.0)];
    [startShow setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
    endShow = [[UILabel alloc]initWithFrame:CGRectMake(timeLblX+120,timeBtnHeight + timeBtnY + 30,110,25.0)];
    [endShow setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
    
    
    
    
    startChoose			= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startChoose.frame				= CGRectMake(timeLblX+110,timeBtnHeight + timeBtnY,130,25.0);
    [startChoose setBackgroundImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    [startChoose addTarget:self action:@selector(select_time_begin:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:startChoose];
    
    endChoose			= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    endChoose.frame				= CGRectMake(timeLblX+110,timeBtnHeight + timeBtnY + 30,130,25.0);
    [endChoose setBackgroundImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    [endChoose addTarget:self action:@selector(select_time_end:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:endChoose];
    
    [self.view addSubview:startShow];
    [self.view addSubview:endShow];
    
    //check Button
    check			= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    check.frame				= CGRectMake(timeLblX+250,timeBtnHeight + timeBtnY ,buttonWidth,buttonHeight);
    [check setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [check addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:check];
    
    [self.view addSubview:startShow];
    [self.view addSubview:endShow];
    
    [self setDefaultTime];
    
    [self getList];
    
    
#if 0
    UIComboBox *box = [[UIComboBox alloc] initWithFrame:CGRectMake(timeLblX+80,timeBtnHeight + timeBtnY + 60,screen_width-timeLblX-90,26.0)];
#else
    UIComboBox *box = [[UIComboBox alloc] init];
    box.frame = CGRectMake(timeLblX+80,timeBtnHeight + timeBtnY + 60,screen_width-timeLblX-90,26);
    box.font=[UIFont fontWithName:@"GeezaPro" size:14];
#endif
    box.delegate = self;
    box.entries = put;
    box.selectedItem = 0;
    
    csite_id=[index objectAtIndex:0];
    
    [self.view addSubview:box];
    
    [self search:nil];
    //[self search];
    
}

-(void)getList
{
    self.spot_list = [[NSUserDefaults standardUserDefaults] objectForKey:@"spot_list"];
    //   NSMutableDictionary *spot = [[NSMutableDictionary alloc]init];
    put= [[NSMutableArray alloc]init];
    index= [[NSMutableArray alloc]init];
    for(int i=0;i<self.spot_list.count;i++)
    {
        
        [put addObject:[[self.spot_list objectAtIndex:i] objectForKey:@"csite_name"]];
        [index addObject:[[self.spot_list objectAtIndex:i] objectForKey:@"csite_id"]];
        
    }
    
}

- (IBAction)search:(id)sender
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式
    
    NSString *st = [dateFormat stringFromDate:starttime] ;
    NSString *et = [dateFormat stringFromDate:endtime];
    
    NSDate *dateS =[dateFormat  dateFromString:st];
    NSDate *dateE =[dateFormat dateFromString:et];
    
    bool islate=[dateE isEqualToDate:[dateS laterDate:dateE]];
    
    if (startShow.text&&endShow.text) {
        
        if (!islate)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message: @"起始时间不能晚于结束时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            NSString *start_time = startShow.text;
            NSString *end_time = endShow.text;
            [self getHistoryData:start_time end:end_time];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message: @"请选择时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}


//search data
-(void)getHistoryData:(NSString*) start_time end:(NSString*) end_time {
    [self show_activity:@"正在加载数据"];
    NSLog(@"re::::%@,%@,%@",csite_id,start_time,end_time);
    [[myNetworking sharedClient] GET:@"nightNoiseOverview" parameters:@{@"csite_id":csite_id,@"begin_time":start_time,@"end_time":end_time}
                             success: ^(AFHTTPRequestOperation *operation, id result) {
                                 [self loadChart:result];
                                 NSLog(@"%@",result);
                                 [self remove_activity];
                             } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                                 NSLog(@"%@", error);
                                 [self remove_activity];
                                 
                                 [self alertWithTitle:@"加载数据失败" withMsg:@"请稍后重试"];
                             }];
}

-(void) setDefaultTime
{
    
    starttime = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*8];
    startShow.text = [starttime.description substringToIndex:10];
    //   startShow.text = [self dateAddedBy8Hours:start];
    endtime = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
    endShow.text = [endtime.description substringToIndex:10];
    //   endShow.text = [self dateAddedBy8Hours:end];
    
}


-(void)loadChart:(NSArray*) sample_list {
    
    NSMutableArray *time_array = [[NSMutableArray alloc] init];
    NSMutableArray *data_array = [[NSMutableArray alloc] init];
    float max_height = 0;
    for (int i = 0; i < sample_list.count; i++) {
        NSDictionary *sample = sample_list[i];
        [time_array addObject:[sample objectForKey:@"time"]];
        float data = [[sample objectForKey:@"value"] doubleValue];
        NSNumber *n=[[NSNumber alloc]initWithFloat:data];
        [data_array addObject:n];
        
        float height = data;
        if (height > max_height) {
            max_height = height;
        }
    }
    max_height *= 1.2;
    if (max_height <= 1)
        max_height = 1;
    [self paint:max_height time:time_array data:data_array];
    [self loadData:55 time:time_array];
}

-(void)paint: (float)max_height time:(NSMutableArray*) time_array data:(NSMutableArray*) data_array
{
    [myScrollView removeFromSuperview];
    
    _values	= [NSMutableArray arrayWithArray:data_array];
    _barColors						= @[[UIColor colorWithRed:125/255.0 green:193/255.0 blue:236/255.0 alpha:0.3]];
    _currentBarColor				= 0;
    float chart_width = data_array.count * 30;
    CGRect chartFrame				= CGRectMake(0.0,
                                                 0.0,
                                                 chart_width,
                                                 screen_width / 1.2);
    _chart							= [[SimpleBarChart alloc] initWithFrame:chartFrame];
    
    NSArray *a=  [NSMutableArray arrayWithArray:time_array];
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
    _chart.incrementValue			= max_height;//10;
    _chart.barTextType				= SimpleBarChartBarTextTypeTop;
    _chart.barTextColor				= [UIColor blackColor];
    _chart.gridColor				= [UIColor grayColor];
    
    
    //滚动条
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:_chart];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    
    myScrollView.contentSize = CGSizeMake(chart_width*1.9, 0);
    myScrollView.delegate = self;
    //旋转柱状图
    myScrollView.transform = CGAffineTransformIdentity;
    myScrollView.transform = CGAffineTransformMakeRotation(DEGREES_RADIANS(90));
    
    myScrollView.frame = CGRectMake(0, 190, screen_width, chart_width);
    
    [self.view addSubview:myScrollView];
    
}


- (void)loadData:(double) standard time:(NSMutableArray*) time_array
{
    
    NSArray *a=  [NSMutableArray arrayWithArray:time_array];
    [_chart getXSource:a];
    
    //set data with standard
    [_chart reloadData:standard];
}



- (IBAction)select_time_begin:(id)sender
{
    beginOrEnd = @"begin";
    [self select_time];
}

- (IBAction)select_time_end:(id)sender
{
    beginOrEnd = @"end";
    [self select_time];
}

-(void) select_time
{
    NSDate *date;
    //    if ([time_type isEqualToString:@"realtime"]) {
    //        if ([beginOrEnd isEqualToString:@"begin"]) {
    //            date = [NSDate dateWithTimeIntervalSinceNow:-60*60];
    //        } else if ([beginOrEnd isEqualToString:@"end"]) {
    //            date = [NSDate dateWithTimeIntervalSinceNow:0];
    //        }
    //        pick=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:NO];
    //    } else if ([time_type isEqualToString:@"hour"]) {
    //        if ([beginOrEnd isEqualToString:@"begin"]) {
    //            date = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
    //        } else if ([beginOrEnd isEqualToString:@"end"]) {
    //            date = [NSDate dateWithTimeIntervalSinceNow:0];
    //        }
    //        pick=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:NO];
    //    } else if ([time_type isEqualToString:@"day"]) {
    //        if ([beginOrEnd isEqualToString:@"begin"]) {
    //            date = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*7];
    //        } else if ([beginOrEnd isEqualToString:@"end"]) {
    //            date = [NSDate dateWithTimeIntervalSinceNow:0];
    //        }
    //        pick=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    //    }
    date = [NSDate dateWithTimeIntervalSinceNow:0];
    pick=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    pick.delegate=self;
    [self.view addSubview:pick];
}

- (void)loadData:(double) standard
{
    
    NSArray *a=  [NSMutableArray arrayWithArray:getArray2];
    [_chart getXSource:a];
    
    //set data with standard
    [_chart reloadData:standard];
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式
    
    if ([beginOrEnd isEqualToString:@"begin"]) {
        startShow.text = [self dateAddedBy8Hours:resultString];
        starttime=[dateFormat  dateFromString:startShow.text];
        startShow.text = [startShow.text substringToIndex:10];
    }
    else if ([beginOrEnd isEqualToString:@"end"]) {
        
        endShow.text = [self dateAddedBy8Hours:resultString];
        endtime=[dateFormat  dateFromString:endShow.text];
        endShow.text = [endShow.text substringToIndex:10];
    }
    
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

#pragma mark SimpleBarChartDataSource

- (NSUInteger)numberOfBarsInBarChart:(SimpleBarChart *)barChart
{
    return _values.count;
}
-(void) back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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


#pragma mark -enterintochoosecsite
-(void) enterinto_choosecsite
{
    // chooseCsiteViewController *attentionView = [[chooseCsiteViewController alloc] init];
    
    
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"返回";
    self.navigationItem.backBarButtonItem = backbutton;
    
    //[self.navigationController pushViewController:attentionView animated:NO];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    //   [self.navigationController pushViewController:attentionView animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void)comboBox:(UIComboBox *)comboBox selected:(int)selected {
    
    csite_id=[index objectAtIndex:selected];
    NSLog(@"%@ select changed to %@", comboBox, csite_id);
    [self search:nil];
    
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
