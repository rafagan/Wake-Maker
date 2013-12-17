//
//  Song.m
//  alarme
//
//  Created by Rafagan on 17/12/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "Song.h"

@implementation Song


- (void) reset {
    self.volume = 0.5;
    self.name = [self.music valueForProperty:MPMediaItemPropertyTitle];
}

- (void)playMusic
{
    MPMusicPlayerController* appMusicPlayer = [MPMusicPlayerController applicationMusicPlayer];
    [appMusicPlayer setQueueWithItemCollection:self.item];
    [appMusicPlayer play];
}

@end
