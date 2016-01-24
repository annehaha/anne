//
//  homedataViewController.m
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zxy. All rights reserved.
//

#import "homedataViewController.h"
#import "DejalActivityView.h"


@interface homedataViewController (){
    UILabel *titleLabel;
    UIButton *nowTableBtn;
    UIButton *hourTableBtn;
}

@end

@implementation homedataViewController

@synthesize matrixHour;
@synthesize matrixNow;
@synthesize myScrollView;
@synthesize dustButton;
@synthesize noiseButton;
@synthesize spmButton;


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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screen_width = (double)[UIScreen mainScreen].applicationFrame.size.width;
    screen_height = (double)[UIScreen mainScreen].applicationFrame.size.height;
    
    
    float buttonWidth = screen_width * 0.5;
    float buttonHeight = 44 / 568.0 * screen_height;
    
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
    [nowTableBtn addTarget:self action:@selector(select_now) forControlEvents:UIControlEventTouchUpInside];
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
    [hourTableBtn addTarget:self action:@selector(select_hour) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hourTableBtn];
    
    //[self select_now];
    
}

-(void)push
{
    
}

- (void)select_now
{
    
    [matrixHour removeFromSuperview];
    [matrixNow removeFromSuperview];
    
    [nowTableBtn setSelected:YES];
    [hourTableBtn setSelected:NO];
    
    [self show_activity:@"正在加载数据..."];
    int table_width = screen_width - 10;
    int table_height = 500;
    int time_column_width = 90;
    int csite_name_column_width = (table_width - time_column_width) / 3 * 2 - 10;
    int data_column_width = table_width - time_column_width - csite_name_column_width;
    matrixNow = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 30, table_width, table_height) andColumnsWidths:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:csite_name_column_width],[NSNumber numberWithInt:data_column_width],[NSNumber numberWithInt:time_column_width], nil]];
    NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    NSString *data_type;
    if ([type isEqualToString:@"spm"])
    {
        [matrixNow addRecord:[[NSArray alloc] initWithObjects:@"监测对象", @"扬尘(ug/m\u00B3)", @"时间", nil]];
        data_type = @"pm10";
    }
    else if ([type isEqualToString:@"noise"])
    {
        [matrixNow addRecord:[[NSArray alloc] initWithObjects:@"监测对象", @"噪声(dB)", @"时间", nil]];
        data_type = @"noise";
    }
    
    //get realtime data info from web
    NSString *ask = @"getDataCompareByUser";
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    
    [[myNetworking sharedClient] GET:ask parameters:@{@"user_id":user_id, @"time_type":@"realtime", @"data_type":data_type} success: ^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = result;
        NSLog(@"%@", result);
        
        for (int i = 0 ; i < array.count; i ++) {
            NSDictionary *temp = array[i];
            if ([type isEqualToString:@"spm"] && [[temp objectForKey:@"pm10"] intValue] != 0)
            {
                [matrixNow addRecord:[[NSArray alloc] initWithObjects:[temp objectForKey:@"csite_name"],[temp objectForKey:@"pm10"],[temp objectForKey:@"time"], nil]];
            }
            else if ([type isEqualToString:@"noise"])
            {
                [matrixNow addRecord:[[NSArray alloc] initWithObjects:[temp objectForKey:@"csite_name"],[temp objectForKey:@"noise"],[temp objectForKey:@"time"], nil]];
            }
            [self remove_activity];
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [self remove_activity];
        [self alertWithTitle:@"获取数据失败" withMsg:@"获取数据失败"];
    }];
    
    myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(5, 110, screen_width,500)];
    //myScrollView = [[UIScrollView alloc]initWithFrame:
    //CGRectMake(0,0,0,0)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:matrixNow];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(0, matrixNow.frame.size.width * 4);
    [myScrollView setScrollEnabled:YES];
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
}

- (void)select_hour
{
    [matrixHour removeFromSuperview];
    [matrixNow removeFromSuperview];
    
    [nowTableBtn setSelected:NO];
    
    [hourTableBtn setSelected:YES];
    
    NSLog(@"here1")
    ;
    [self show_activity:@"正在加载数据..."];
    int table_width = screen_width - 10;
    int table_height = 700;
    int time_column_width = 90;
    int csite_name_column_width = (table_width - time_column_width) / 3 * 2 - 10;
    int data_column_width = table_width - time_column_width - csite_name_column_width;
    matrixNow = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 30, table_width, table_height) andColumnsWidths:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:csite_name_column_width],[NSNumber numberWithInt:data_column_width],[NSNumber numberWithInt:time_column_width], nil]];
    NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    NSString *data_type;
    if ([type isEqualToString:@"spm"])
    {
        [matrixNow addRecord:[[NSArray alloc] initWithObjects:@"监测对象", @"PM10(ug/m\u00B3)", @"时间", nil]];
        data_type = @"pm10";
        
        NSLog(@"here i fdsklfdlsakj");
        
    }
    else if ([type isEqualToString:@"noise"])
    {
        [matrixNow addRecord:[[NSArray alloc] initWithObjects:@"监测对象", @"噪声(dB)", @"时间", nil]];
        data_type = @"noise";
    }
    
    
    //get realtime data info from web
    NSString *ask = @"getDataCompareByUser";
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSLog(@"%@%@", user_id, data_type);
    //NSLog(@"@")
    
    [[myNetworking sharedClient] GET:ask parameters:@{@"user_id":user_id, @"time_type":@"hour", @"data_type":data_type} success: ^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = result;
        NSLog(@"%@", result);
        
        for (int i = 0 ; i < array.count; i ++) {
            NSDictionary *temp = array[i];
            if ([type isEqualToString:@"spm"] && [[temp objectForKey:@"pm10"] intValue] != 0)
            {
                //NSLog(@"-------%@", [temp objectForKey:@"pm10"]);
                [matrixNow addRecord:[[NSArray alloc] initWithObjects:[temp objectForKey:@"csite_name"],[temp objectForKey:@"pm10"],[temp objectForKey:@"time"], nil]];
            }
            else if ([type isEqualToString:@"noise"])
            {
                [matrixNow addRecord:[[NSArray alloc] initWithObjects:[temp objectForKey:@"csite_name"],[temp objectForKey:@"noise"],[temp objectForKey:@"time"], nil]];
            }
        }
        [self remove_activity];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [self remove_activity];
        [self alertWithTitle:@"获取数据失败" withMsg:@"获取数据失败"];
    }];
    
    myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(5, 110, screen_width,500)];
    //myScrollView = [[UIScrollView alloc]initWithFrame:
    //CGRectMake(0,0,0,0)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:matrixNow];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(0, matrixNow.frame.size.width * 4);
    [myScrollView setScrollEnabled:YES];
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
}

-(void) back
{ [self dismissViewControllerAnimated:YES completion:nil];}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void) viewWillAppear:(BOOL)animated{
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"type"] isEqualToString:@"spm"]){
        titleLabel.text = [NSString stringWithFormat:@"%@",@"PM10数据(ug/m\u00B3)" ] ;
    }
    else  if([[[NSUserDefaults standardUserDefaults] objectForKey:@"type"] isEqualToString:@"noise"]){
        titleLabel.text = [NSString stringWithFormat:@"%@",@"噪声数据(dB)" ] ;
    }
    self.navigationItem.titleView = titleLabel;
    
    [nowTableBtn setSelected:YES];
    [self select_now];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [matrixHour removeFromSuperview];
    [matrixNow removeFromSuperview];
    [self.myScrollView removeFromSuperview];
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
