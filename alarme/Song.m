//
//  Song.m
//  alarme
//
//  Created by Rafagan on 17/12/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "Song.h"

@implementation Song
{
    MPMusicPlayerController* appMusicPlayer;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.isNative = true;
    }
    return self;
}

- (void) reset {
    self.volume = 0.5;
    self.name = [self.item valueForProperty:MPMediaItemPropertyTitle];
    self.isNative = NO;
    self.canVibrate = YES;
    self.nativeSound = 1321;
}

- (void)setVolume:(NSInteger)volume
{
    appMusicPlayer.volume = volume;
}

- (void)playMusic
{
    if(!self.isNative || self.collectionItem != nil) {
        appMusicPlayer = [MPMusicPlayerController applicationMusicPlayer];
        
        [appMusicPlayer setShuffleMode: MPMusicShuffleModeOff];
        [appMusicPlayer setRepeatMode: MPMusicRepeatModeOne];
        
        [appMusicPlayer setQueueWithItemCollection:self.collectionItem];
        [appMusicPlayer play];
    } else {
        AudioServicesPlaySystemSound(self.nativeSound);
    }
    
    if(self.canVibrate)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (Song *)createSongWithName:(NSString *)name
{
    Song* s = [[Song alloc]init];
    s.name = name;
    
    MPMediaPropertyPredicate *songPredicate =
    [MPMediaPropertyPredicate predicateWithValue:name
                                     forProperty:MPMediaItemPropertyTitle
                                  comparisonType:MPMediaPredicateComparisonContains];
    
    MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
    [songsQuery addFilterPredicate:songPredicate];
    
    if([songsQuery items].count == 0) return nil;
    
    s.item = [[songsQuery items] objectAtIndex:0];
    s.collectionItem = [[MPMediaItemCollection alloc] initWithItems:[NSArray arrayWithObject:s.item]];
    s.volume = 0.5;
    
    return s;
}

@end
