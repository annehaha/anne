//
//  nightNoiseViewController.h
//  qly
//
//  Created by anne on 15/7/10.
//  Copyright (c) 2015年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleBarChart.h"
#import "myNetworking.h"
#import "chooseTypeForDNViewController.h"
#import "DejalActivityView.h"
#import "UIComboBox.h"
#import "ZHPickView.h"

@interface nightNoiseViewController : UIViewController<SimpleBarChartDataSource, SimpleBarChartDelegate>
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
     UILabel *cite;
    
    UIButton* startChoose;
    UIButton* endChoose;
    UIButton* check;
    
    NSString *beginOrEnd;
    NSString *time_type;
    NSString *csite_id;
    
    NSData *starttime;
    NSData *endtime;
    
    NSMutableArray *put;
    NSMutableArray *index;
}
@property (nonatomic, strong) NSMutableArray *spot_list;
@property UIScrollView *myScrollView;
@property NSMutableArray *getArray;
@property NSMutableArray *getArray2;
@property ZHPickView *pick;
@end
