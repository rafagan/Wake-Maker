//
//  gameViewController.m
//  alarme
//
//  Created by André Traleski de Campos on 11/21/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "GameViewController.h"
#import "ApplicationManager.h"
#import "CombinationGenerator.h"
#import "Symbol.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        appAlarmPlayer = [MPMusicPlayerController applicationMusicPlayer];
        points = 0;
        volume = 0.5;
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSDate* now = [[NSDate alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit) fromDate:now];
    NSInteger hour = [components hour];
    
    typeIsMusic = false;
    int index = 0;
    
    for (int i = 0; i < [[APP_MNG.dataAccess returnAlarms] count]; i++)
    {
        NSDate* alarmDate = [[[APP_MNG.dataAccess returnAlarms] objectAtIndex:i] date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSHourCalendarUnit) fromDate:alarmDate];
        NSInteger alarmDateHour = [components hour];
        if (alarmDateHour < (hour+1))
        {
            index = i;
            typeIsMusic = [[[APP_MNG.dataAccess returnAlarms] objectAtIndex:i] alarmSystemTypeMusic];
            break;
        }
    }
    
    if (typeIsMusic)
    {
        [appAlarmPlayer setQueueWithItemCollection:[[[APP_MNG.dataAccess returnAlarms] objectAtIndex:index] music]];
        [appAlarmPlayer setShuffleMode: MPMusicShuffleModeOff];
        [appAlarmPlayer setRepeatMode: MPMusicRepeatModeOne];
        [appAlarmPlayer play];
    }
    else
    {
        [[AVAudioSession sharedInstance]
         setCategory: AVAudioSessionCategoryPlayback
         error: nil];
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"alarm30" ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundPath];
        NSError* error1 ;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: soundFileURL error: &error1];
        if (nil == _audioPlayer)
        {
            NSLog(@"Faild to play %@, %@", soundFileURL, error1);
            return;
        }
        
        [_audioPlayer prepareToPlay];
        [_audioPlayer setVolume:volume];
        _audioPlayer.numberOfLoops = -1;
        NSLog(@"Started playing sound");
        [_audioPlayer play];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self gameOverLabel] setHidden:YES];
    self.skipBtOut.enabled = NO;
    self.okBtOut.enabled = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPicker Info
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 4;
}

/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    symbol* s = [[[combinationGenerator sharedGenerator] returnSymbols] objectAtIndex:row];
    return s.symbolName;
}
*/

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    Symbol* s = [[[CombinationGenerator sharedGenerator] returnSymbols] objectAtIndex:row];
    UIImageView* imgV = [[UIImageView alloc] initWithImage:s.img];
    return imgV;
}

- (IBAction)okBt:(id)sender
{
    NSArray* verify = [[CombinationGenerator sharedGenerator] returnGeneratedCombination];
    if([[verify objectAtIndex:0] index] == [[self picker] selectedRowInComponent:0] && [[verify objectAtIndex:1] index] == [[self picker] selectedRowInComponent:1] && [[verify objectAtIndex:2] index] == [[self picker] selectedRowInComponent:2] && [[verify objectAtIndex:3] index] == [[self picker] selectedRowInComponent:3])
    {
        points ++;
        [[self pointsLabel] setText:[NSString stringWithFormat:@"%d",points]];
        
        if (points == 3)
        {
            if (typeIsMusic)
                [appAlarmPlayer stop];
            else
                [_audioPlayer stop];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
            [self showComb];
    }
    else
    {
        if (points > 0)
            points--;
        [[self pointsLabel] setText:[NSString stringWithFormat:@"%d",points]];
        [self showComb];
    }
}

- (IBAction)startBt:(id)sender
{
    [[self startBtOut] setHidden:YES];
    [[self gameOverLabel] setHidden:YES];
    self.skipBtOut.enabled = YES;
    self.okBtOut.enabled = YES;
    [self showComb];
}

- (void)showComb
{
    NSArray* rando = [[CombinationGenerator sharedGenerator] generateCombinationWithQuantity:4];
    int i = 1;
    int x = 60;
    int offset = 20;
    int y = self.view.window.bounds.size.height/2 - 140;
    Symbol* s;
    CGRect rect= CGRectMake(x*i-offset, y, 50, 50);
    
    s = [rando objectAtIndex:0];
    [s.imgView setFrame:rect];
    [self.view addSubview:[[rando objectAtIndex:0] imgView]];
    
    i++;
    rect= CGRectMake(x*i-offset, y, 50, 50);
    s = [rando objectAtIndex:1];
    [s.imgView setFrame:rect];
    [self.view addSubview:[[rando objectAtIndex:1] imgView]];
    
    i++;
    rect= CGRectMake(x*i-offset, y, 50, 50);
    s = [rando objectAtIndex:2];
    [s.imgView setFrame:rect];
    [self.view addSubview:[[rando objectAtIndex:2] imgView]];
    
    i++;
    rect= CGRectMake(x*i-offset, y, 50, 50);
    s = [rando objectAtIndex:3];
    [s.imgView setFrame:rect];
    [self.view addSubview:[[rando objectAtIndex:3] imgView]];
    [NSTimer scheduledTimerWithTimeInterval:2.2
                                     target:self
                                   selector:@selector(hideComb)
                                   userInfo:nil
                                    repeats:NO];
}

- (IBAction)skipBt:(id)sender
{
    volume+=0.5;
    [_audioPlayer setVolume:volume];
    [NSTimer cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideComb) object:nil];
    [self hideComb];
    [self showComb];
}

- (void)hideComb
{
    for(UIView* v in self.view.subviews)
    {
        if (v.frame.origin.y == self.view.window.bounds.size.height/2-140)
            [v removeFromSuperview];
    }
}
@end
