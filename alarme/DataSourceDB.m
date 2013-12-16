//
//  DataSourceFactory.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "DataSourceDB.h"
#import "Alarm.h"

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
        
//        contacts = [[NSMutableArray alloc] init];
//        qryContacts = [[NSMutableArray alloc] init];
        
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
            

//            [self loadData];
            
            sqlite3_close(_systemDatabase);
        } else {
            NSLog(@"Falha ao criar/abrir o BD");
        }
    }
    return self;
}

- (void)initializeDatabase {
    char *errMsg;
    
    const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS alarm (id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT NOT NULL, hour INTEGER NOT NULL, minute INTEGER NOT NULL, sun BOOLEAN, mon BOOLEAN, tue BOOLEAN, wed BOOLEAN, thu BOOLEAN, fri BOOLEAN, sat BOOLEAN)";
    if (sqlite3_exec(_systemDatabase, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        NSLog(@"Falha ao criar as tabelas do banco");
    else
        NSLog(@"Tabelas abertas/criadas com sucesso");

}

- (NSMutableArray*)getAllData:(NSString *)dataType
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    NSMutableArray *alarms = [NSMutableArray new];
    
    if (sqlite3_open(dbpath, &_systemDatabase) == SQLITE_OK) {
        const char *query_stmt = [@"SELECT * FROM alarm" UTF8String];
        
        if (sqlite3_prepare_v2(_systemDatabase, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *cod = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *city = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
//                Contact *contact = [[Contact alloc] initWithName:name City:city];
//                [contact setCod:cod];
//                [contacts addObject:contact];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_systemDatabase);
    }
    return alarms;
}

- (id)readDataSearchingById:(int)id {
    
    
    return nil;
}

- (void)removeDataSearchingByName:(NSString *)name {
    [dataSource removeObjectForKey:name];
}

- (void)updateDataSearchingByName:(NSString*)name withObject:(id)object {
    [dataSource removeObjectForKey:name];
    [dataSource setObject:object forKey:name];
}

- (void)createDataWithName:(NSString*)name andObject:(id)object {
    [dataSource setObject:object forKey:name];
}

@end
