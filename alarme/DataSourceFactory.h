//
//  DataSourceFactory.h
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDataSource.h"


@interface DataSourceFactory : NSObject <IDataSource> {
    @private
    NSMutableDictionary* dataSource;
}

@end
