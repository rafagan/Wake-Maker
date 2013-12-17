//
//  Achievement.h
//  alarme
//
//  Created by André Traleski de Campos on 12/17/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Achievement : NSObject

+(Achievement*)createAchievementWithName:(NSString*)na Description:(NSString*)desc Achieved:(bool)ach;

@property bool isAchieved;
@property NSString* name;
@property NSString* description;

@end
