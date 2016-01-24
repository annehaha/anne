//
//  monthReportViewController.h
//  qly
//
//  Created by anne on 15/7/10.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myNetworking.h"
#import "chooseTypeForDNViewController.h"
#import "DejalActivityView.h"
#import "UIComboBox.h"
#import "ZHPickView.h"
#import "SimpleBarChart.h"

@interface monthReportViewController : UIViewController<SimpleBarChartDataSource, SimpleBarChartDelegate>
{
    NSArray *_values;
    SimpleBarChart *_chart;
    NSArray *_barColors;
    NSInteger _currentBarColor;
    NSInteger count;
    
    double screen_width;
    double screen_height;
    
    UILabel *startLbl;
    UILabel *typeLbl;
    
    UILabel *startShow;
    
    UIButton* startChoose;
    UIButton* check;
    
    UIButton* pm2;
    UIButton* pm10;
    
    NSString *type;
    NSString *pmType;
    
    NSData *starttime;
}
@property ZHPickView *pick;
@property UIScrollView *myScrollView;
@property NSMutableArray *getArray;
@property NSMutableArray *getArray2;
@property NSMutableArray *getArray3;
@end
