//
//  Alarm.h
//  alarm
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//
#import <MediaPlayer/MediaPlayer.h>

@interface Alarm : NSObject

+(Alarm*)createAlarmWithMinutes:(int)mts Hour:(int)h Description:(NSString*)msg Days:(NSMutableArray*)ds Music:(MPMediaItemCollection*)mu AlarmMusicSystem:(bool)type;
+(Alarm*)createAlarmWithMinutes:(int)mts Hour:(int)h Description:(NSString*)msg DaysMask:(NSInteger)ds Music:(MPMediaItemCollection*)mu AlarmMusicSystem:(bool)type;

+ (NSMutableArray*)daysMaskToDaysArray:(NSInteger)ds;
+ (NSInteger)daysArrayToDaysMask:(NSMutableArray*)ds;

@property UILocalNotification* snooze;
@property bool alarmSystemTypeMusic;
@property MPMediaItemCollection* music;
@property NSMutableArray* notifications;
@property NSMutableArray* days;
@property int qtdDays;
@property NSDate* date;
@property NSString* alertBody;
@property int minutes;
@property int hour;
@property int myId;

@end
