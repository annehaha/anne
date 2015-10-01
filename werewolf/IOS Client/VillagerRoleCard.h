//
//  VillagerRoleCard.h
//  Werewolf
//
//  Created by mac on 13-11-9.
//  Copyright (c) 2013年 xmucocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketComunication.h"
#import "Event.h"
#import "AppDelegate.h"
#import "IDCardView.h"
@interface VillagerRoleCard : UIViewController<clientsocketprotocol>


@property (nonatomic, retain) IBOutlet IDCardView *coinView;

@property Event *event;
-(void)getDataFromServer:(NSData *)data;
@end
