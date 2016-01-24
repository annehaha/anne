//
//  homedataViewController.h
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NALLabelsMatrix.h"
#import "myNetworking.h"

@interface homedataViewController : UIViewController{
@private
    
    CGFloat          rowheight;//row height
    NSString         *selectionName;
    NSString         *flag;
    //NSString         *type;
    
    double screen_width;
    double screen_height;
}
@property NALLabelsMatrix* matrixNow;
@property NALLabelsMatrix* matrixHour;

@property UIButton *noiseButton;
@property UIButton *spmButton;
@property UIButton *dustButton;

@property UIScrollView *myScrollView;

@end
