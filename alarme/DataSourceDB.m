//
//  DataSourceFactory.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "DataSourceDB.h"

@interface DataSourceDB ()

- (void)initializeDatabase;

@end

@implementation DataSourceDB

- (id)init
{
    self = [super init];
    if (self) {
        NSString *docsDir;
        NSArray *dirPaths;
        BOOL BDExist;
        
        //Pega o diretório de documentos
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        
        //Cria o endereçamento correto para o diretório do banco de dados
        _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"AlarmSystem.db"]];
        
        const char *dbpath = [_databasePath UTF8String];
        
        //Tenta criar conexão com o banco
        if (sqlite3_open(dbpath, &_systemDatabase) == SQLITE_OK) {
            
            //Verifica a existência do banco de dados
            NSFileManager *filemgr = [NSFileManager defaultManager];
            BDExist = [filemgr fileExistsAtPath:_databasePath];
            
            if (BDExist == NO)
                NSLog(@"BD criado com sucesso");
            else
                NSLog(@"BD aberto com sucesso");
            
            [self initializeDatabase];
            
            sqlite3_close(_systemDatabase);
        } else {
            NSLog(@"Falha ao criar/abrir o BD");
        }
    }
    return self;
}

- (void)initializeDatabase {
    char *errMsg;
    
//    sqlite3_exec(_systemDatabase, "DROP TABLE alarm", NULL, NULL, &errMsg);
    const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS alarm (id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT NOT NULL, hour INTEGER NOT NULL, minute INTEGER NOT NULL, days INTEGER NOT NULL)";
    if (sqlite3_exec(_systemDatabase, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        NSLog(@"Falha ao criar as tabelas do banco");
    else
        NSLog(@"Tabelas abertas/criadas com sucesso");

}

- (NSMutableArray*)getAllAlarms {
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    NSMutableArray *alarms = [NSMutableArray new];
    
    if (sqlite3_open(dbpath, &_systemDatabase) == SQLITE_OK) {
        const char *query_stmt = [@"SELECT * FROM alarm" UTF8String];
        
        if (sqlite3_prepare_v2(_systemDatabase, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSUInteger myId = sqlite3_column_int64(statement, 0);
                NSString *description = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                int hour = sqlite3_column_int(statement, 2);
                int minute = sqlite3_column_int(statement, 3);
                NSInteger days = sqlite3_column_int(statement, 4);
                
                Alarm* a = [Alarm createAlarmWithMinutes:minute Hour:hour Description:description DaysMask:days Music:nil AlarmMusicSystem:false];
                a.myId = myId;
                [alarms addObject:a];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_systemDatabase);
    }
    return alarms;
}

- (Alarm*)getAlarmByDescription:(NSString*)desc
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    Alarm *alarm = nil;
    
    if (sqlite3_open(dbpath, &_systemDatabase) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM alarm WHERE description = \"%s\"", [desc UTF8String]];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_systemDatabase, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSUInteger myId = sqlite3_column_int64(statement, 0);
                NSString *description = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                int hour = sqlite3_column_int(statement, 2);
                int minute = sqlite3_column_int(statement, 3);
                NSInteger days = sqlite3_column_int(statement, 4);

                alarm = [Alarm createAlarmWithMinutes:minute Hour:hour Description:description DaysMask:days Music:nil AlarmMusicSystem:false];
                alarm.myId = myId;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_systemDatabase);
    }
    return alarm;
}

- (NSInteger)insertAlarm:(Alarm*)alarm {
    char *errMsg;
    const char *dbpath = [_databasePath UTF8String];
    BOOL state;
    
    if (sqlite3_open(dbpath, &_systemDatabase) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO alarm (description, hour, minute, days) VALUES (\"%s\", \"%d\", \"%d\", \"%ld\")",
                               [alarm.description UTF8String], alarm.hour, alarm.minutes, (long)[Alarm daysArrayToDaysMask:alarm.days]];
        const char *insert_stmt = [insertSQL UTF8String];
        if (sqlite3_exec(_systemDatabase, insert_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            state = NO;
        else
            state = YES;
        sqlite3_close(_systemDatabase);
    } else {
        state = NO;
    }
    
    if(!state) {printf("%s\n",errMsg);return -1;}
    
    return [self getAlarmByDescription:alarm.description].myId;
}

- (BOOL)removeAlarm:(Alarm *)alarm
{
    char *errMsg;
    const char *dbpath = [_databasePath UTF8String];
    BOOL state;
    
    if (sqlite3_open(dbpath, &_systemDatabase) == SQLITE_OK) {
        NSString *removeSQL = [NSString stringWithFormat:@"DELETE FROM CONTACTS WHERE id = %d", alarm.myId];
        const char *remove_stmt = [removeSQL UTF8String];
        if (sqlite3_exec(_systemDatabase, remove_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            state = NO;
        else {
            state = YES;
        }
        sqlite3_close(_systemDatabase);
    } else {
        state = NO;
    }
    
    return state;
}

@end
