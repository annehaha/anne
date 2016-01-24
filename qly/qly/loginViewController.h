//
//  loginViewController.h
//  qly
//
//  Created by eidision on 15/7/8.
//  Copyright (c) 2015年 eidision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;
@property (weak, nonatomic) IBOutlet UIButton *rememberButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *rememberMark;
- (IBAction)touchView:(id)sender;

@end
