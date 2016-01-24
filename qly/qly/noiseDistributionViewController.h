//
//  noiseDistributionViewController.h
//  qly
//
//  Created by anne on 15/7/10.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleBarChart.h"
#import "myNetworking.h"
#import "DejalActivityView.h"
#import "ZHPickView.h"

@interface noiseDistributionViewController : UIViewController<SimpleBarChartDataSource, SimpleBarChartDelegate>
{
    NSArray *_values;
    SimpleBarChart *_chart;
    NSArray *_barColors;
    NSInteger _currentBarColor;
    NSInteger count;
    
    double screen_width;
    double screen_height;
    
    UILabel *startLbl;
    UILabel *endLbl;
    
    UILabel *startShow;
    UILabel *endShow;
    
    UIButton* startChoose;
    UIButton* endChoose;
    UIButton* check;
    UIButton* all;
    UIButton* day;
    UIButton* night;
    
    NSString *beginOrEnd;
    NSString *time_type;
    
    NSData *starttime;
    NSData *endtime;
}
@property UIScrollView *myScrollView;
@property NSMutableArray *getArray;
@property NSMutableArray *getArray2;
@property ZHPickView *pick;


@end
