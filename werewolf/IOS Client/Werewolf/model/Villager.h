//
//  Villager.h
//  Werewolf
//
//  Created by anne on 13-11-1.
//  Copyright (c) 2013年 xmucocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Role.h"
@interface Villager : Role


-(id) init;
-(void) execute:(int) playerId;
@end
