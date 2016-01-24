//
//  ViewController.h
//  king
//
//  Created by iMac-User4 on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "klpView.h"
#import "myNetworking.h"
#import "UIImageView+WebCache.h"
#import "DejalActivityView.h"
@interface ViewPhotoViewController : UIViewController<UIScrollViewDelegate>{
	NSMutableArray *klpArr;
	klpView *klp;
	int index;
}

@end
