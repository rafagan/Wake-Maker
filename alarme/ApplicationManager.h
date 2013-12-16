//
//  ApplicationManager.h
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAccess.h"

#define APP_MNG [ApplicationManager getMe]

@interface ApplicationManager : NSObject

+(ApplicationManager*)getMe;

@property(nonatomic, strong) DataAccess* dataAccess;

@end
