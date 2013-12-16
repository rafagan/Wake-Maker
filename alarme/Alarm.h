//
//  Alarm.h
//  alarm
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

@interface Alarm : NSObject

+(Alarm*)createAlarmWithMinutes:(int)mts Hour:(int)h Message:(NSString*)msg Days:(NSMutableArray*)ds;

@property NSMutableArray* notifications;
@property NSMutableArray* days;
@property int qtdDays;
@property NSDate* date;
@property NSString* alertBody;
@property int minutes;
@property int hour;

@end
