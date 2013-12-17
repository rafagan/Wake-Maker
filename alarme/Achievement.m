//
//  Achievement.m
//  alarme
//
//  Created by André Traleski de Campos on 12/17/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "Achievement.h"

@implementation Achievement

+ (Achievement *)createAchievementWithName:(NSString *)na Description:(NSString *)desc Achieved:(bool)ach
{
    Achievement* achievement = [[Achievement alloc] init];
    achievement.name = na;
    achievement.description = desc;
    achievement.isAchieved = ach;
    
    return achievement;
}

@end
