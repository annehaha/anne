//
//  chooseCsiteViewController.h
//  hbj_app
//
//  Created by adc on 15/1/6.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chooseCsiteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *spot_list;
@end
