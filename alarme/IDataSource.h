//
//  IDataSource.h
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDataSource <NSObject>

@required
- (void)createDataWithName:(NSString*)name andObject:(id)object;
- (id)readDataSearchingByName:(NSString*)name;
- (void)removeDataSearchingByName:(NSString*)name;
- (void)updateDataSearchingByName:(NSString*)name withObject:(id)object;

@end
