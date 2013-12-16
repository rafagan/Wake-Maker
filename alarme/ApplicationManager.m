//
//  ApplicationManager.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "ApplicationManager.h"

@implementation ApplicationManager

+ (ApplicationManager *)getMe
{
    static ApplicationManager* data = nil;
    if(!data)
        data = [[super alloc] init];
    return data;
}

- (id)init
{
    self = [super init];
    if (self) {
        _dataAccess = [[DataAccess alloc] init];
    }
    return self;
}
@end
