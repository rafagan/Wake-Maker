//
//  AlarmManager.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "DataAccess.h"
#import <Foundation/Foundation.h>

@implementation DataAccess

- (id)init
{
    self = [super init];
    if (self) {
        alarms = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addAlarm:(Alarm *)alarm
{
    [alarms addObject:alarm];
}

- (void)removeAlarm:(Alarm *)alarm
{
    for (int i = 0; i < alarm.qtdDays; i++)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:[alarm.notifications objectAtIndex:i]];
    }
    
    [alarms removeObject:alarm];
}

- (NSMutableArray *)returnAlarms
{
    return alarms;
}

@end
