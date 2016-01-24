//
//  spmDistributionViewController.m
//  qly
//
//  Created by anne on 15/7/10.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import "spmDistributionViewController.h"

@interface spmDistributionViewController ()

@end

@implementation spmDistributionViewController

@synthesize myScrollView;
@synthesize pick;
@synthesize spot_list = _spot_list;
@synthesize pieView10;
@synthesize pieView2_5;

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
    titleLabel.text = @"颗粒物分布";
    
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
    NSString* city_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"city_id"];
    [self show_activity:@"正在加载数据"];
    [[myNetworking sharedClient] GET:@"pmDistribution" parameters:@{@"city_id":city_id,@"start_time":start_time,@"end_time":end_time}
                             success: ^(AFHTTPRequestOperation *operation, id result) {
                                 //   NSLog(@"%@",result);
                                 
                                 NSArray *array = result;
                                 if([array count]!=0){
                                     for(int i=0;i<array.count;i++){
                                         NSDictionary *temp = array[i];
                                         if([csite_id floatValue]-[[temp objectForKey:@"csite_id"] floatValue]<0.001 ){
                                             [self paint:temp];
                                             NSLog(@"%@",temp);
                                             break;
                                         }
                                     }
                                 }
                                 else{
                                     [self alertWithTitle:@"提示" withMsg:@"此监测点无信息"];
                                 }
                                 
                                 [self remove_activity];
                             } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                                 NSLog(@"%@", error);
                                 [self remove_activity];
                                 
                                 [self alertWithTitle:@"加载数据失败" withMsg:@"请稍后重试"];
                             }];
}

-(void)paint: (NSDictionary *) array{
    [myScrollView removeFromSuperview];
    
    pieView2_5 =[[Example2PieView alloc]initWithFrame:CGRectMake(0,0.0,screen_width+60,250.0)];
    pieView2_5.backgroundColor=[UIColor clearColor];
    //for(int i=0;i<array.count;i++){
    
    if( [[array objectForKey:@"pm2_5_green" ] floatValue]>0.000001){
        MyPieElement* elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm2_5_green" ] floatValue] color:[UIColor colorWithRed:192/255.0 green:255/255.0 blue:62/255.0 alpha:1]];
        [pieView2_5.layer addValues:@[elem]  animated:NO];
        elem.title = @"0-50";
        float b=[[array objectForKey:@"pm2_5_green" ] floatValue];
        NSString *a =[NSString stringWithFormat:@"：%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
        
    }
    
    if( [[array objectForKey:@"pm2_5_yellow" ] floatValue]>0.000001){
        MyPieElement* elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm2_5_yellow" ] floatValue] color:[UIColor colorWithRed:103/255.0 green:203/255.0 blue:243/255.0 alpha:1]];
        [pieView2_5.layer addValues:@[elem]  animated:NO];
        elem.title = @"51-100";
        float b=[[array objectForKey:@"pm2_5_yellow" ] floatValue];
        NSString *a =[NSString stringWithFormat:@":%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    if( [[array objectForKey:@"pm2_5_orange" ] floatValue]>0.000001){
        
        MyPieElement*  elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm2_5_orange" ] floatValue] color:[UIColor colorWithRed:88/255.0 green:175/255.0 blue:231/255.0 alpha:1]];
        [pieView2_5.layer addValues:@[elem]  animated:NO];
        elem.title = @"101-150";
        float b=[[array objectForKey:@"pm2_5_orange" ] floatValue];
        NSString *a =[NSString stringWithFormat:@":%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    if( [[array objectForKey:@"pm2_5_red" ] floatValue]>0.000001){
        MyPieElement*   elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm2_5_red" ] floatValue] color:[UIColor colorWithRed:244/255.0 green:56/255.0 blue:70/255.0 alpha:1]];
        [pieView2_5.layer addValues:@[elem]  animated:NO];
        elem.title = @"151-200";
        float b=[[array objectForKey:@"pm2_5_red" ] floatValue];
        NSString *a =[NSString stringWithFormat:@":%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    if( [[array objectForKey:@"pm2_5_purple" ] floatValue]>0.000001){
        MyPieElement*  elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm2_5_purple" ] floatValue] color:[UIColor colorWithRed:248/255.0 green:223/255.0 blue:84/255.0 alpha:1]];
        [pieView2_5.layer addValues:@[elem]  animated:NO];
        elem.title = @"201-300";
        float b=[[array objectForKey:@"pm2_5_purple" ] floatValue];
        NSString *a =[NSString stringWithFormat:@":%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    if( [[array objectForKey:@"pm2_5_maroon" ] floatValue]>0.000001){
        MyPieElement* elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm2_5_maroon" ] floatValue] color:[UIColor colorWithRed:0/255.0 green:145/255.0 blue:231/255.0 alpha:1]];
        [pieView2_5.layer addValues:@[elem]  animated:NO];
        elem.title = @">300";
        float b=[[array objectForKey:@"pm2_5_maroon" ] floatValue];
        NSString *a =[NSString stringWithFormat:@":%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    
    //mutch easier do this with array outside
    pieView2_5.layer.transformTitleBlock = ^(PieElement* elem){
        return [(MyPieElement*)elem title];
    };
    pieView2_5.layer.showTitles = ShowTitlesAlways;
    
    pieView10 =[[Example2PieView alloc]initWithFrame:CGRectMake(0,250.0,screen_width+60,270.0)];
    pieView10.backgroundColor=[UIColor clearColor];
    //for(int i=0;i<array.count;i++){
    
    if( [[array objectForKey:@"pm10_green" ] floatValue]>0.000001){
        MyPieElement* elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm10_green" ] floatValue] color:[UIColor colorWithRed:192/255.0 green:255/255.0 blue:62/255.0 alpha:1]];
        [pieView10.layer addValues:@[elem]  animated:NO];
        elem.title = @"0-50";
        float b=[[array objectForKey:@"pm10_green" ] floatValue];
        NSString *a =[NSString stringWithFormat:@"：%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    
    if( [[array objectForKey:@"pm10_yellow" ] floatValue]>0.000001){
        MyPieElement* elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm10_yellow" ] floatValue] color:[UIColor colorWithRed:103/255.0 green:203/255.0 blue:243/255.0 alpha:1]];
        [pieView10.layer addValues:@[elem]  animated:NO];
        elem.title = @"51-100";
        float b=[[array objectForKey:@"pm10_yellow" ] floatValue];
        NSString *a =[NSString stringWithFormat:@":%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    if( [[array objectForKey:@"pm10_orange" ] floatValue]>0.000001){
        
        MyPieElement*  elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm10_orange" ] floatValue] color:[UIColor colorWithRed:88/255.0 green:175/255.0 blue:231/255.0 alpha:1]];
        [pieView10.layer addValues:@[elem]  animated:NO];
        elem.title = @"101-150";
        float b=[[array objectForKey:@"pm10_orange" ] floatValue];
        NSString *a =[NSString stringWithFormat:@":%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    if( [[array objectForKey:@"pm10_red" ] floatValue]>0.000001){
        MyPieElement*   elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm10_red" ] floatValue] color:[UIColor colorWithRed:244/255.0 green:56/255.0 blue:70/255.0 alpha:1]];
        [pieView10.layer addValues:@[elem]  animated:NO];
        elem.title = @"151-200";
        float b=[[array objectForKey:@"pm10_red" ] floatValue];
        NSString *a =[NSString stringWithFormat:@":%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    if( [[array objectForKey:@"pm10_purple" ] floatValue]>0.000001){
        MyPieElement*  elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm10_purple" ] floatValue] color:[UIColor colorWithRed:248/255.0 green:223/255.0 blue:84/255.0 alpha:1]];
        [pieView10.layer addValues:@[elem]  animated:NO];
        elem.title = @"201-300";
        float b=[[array objectForKey:@"pm10_purple" ] floatValue];
        NSString *a =[NSString stringWithFormat:@":%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    if( [[array objectForKey:@"pm10_maroon" ] floatValue]>0.000001){
        MyPieElement* elem = [MyPieElement pieElementWithValue:[[array objectForKey:@"pm10_maroon" ] floatValue] color:[UIColor colorWithRed:0/255.0 green:145/255.0 blue:231/255.0 alpha:1]];
        [pieView10.layer addValues:@[elem]  animated:NO];
        elem.title = @">300";
        float b=[[array objectForKey:@"pm10_maroon" ] floatValue];
        NSString *a =[NSString stringWithFormat:@":%.1f%%" , b] ;
        elem.title = [elem.title stringByAppendingString:a];
    }
    
    //mutch easier do this with array outside
    pieView10.layer.transformTitleBlock = ^(PieElement* elem){
        return [(MyPieElement*)elem title];
    };
    pieView10.layer.showTitles = ShowTitlesAlways;
    
    myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(0, 150, 320, pieView10.frame.size.height*2)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:pieView2_5];
    [myScrollView addSubview:pieView10];
    
    pm2_5Lbl = [[UILabel alloc]initWithFrame:CGRectMake(10,
                                                        0,
                                                        110.0,
                                                        25.0)];
    pm2_5Lbl.text=@"pm2.5：";
    [pm2_5Lbl setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
    pm2_5Lbl.textColor= [UIColor colorWithRed:58/255.0
                                        green:149/255.0
                                         blue:223/255.0
                                        alpha:1];
    [myScrollView addSubview:pm2_5Lbl];
    
    pm10Lbl = [[UILabel alloc]initWithFrame:CGRectMake(10,
                                                       280,
                                                       110.0,
                                                       25.0)];
    pm10Lbl.text=@"pm10：";
    [pm10Lbl setFont:[UIFont fontWithName:@"GeezaPro" size:14]];
    pm10Lbl.textColor= [UIColor colorWithRed:58/255.0
                                       green:149/255.0
                                        blue:223/255.0
                                       alpha:1];
    [myScrollView addSubview:pm10Lbl];
    
    myScrollView.frame = CGRectMake(0, 180, screen_width, screen_height-200);
    
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(pieView2_5.frame.size.width+20,
                                          pieView2_5.frame.size.height*2);
    [myScrollView setScrollEnabled:YES];
    myScrollView.delegate = self;
    
    [self.view addSubview:myScrollView];
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
    date = [NSDate dateWithTimeIntervalSinceNow:0];
    pick=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    pick.delegate=self;
    [self.view addSubview:pick];
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


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void)comboBox:(UIComboBox *)comboBox selected:(int)selected {
    
    csite_id=[index objectAtIndex:selected];
    NSLog(@"%@ select changed to %@,%@", comboBox, csite_id,[put objectAtIndex:selected]);
    [self search:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.3];
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
