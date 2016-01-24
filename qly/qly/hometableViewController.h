//
//  hometableViewController.h
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2015年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SimpleBarChart.h"
#import "myNetworking.h"
#import "chooseCsiteViewController.h"
#import "chooseTypeForDNViewController.h"

@interface hometableViewController : UIViewController<SimpleBarChartDataSource, SimpleBarChartDelegate>
{
    NSArray *_values;
    SimpleBarChart *_chart;
    NSArray *_barColors;
    NSInteger _currentBarColor;
    NSInteger count;
    
    double screen_width;
    double screen_height;
}
@property UIScrollView *myScrollView;
@property UIButton *nowTableBtn;
@property UIButton *hourTableBtn;
@property NSMutableArray *getArray;
@property NSMutableArray *getArray2;
@property NSMutableArray *spot_list;
@end
