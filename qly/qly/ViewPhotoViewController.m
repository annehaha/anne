//
//  ViewController.m
//  king
//
//  Created by iMac-User4 on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewPhotoViewController.h"

//#import "mainViewController.h"

@interface ViewPhotoViewController ()
@property (nonatomic,retain)IBOutlet UIScrollView *klpScrollView1,*klpScrollView2;
@property (nonatomic,retain)NSMutableArray *klpImgArr;

@property (nonatomic,retain) UILabel *time_name_label;
@property (nonatomic,retain) UILabel *time_label;
@property (nonatomic,retain) UILabel *dust_name_label;
@property (nonatomic,retain) UILabel *dust_label;
@property (nonatomic,retain) UILabel *pm25_name_label;
@property (nonatomic,retain) UILabel *pm25_label;
@property (nonatomic,retain) UILabel *pm10_name_label;
@property (nonatomic,retain) UILabel *pm10_label;

@property NSString *data_type;
@property NSString *unit;


@end

@implementation ViewPhotoViewController
@synthesize klpImgArr;
@synthesize klpScrollView1,klpScrollView2;
double screen_width;
double screen_height;
int large_pic_width;
int large_pic_height;
int small_pic_width;
int small_pic_height;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *csite_name = [[NSUserDefaults standardUserDefaults] objectForKey:@"csite_name"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = csite_name;
    self.navigationItem.titleView = titleLabel;
    
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
    
    screen_width = [UIScreen mainScreen].applicationFrame.size.width;
    screen_height = [UIScreen mainScreen].applicationFrame.size.height;
    large_pic_width = screen_width;
    large_pic_height = screen_width * 2 / 3.0;
    small_pic_width = screen_width / 3;
    small_pic_height = small_pic_width * 2 / 3;
    
    self.time_name_label = [[UILabel alloc] initWithFrame:CGRectMake(8, 70, 50, 25)];
    [self.time_name_label setText:@"时间:"];
    [self.time_name_label setFont:[UIFont systemFontOfSize:15]];
    [self.time_name_label setTextColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1]];
    [self.view addSubview:self.time_name_label];
    
    self.time_label = [[UILabel alloc] initWithFrame:CGRectMake(70, 70, 250, 25)];
    [self.time_label setText:@""];
    [self.time_label setFont:[UIFont systemFontOfSize:15]];
    [self.time_label setTextColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1]];
    [self.view addSubview:self.time_label];
    
    
    
    //NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    
    self.dust_name_label = [[UILabel alloc] initWithFrame:CGRectMake(8, 95, 50, 25)];
    [self.dust_name_label setText:@"噪声:"];
    [self.dust_name_label setFont:[UIFont systemFontOfSize:15]];
    [self.dust_name_label setTextColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1]];
    [self.view addSubview:self.dust_name_label];
    
    self.dust_label = [[UILabel alloc] initWithFrame:CGRectMake(70, 95, 250, 25)];
    [self.dust_label setText:@""];
    [self.dust_label setFont:[UIFont systemFontOfSize:15]];
    [self.dust_label setTextColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1]];
    [self.view addSubview:self.dust_label];
    
    self.pm25_name_label = [[UILabel alloc] initWithFrame:CGRectMake(8, 120, 50, 25)];
    [self.pm25_name_label setText:@"PM2.5:"];
    [self.pm25_name_label setFont:[UIFont systemFontOfSize:15]];
    [self.pm25_name_label setTextColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1]];
    [self.view addSubview:self.pm25_name_label];
    
    self.pm25_label = [[UILabel alloc] initWithFrame:CGRectMake(70, 120, 250, 25)];
    [self.pm25_label setText:@""];
    [self.pm25_label setFont:[UIFont systemFontOfSize:15]];
    [self.pm25_label setTextColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1]];
    [self.view addSubview:self.pm25_label];
    
    self.pm10_name_label = [[UILabel alloc] initWithFrame:CGRectMake(8, 145, 50, 25)];
    [self.pm10_name_label setText:@"PM10:"];
    [self.pm10_name_label setFont:[UIFont systemFontOfSize:15]];
    [self.pm10_name_label setTextColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1]];
    [self.view addSubview:self.pm10_name_label];
    
    self.pm10_label = [[UILabel alloc] initWithFrame:CGRectMake(70, 145, 250, 25)];
    [self.pm10_label setText:@""];
    [self.pm10_label setFont:[UIFont systemFontOfSize:15]];
    [self.pm10_label setTextColor:[UIColor colorWithRed:58/255.0 green:149/255.0 blue:223/255.0 alpha:1]];
    [self.view addSubview:self.pm10_label];
    
    //self.data_label = [[UILabel alloc] initWithFrame:CGRectMake(58, 80, 150, 43)];
    //[self.data_label setText:@""];
    //[self.view addSubview:self.data_label];
    
    //[self getData];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)putPhotoIntoView
{
    index = 0;
    self.klpImgArr = [[NSMutableArray alloc] initWithCapacity:12];
    self.klpScrollView1.frame = CGRectMake(0, 180, large_pic_width, large_pic_height);
    CGSize size = self.klpScrollView1.frame.size;
    for (int i=0; i < [klpArr count]; i++) {
        NSDictionary *photo = [klpArr objectAtIndex:i];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(large_pic_width * i, -64, large_pic_width, large_pic_height)];
        [iv sd_setImageWithURL:[NSURL URLWithString: [photo objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"waiting"]];
        [self.klpScrollView1 addSubview:iv];
        iv = nil;
        
    }
    
    
    [self.klpScrollView1 setContentSize:CGSizeMake(size.width * [klpArr count], 0)];
    
    self.klpScrollView1.pagingEnabled = YES;
    self.klpScrollView1.showsHorizontalScrollIndicator = NO;
    
    self.klpScrollView2.frame = CGRectMake(0, screen_height - small_pic_height - 45, screen_width, small_pic_height);
    //CGSize size2 = self.klpScrollView2.frame.size;
    for (int i=0; i<[klpArr count]; i++) {
        NSDictionary *photo = [klpArr objectAtIndex:i];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(small_pic_width*i,0,small_pic_width,small_pic_height)];
        [iv sd_setImageWithURL:[NSURL URLWithString:[photo objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"waiting"]];
        [self.klpScrollView2 addSubview:iv];
        [self.klpImgArr addObject:iv];
        iv = nil;
    }
    [self.klpScrollView2 setContentSize:CGSizeMake(small_pic_width * [klpArr count] + 60, 0)];
    
    klp = [[klpView alloc] initWithFrame:((UIImageView*)[self.klpImgArr objectAtIndex:index]).frame];
    [self.klpScrollView2 addSubview:klp];
    
    //self.klpScrollView2.pagingEnabled = YES;
    self.klpScrollView2.showsHorizontalScrollIndicator = NO;
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleTap setNumberOfTapsRequired:1];
    
    [self.klpScrollView1 addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *smallImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    [smallImageTap setNumberOfTapsRequired:1];
    [self.klpScrollView2 addGestureRecognizer:smallImageTap];
    
    if (self.klpImgArr.count > 0) {
        [self setPhotoData:0];
    }
    
}
//- (void)putPhotoIntoView
//{
//    index = 0;
//    self.klpImgArr = [[NSMutableArray alloc] initWithCapacity:12];
//    
//    self.klpScrollView1.frame = CGRectMake(0, 140, 375, 350);
//    CGSize size = self.klpScrollView1.frame.size;
//    for (int i=0; i < [klpArr count]; i++) {
//        NSDictionary *photo = [klpArr objectAtIndex:i];
//        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(size.width * i, 0, 375, 250)];
//        [iv sd_setImageWithURL:[NSURL URLWithString: [photo objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"waiting"]];
//        [self.klpScrollView1 addSubview:iv];
//        iv = nil;
//        
//    }
//    
//    
//    [self.klpScrollView1 setContentSize:CGSizeMake(size.width * [klpArr count], 0)];
//    
//    self.klpScrollView1.pagingEnabled = YES;
//    self.klpScrollView1.showsHorizontalScrollIndicator = NO;
//    
//    self.klpScrollView2.frame = CGRectMake(0, 500, 375, 90);
//    CGSize size2 = self.klpScrollView2.frame.size;
//    for (int i=0; i<[klpArr count]; i++) {
//        NSDictionary *photo = [klpArr objectAtIndex:i];
//        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(135*i,0,135,90)];
//        [iv sd_setImageWithURL:[NSURL URLWithString:[photo objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"waiting"]];
//        [self.klpScrollView2 addSubview:iv];
//        [self.klpImgArr addObject:iv];
//        iv = nil;
//    }
//    [self.klpScrollView2 setContentSize:CGSizeMake(135 * [klpArr count] + 60, 0)];
//    
//    klp = [[klpView alloc] initWithFrame:((UIImageView*)[self.klpImgArr objectAtIndex:index]).frame];
//    [self.klpScrollView2 addSubview:klp];
//    
//    //self.klpScrollView2.pagingEnabled = YES;
//    self.klpScrollView2.showsHorizontalScrollIndicator = NO;
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [singleTap setNumberOfTapsRequired:1];
//    
//    [self.klpScrollView1 addGestureRecognizer:singleTap];
//    
//    UITapGestureRecognizer *smallImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
//    [smallImageTap setNumberOfTapsRequired:1];
//    [self.klpScrollView2 addGestureRecognizer:smallImageTap];
//
//    if (self.klpImgArr.count > 0) {
//        [self setPhotoData:0];
//    }
//    
//}

-(void) setPhotoData:(long)index
{
    NSDictionary *photo = [klpArr objectAtIndex:index];
    //NSString *data = [photo objectForKey:self.data_type];
    NSString *temptime = [photo objectForKey:@"time"];
    
    NSString *year = [temptime substringWithRange:NSMakeRange(0, 4)];
    NSString *tempmonth = [temptime substringWithRange:NSMakeRange(4, 2)];
    NSString *tempday = [temptime substringWithRange:NSMakeRange(6, 2)];
    NSString *temphour = [temptime substringWithRange:NSMakeRange(9, 2)];
    NSString *tempminute = [temptime substringWithRange:NSMakeRange(11, 2)];
    NSString *tempsecond = [temptime substringWithRange:NSMakeRange(13, 2)];
    
    NSArray *tempArray = @[tempmonth, tempday, temphour, tempminute, tempsecond];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [tempArray count]; i ++) {
        if ([tempArray[i] hasPrefix:@"0"]) {
            //array[i] = [tempArray[i] substringFromIndex:1];
            [array addObject:[tempArray[i] substringFromIndex:1]];
        }else{
            [array addObject:tempArray[i]];
        }
    }
    
    NSString *time = [NSString stringWithFormat:@"%@年%@月%@日, %@时%@分%@秒", year, array[0], array[1], array[2], array[3], array[4]];
    
    NSNumber *tempnoise = [photo objectForKey:@"noise"];
    int noise = [tempnoise intValue];
    NSString *dust = [NSString stringWithFormat:@"%d db(A)" ,noise];
    NSString *pm25 = [NSString stringWithFormat:@"%@ (μg/m\u00B3)" ,[photo objectForKey:@"pm2_5"]];
    NSString *pm10 = [NSString stringWithFormat:@"%@ (μg/m\u00B3)" ,[photo objectForKey:@"pm10"]];
    
    //[self.data_label setText:[data stringByAppendingString:self.unit]];
    [self.time_label setText:time];
    [self.dust_label setText:dust];
    [self.pm25_label setText:pm25];
    [self.pm10_label setText:pm10];
}

- (void)getData
{
    [self show_activity:@"正在获取照片..."];
    //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
    //[[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    NSString *csite_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"csite_id"];
    [[myNetworking sharedClient] GET:@"viewPhoto" parameters:@{@"csite_id":csite_id}
                                 success: ^(AFHTTPRequestOperation *operation, id result) {
                                     
                                     NSLog(@"hererere: %@", result);
                                     
                                     if ([result  isEqual: @[]]) {
                                         //NSLog(@"kong.");
                                         [self alertWithTitle:@"抱歉" withMsg:@"该监测点无图片"];
                                         [DejalBezelActivityView removeViewAnimated:YES];
                                         [[self class] cancelPreviousPerformRequestsWithTarget:self];
                                     }else{
                                         //[timer invalidate];
                                         NSArray *array = result;
                                         klpArr = [[NSMutableArray alloc] init];
                                         for (int i = 0 ; i < array.count; i ++) {
                                             NSDictionary *photo = array[i];
                                            [klpArr addObject:photo];
                                         }
                                         [self putPhotoIntoView];
                                         [self remove_activity];
                                     }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [self remove_activity];
        [self alertWithTitle:@"获取失败" withMsg:@"请稍后再试"];
        //[self alertWithTitle:@"网络异常" withMsg:@"登陆超时"];
        
        [DejalBezelActivityView removeViewAnimated:YES];
        [[self class] cancelPreviousPerformRequestsWithTarget:self];
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void)dealloc{
}

#pragma mark-- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{\
	//NSLog(@"scrollViewDidScroll");
	if (scrollView == self.klpScrollView1) {
		CGFloat pageWidth = scrollView.frame.size.width;
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		index = page;
	}else {
		
	}
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//	NSLog(@"scrollViewWillBeginDragging");
	if (scrollView == self.klpScrollView1) {
		
	}else {
		
	}
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	//NSLog(@"scrollViewDidEndDecelerating");
	if (scrollView == self.klpScrollView1) {
		klp.frame = ((UIImageView*)[self.klpImgArr objectAtIndex:index]).frame;
		[klp setAlpha:0];
		[UIView animateWithDuration:0.2f animations:^(void){
			[klp setAlpha:.85f];
		}];
		[self.klpScrollView2 setContentOffset:CGPointMake(klp.frame.origin.x, 0) animated:YES];
        
        [self setPhotoData:index];
	}else {
		
	}
}



#pragma mark 手势
- (void) handleSingleTap:(UITapGestureRecognizer *) gestureRecognizer{
	CGFloat pageWith = large_pic_width;
    
    CGPoint loc = [gestureRecognizer locationInView:self.klpScrollView1];
    NSInteger touchIndex = floor(loc.x / pageWith) ;
    if (touchIndex > [klpArr count] - 1) {
        return;
    }
    
    [self setPhotoData:touchIndex];
    NSLog(@"touch index %ld",(long)touchIndex);  
}
- (void) handleImageTap:(UITapGestureRecognizer *) gestureRecognizer{
	CGFloat rowHeight = small_pic_height;
    CGFloat columeWith = small_pic_width;
    CGFloat gap = 0;
    
    CGPoint loc = [gestureRecognizer locationInView:self.klpScrollView2];
    NSInteger touchIndex = floor(loc.x / (columeWith + gap)) + 3 * floor(loc.y / (rowHeight + gap)) ;
    if (touchIndex > [klpArr count] - 1) {
        return;
    }
    
   [self setPhotoData:touchIndex];
    
    index = touchIndex;
    CGRect frame = self.klpScrollView1.frame;
    frame.origin.x = frame.size.width * touchIndex;
    frame.origin.y = 0;
    [self.klpScrollView1 scrollRectToVisible:frame animated:NO];
    
    klp.frame = ((UIImageView*)[self.klpImgArr objectAtIndex:index]).frame;
    [klp setAlpha:0];
    [UIView animateWithDuration:0.2f animations:^(void){
        [klp setAlpha:.85f];
    }];
	[self.klpScrollView2 setContentOffset:CGPointMake(klp.frame.origin.x, 0) animated:YES];
    NSLog(@"small image touch index %d",touchIndex);  
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

@end

