//
//  gameViewController.h
//  alarme
//
//  Created by André Traleski de Campos on 11/21/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MainViewController.h"

@interface GameViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    int points;
    float volume;
    Alarm* alarm;
    bool typeIsMusic;
    bool canGetAchievement;
    MPMusicPlayerController* appAlarmPlayer;
}
- (IBAction)okBt:(id)sender;
- (IBAction)startBt:(id)sender;
- (void)showComb;
- (IBAction)skipBt:(id)sender;
- (void)hideComb;
- (IBAction)snoozeBtAc:(id)sender;
@property (strong, nonatomic) AVAudioPlayer* audioPlayer;
@property (weak, nonatomic) IBOutlet UIButton *startBtOut;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *skipBtOut;
@property (weak, nonatomic) IBOutlet UIButton *okBtOut;
@property (weak, nonatomic) IBOutlet UILabel *gameOverLabel;
@property (weak, nonatomic) IBOutlet UIButton *snoozeBtOut;

@end
