//
//  singleCurveViewController.h
//  qly
//
//  Created by eidision on 15/7/10.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSLineChart.h"
#import "myNetworking.h"
#import "DejalActivityView.h"


@interface singleCurveViewController : UIViewController{
    
    NSString *time_type;
    NSMutableArray* chartData;
    
    double screen_width;
    double screen_height;
    
    NSDate *starttime;
    NSDate *endtime;
    
    UILabel *start_show;
    UILabel *end_show;
    UILabel *end_hour;
    UILabel *descri;
    UILabel *hint;
    UILabel *picHint;
    
    UIButton *pm2_5;
    UIButton *pm10;
    
    UIView *chart;
    UIView *chart2;
    NSString *pmtype;
    NSString *object_type;
    NSString *type;
    NSString *url;
    NSString* csiteID;
    NSString* csiteID2;
    
    NSString *hour;
    
    UIButton *speed,*KM,*cod,*NH3,*flow;
    int x,y,width,height;
    
}
@property UIScrollView *myScrollView;
@end
