//
//  CsiteDetailViewController.m
//  hbj_app
//
//  Created by adc on 15/1/10.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import "CsiteDetailViewController.h"

@interface CsiteDetailViewController (){
    float screen_width;
    float screen_height;
}

@end

@implementation CsiteDetailViewController
@synthesize matrix;
@synthesize myScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSString *csite_name = [[NSUserDefaults standardUserDefaults] objectForKey:@"csite_name"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = csite_name;
    self.navigationItem.titleView = titleLabel;
    
    screen_width = (double)[UIScreen mainScreen].applicationFrame.size.width;
    screen_height = (double)[UIScreen mainScreen].applicationFrame.size.height;
    
    /*self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(back)];*/
    
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
    
    int table_width = screen_width - 10;
    int table_height = screen_height - 64;
    int name_column_width = 110;
    int content_column_width = table_width - name_column_width;
    matrix = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, table_width, table_height) andColumnsWidths:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:name_column_width],[NSNumber numberWithInt:content_column_width], nil]];
    
    myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(5, 5, screen_width - 10, screen_height)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(matrix.frame.size.width,
                                          matrix.frame.size.height+600);
    [myScrollView setScrollEnabled:YES];
    
    [myScrollView addSubview:matrix];
    [self.view addSubview:myScrollView];
    //[self getData];
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getData];
}

-(void)getData
{
    [self show_activity:@"正在加载数据..."];
    
//    matrix = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, screen_width, 500) andColumnsWidths:[[NSArray alloc] initWithObjects:@110,@255, nil]];
    [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"名称",@"内容", nil] font:[UIFont fontWithName:@"Helvetica" size:17.0] color:[[NSArray alloc] initWithObjects:[UIColor blackColor], [UIColor blackColor], nil]];
    
    NSString *csite_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"csite_id"];
    [[myNetworking sharedClient] GET:@"csiteDetail" parameters:@{@"csite_id":csite_id}
                             success: ^(AFHTTPRequestOperation *operation, id result) {
                                 
                                 NSLog(@"%@", result);
                                 
                                 NSMutableDictionary *csiteDetail = result;
                                 UIFont *newFont = [UIFont fontWithName:@"Helvetica" size:17.0];
                                 UIColor *color1 = [UIColor blackColor];
                                 UIColor *color2 = [UIColor colorWithRed:75.0 / 255 green:160.0 / 255 blue:225.0 / 255 alpha:1];
                                 NSArray *colors = [[NSArray alloc] initWithObjects:color1, color2, nil];


                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"监测点",[csiteDetail objectForKey:@"csite_name"], nil] font:newFont color:colors];
                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"地址",[csiteDetail objectForKey:@"addr"], nil] font:newFont color:colors];
                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"经度",[csiteDetail objectForKey:@"longitude"], nil] font:newFont color:colors];
                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"纬度",[csiteDetail objectForKey:@"latitude"], nil] font:newFont color:colors];
                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"监测类型	",[csiteDetail objectForKey:@"csite_type_name"], nil] font:newFont color:colors];
                                 
                                 [matrix addRecord:[[NSArray alloc] initWithObjects:@"", @"", nil]];
                                 
                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"时间",[csiteDetail objectForKey:@"recv_time"], nil] font:newFont color:colors];
                                 
                                 if ([csiteDetail.allKeys containsObject:@"dust"] && ![[csiteDetail objectForKey:@"dust"] isEqualToString:@"0.0"]) {
                                     [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"扬尘(mg/m\u00B3)",[csiteDetail objectForKey:@"dust"], nil] font:newFont color:colors];
                                 }
                                 
                                 if ([csiteDetail.allKeys containsObject:@"pm2_5"] && ![[csiteDetail objectForKey:@"pm2.5"] isEqualToString:@"0.0"]) {
                                     [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"pm2.5(μg/m\u00B3)",[csiteDetail objectForKey:@"pm2_5"], nil] font:newFont color:colors];
                                 }
                                 
                                 if ([csiteDetail.allKeys containsObject:@"pm10"] && ![[csiteDetail objectForKey:@"pm10"] isEqualToString:@"0.0"]) {
                                     [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"pm10(μg/m\u00B3)",[csiteDetail objectForKey:@"pm10"], nil] font:newFont color:colors];
                                 }
                                 
                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"噪声db(A)",[csiteDetail objectForKey:@"noise"], nil] font:newFont color:colors];
                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"风向",[csiteDetail objectForKey:@"wind_direct"], nil] font:newFont color:colors];
                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"风速(m/s)",[csiteDetail objectForKey:@"wind_speed"], nil] font:newFont color:colors];
                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"温度(摄氏度)",[csiteDetail objectForKey:@"temp"], nil] font:newFont color:colors];
                                 [matrix addRecordWithDescription:[[NSArray alloc] initWithObjects:@"湿度(%)",[csiteDetail objectForKey:@"humid"], nil] font:newFont color:colors];
                                 [self remove_activity];
                             } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                                 NSLog(@"%@", error);
                                 [self remove_activity];
                                 [self alertWithTitle:@"获取数据失败" withMsg:@"获取数据失败"];
                             }];
    
    
    
    //myScrollView.delegate = self;
    
    
}

- (void) back {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
