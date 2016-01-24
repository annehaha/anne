//
//  spmDistributionViewController.h
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
#import "Example2PieView.h"
#import "MyPieElement.h"
#import "PieLayer.h"

@interface spmDistributionViewController : UIViewController{
    double screen_width;
    double screen_height;
    
    UILabel *startLbl;
    UILabel *endLbl;
    
    UILabel *startShow;
    UILabel *endShow;
    UILabel *cite;
    
    UILabel *pm2_5Lbl;
    UILabel *pm10Lbl;
    
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
@property ZHPickView *pick;
@property Example2PieView* pieView2_5;
@property Example2PieView* pieView10;
@end
