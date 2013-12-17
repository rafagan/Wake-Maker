//
//  AlarmManager.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "DataAccess.h"
#import "DataSourceDB.h"
#import <Foundation/Foundation.h>

@implementation DataAccess
{
    DataSourceDB* data;
}

- (id)init
{
    self = [super init];
    if (self) {
        _snoozeTimes = 0;
        data = [DataSourceDB new];
        alarms = [data getAllAlarms];
        achievements = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addAlarm:(Alarm *)alarm
{
    [alarms addObject:alarm];
    alarm.myId = [data insertAlarm:alarm];
    
    if(alarm.myId < 0) assert("Erro ao inserir alarme no banco de dados");
}

- (void)updateAlarm:(Alarm *)alarm
{
    [data updateAlarm:alarm];
}

- (void)removeAlarm:(Alarm *)alarm
{
    for (int i = 0; i < alarm.qtdDays; i++)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:[alarm.notifications objectAtIndex:i]];
    }
    
    [alarms removeObject:alarm];
    [data removeAlarm:alarm];
}

- (void)addAchievement:(Achievement *)achieve
{
    [achievements addObject:achieve];
}

- (NSMutableArray *)returnAlarms
{
    return alarms;
}

- (NSMutableArray *)returnAchievements
{
    return achievements;
}
@end
