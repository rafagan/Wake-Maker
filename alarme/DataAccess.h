//
//  DataAccess.h
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarm.h"

@interface DataAccess : NSObject
{
    NSMutableArray* alarms;
}

- (void)addAlarm:(Alarm*)alarm;
- (void)updateAlarm:(Alarm*)alarm;
- (void)removeAlarm:(Alarm*)alarm;
- (NSMutableArray*)returnAlarms;

@end
