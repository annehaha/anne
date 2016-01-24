//
//  singleTabBarController.h
//  qly
//
//  Created by eidision on 15/7/10.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMSPInfo;
@interface singleTabBarController : UITabBarController

@property(nonatomic,retain)CMSPInfo *serverInfo;
@end
