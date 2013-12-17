//
//  Alarm.m
//  alarm
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "Alarm.h"

@implementation Alarm

+ (Alarm *)createAlarmWithMinutes:(int)mts Hour:(int)h Description:(NSString *)msg Days:(NSMutableArray *)ds Music:(MPMediaItemCollection *)mu AlarmMusicSystem:(bool)type
{
    Alarm* alarm = [[Alarm alloc] init];
    
    alarm.notifications = [[NSMutableArray alloc] init];
    alarm.days = [[NSMutableArray alloc] init];
    
    alarm.myId = 0;
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

+(Alarm*)createAlarmWithMinutes:(int)mts Hour:(int)h Description:(NSString*)msg DaysMask:(NSInteger)ds Music:(MPMediaItemCollection*)mu AlarmMusicSystem:(bool)type
{
    NSMutableArray* days = [Alarm daysMaskToDaysArray:ds];
    return [Alarm createAlarmWithMinutes:mts Hour:h Description:msg Days:days Music:mu AlarmMusicSystem:type];
}

+ (NSMutableArray*)daysMaskToDaysArray:(NSInteger)ds
{
    NSMutableArray* array = [NSMutableArray new];
    
    if(ds & 0b0000001)
        [array addObject:@"1"];
    if (ds & 0b0000010)
        [array addObject:@"2"];
    if (ds & 0b0000100)
        [array addObject:@"3"];
    if (ds & 0b0001000)
        [array addObject:@"4"];
    if (ds & 0b0010000)
        [array addObject:@"5"];
    if (ds & 0b0100000)
        [array addObject:@"6"];
    if (ds & 0b1000000)
        [array addObject:@"7"];
    
    return array;
}

+ (NSInteger)daysArrayToDaysMask:(NSMutableArray*)ds
{
    NSInteger d = 0;
    
    if ([ds containsObject:@"1"]) //dom
        d |= 0b0000001;
    if ([ds containsObject:@"2"]) //seg
        d |= 0b0000010;
    if ([ds containsObject:@"3"]) //ter
        d |= 0b0000100;
    if ([ds containsObject:@"4"]) //qua
        d |= 0b0001000;
    if ([ds containsObject:@"5"]) //qui
        d |= 0b0010000;
    if ([ds containsObject:@"6"]) //sex
        d |= 0b0100000;
    if ([ds containsObject:@"7"]) //sab
        d |= 0b1000000;
    return d;
}

@end
