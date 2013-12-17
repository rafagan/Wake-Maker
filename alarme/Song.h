//
//  Song.h
//  alarme
//
//  Created by Rafagan on 17/12/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface Song : NSObject

@property (nonatomic,strong) MPMediaItemCollection* item;
@property (nonatomic,strong) MPMediaItem* music;
@property (nonatomic) NSInteger volume;
@property (nonatomic,strong) NSString* name;

- (void)playMusic;
- (void)reset;

@end
