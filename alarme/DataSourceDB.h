//
//  DataSourceFactory.h
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Alarm.h"

@interface DataSourceDB : NSObject

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *systemDatabase;

- (NSMutableArray*)getAllAlarms;
- (Alarm*)getAlarmByDescription:(NSString*)desc;
- (NSInteger)insertAlarm:(Alarm*)alarm;
- (BOOL)removeAlarm:(Alarm *)alarm;

@end
