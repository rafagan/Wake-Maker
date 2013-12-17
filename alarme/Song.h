//
//  Song.h
//  alarme
//
//  Created by Rafagan on 17/12/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Song : NSObject

@property (nonatomic,strong) MPMediaItemCollection* collectionItem;
@property (nonatomic,strong) MPMediaItem* item;
@property (nonatomic,setter = setVolume:) NSInteger volume;
@property (nonatomic,strong) NSString* name;
@property (nonatomic) BOOL canVibrate;
@property (nonatomic) SystemSoundID nativeSound;
@property (nonatomic) BOOL isNative;

+ (Song*)createSongWithName:(NSString*)name;

- (void)playMusic;
- (void)reset;

@end
