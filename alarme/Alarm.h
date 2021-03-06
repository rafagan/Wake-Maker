//
//  Alarm.h
//  alarm
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "Song.h"

@interface Alarm : NSObject

+(Alarm*)createAlarmWithMinutes:(int)mts Hour:(int)h Description:(NSString*)msg Days:(NSMutableArray*)ds Music:(Song*)mu;
+(Alarm*)createAlarmWithMinutes:(int)mts Hour:(int)h Description:(NSString*)msg DaysMask:(NSInteger)ds Music:(Song*)mu;

+ (NSMutableArray*)daysMaskToDaysArray:(NSInteger)ds;
+ (NSInteger)daysArrayToDaysMask:(NSMutableArray*)ds;

@property UILocalNotification* snooze;
@property NSMutableArray* notifications;
@property NSMutableArray* days;
@property int qtdDays;
@property NSDate* date;
@property NSString* alertBody;
@property int minutes;
@property int hour;
@property int myId;
@property (nonatomic,strong) Song* music;

@end
