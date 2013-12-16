//
//  Alarm.m
//  alarm
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "Alarm.h"

@implementation Alarm

+ (Alarm *)createAlarmWithMinutes:(int)mts Hour:(int)h Message:(NSString *)msg Days:(NSMutableArray *)ds Music:(MPMediaItemCollection *)mu AlarmMusicSystem:(bool)type
{
    Alarm* alarm = [[Alarm alloc] init];
    
    alarm.notifications = [[NSMutableArray alloc] init];
    alarm.days = [[NSMutableArray alloc] init];
    
    alarm.alarmSystemTypeMusic = type;
    alarm.music = mu;
    alarm.qtdDays = [ds count];
    alarm.days = ds;
    alarm.minutes = mts;
    alarm.hour = h;
    alarm.alertBody = msg;
    
    for(int i = 0; i < alarm.qtdDays; i++)
    {
        NSTimeZone* zone = [NSTimeZone timeZoneWithAbbreviation:@"America/Sao_Paulo"];
        
        UILocalNotification* notif = [[UILocalNotification alloc] init];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents* comp = [[NSDateComponents alloc] init];
        
        [calendar setTimeZone:zone];
        
        [comp setMinute:alarm.minutes];
        [comp setHour:alarm.hour];
        [comp setDay:[[alarm.days objectAtIndex:i] integerValue]];
        [comp setMonth:12];
        [comp setYear:2013];
        
        alarm.date = [calendar dateFromComponents:comp];
        
        notif.fireDate = alarm.date;
        notif.timeZone = zone;
        notif.alertBody = alarm.alertBody;
        notif.alertAction = @"View";
        notif.repeatInterval = NSWeekCalendarUnit;
        notif.soundName = @"alarm.m4a";
        notif.applicationIconBadgeNumber = -1;

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateStyle:NSDateFormatterFullStyle];
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"America/Sao_Paulo"]];
        
         NSLog(@"fireDate : %@", [formatter stringFromDate:notif.fireDate]);
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        
        [alarm.notifications addObject:notif];
    }
    
    return alarm;
}

@end
