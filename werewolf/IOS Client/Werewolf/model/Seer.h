//
//  Seer.h
//  Werewolf
//
//  Created by anne on 13-11-1.
//  Copyright (c) 2013年 xmucocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Role.h"
#import "Player.h"
@interface Seer : Role

-(id) init;
-(int) see:(Player *) toSeePlayer;

@end
