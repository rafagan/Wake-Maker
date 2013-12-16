//
//  DataSourceFactory.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "DataSourceFactory.h"

@implementation DataSourceFactory

- (id)init
{
    self = [super init];
    if (self) {
        dataSource = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (id)readDataSearchingByName:(NSString *)name {
    return [dataSource objectForKey:name];
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
