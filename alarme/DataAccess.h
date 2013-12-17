//
//  DataAccess.h
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarm.h"
#import "Achievement.h"

@interface DataAccess : NSObject
{
    NSMutableArray* alarms;
    NSMutableArray* achievements;
}

- (void)addAlarm:(Alarm*)alarm;
- (void)updateAlarm:(Alarm*)alarm;
- (void)removeAlarm:(Alarm*)alarm;
- (void)addAchievement:(Achievement*)achieve;
- (NSMutableArray*)returnAlarms;
- (NSMutableArray*)returnAchievements;

@end
