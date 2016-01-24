//
//  CustomResourceTableViewCell.m
//  IVMSDemo
//
//  Created by songqi on 15-4-7.
//  Copyright (c) 2015年 songqi. All rights reserved.
//

#import "CustomResourceTableViewCell.h"
#import "VMSNetSDK.h"
//#import "RealPlayViewController.h"
@interface CustomResourceTableViewCell()
@property(nonatomic,assign)IBOutlet UILabel *nameLable;
@property(nonatomic,assign)IBOutlet UIButton *realPlayBtn;
@property(nonatomic,assign)IBOutlet UIButton *expandBtn;
@property(nonatomic,retain)IBOutlet NSString *serverAddr;
@end

@implementation CustomResourceTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.serverAddr = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoAddr"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellContent:(id)data withServerInfo:(CMSPInfo *)mspInfo
{
    self.serverInfo = mspInfo;

    if([data isKindOfClass:[CCameraInfo class]])
    {
        self.resourceType = 2;
        self.dataInfo = data;
        CCameraInfo *tmpDataInfo = (CCameraInfo *)data;
        self.nameLable.text = tmpDataInfo.name;
        [self.realPlayBtn setHidden:NO];
        [self.expandBtn setHidden:YES];
        self.userInteractionEnabled = YES;
    }else if (data == nil){
        self.nameLable.text = @"暂无服务";
        [self.realPlayBtn setHidden:YES];
        [self.expandBtn setHidden:YES];
        self.userInteractionEnabled = NO;
    }
}
- (IBAction)expandBtnClick:(id)sender {
    if(self.resourceType == 2)
    {
        return;
    }
}

- (IBAction)realplayBtnClick:(id)sender {
    
    if(self.resourceType != 2)
    {
        return;
    }

//    RealPlayViewController *realplayViewCtr = [[[RealPlayViewController alloc] initWithNibName:NSStringFromClass([RealPlayViewController class]) bundle:nil withServerInfo:self.serverInfo withCameraInfo:self.dataInfo] autorelease];
//    
//    [[self.delegate fetchFatherViewCtrl].navigationController pushViewController:realplayViewCtr animated:YES];
}

@end
