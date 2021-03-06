//
//  MainViewController.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "MainViewController.h"
#import "Alarm.h"
#import "GameViewController.h"
#import "AchievementViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _nightTime = false;
        [NSTimer scheduledTimerWithTimeInterval:0.5
                                         target:self
                                       selector:@selector(clockUpdate:)
                                       userInfo:nil
                                        repeats:YES];
        
        [NSTimer scheduledTimerWithTimeInterval:28800
                                         target:self
                                       selector:@selector(getSatisfiedAchievement:)
                                       userInfo:nil
                                        repeats:NO];
        // Custom initialization
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated
{
    for (int i = 0; i < [[APP_MNG.dataAccess returnAlarms] count];i++)
    {
        if ([[[APP_MNG.dataAccess returnAlarms] objectAtIndex:i] snooze] != nil)
        {
            [[self cancelSnoozeBtOut] setHidden:NO];
            break;
        }
        else
        {
            [[self cancelSnoozeBtOut] setHidden:YES];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    [self clockUpdate:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alarmsBtAc:(id)sender
{
    AlarmViewController* avc = [[AlarmViewController alloc] init];
    [self presentViewController:avc animated:YES completion:nil];
}

- (IBAction)nightBtAc:(id)sender
{
    if (_nightTime)
    {
        _nightTime = false;
        self.view.backgroundColor = [UIColor whiteColor];
        self.clockLabel.textColor = [UIColor whiteColor];
        self.clockLabel.backgroundColor = [UIColor lightGrayColor];
        [self.nightBtOut setTitleColor:[UIColor blackColor] forState:normal];
    }
    else
    {
        _nightTime = true;
        self.view.backgroundColor = [UIColor blackColor];
        self.clockLabel.textColor = [UIColor blueColor];
        self.clockLabel.backgroundColor = [UIColor blackColor];
        [self.nightBtOut setTitleColor:[UIColor blueColor] forState:normal];
    }
}

- (IBAction)cancelSnoozeBtAc:(id)sender
{
    NSDate* now = [[NSDate alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit) fromDate:now];
    NSInteger hour = [components hour];
    
    for (int i = 0; i < [[APP_MNG.dataAccess returnAlarms] count]; i++)
    {
        NSDate* alarmDate = [[[APP_MNG.dataAccess returnAlarms] objectAtIndex:i] date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSHourCalendarUnit) fromDate:alarmDate];
        NSInteger alarmDateHour = [components hour];
        if (alarmDateHour < (hour+1))
        {
            [[UIApplication sharedApplication] cancelLocalNotification:[[[APP_MNG.dataAccess returnAlarms] objectAtIndex:i] snooze]];
            break;
        }
    }
    
    GameViewController* gvc = [[GameViewController alloc] init];
    [self presentViewController:gvc animated:YES completion:nil];
}

- (IBAction)achvmntBtAc:(id)sender
{
    AchievementViewController* avc = [[AchievementViewController alloc] init];
    [self presentViewController:avc animated:YES completion:nil];
}

- (void)clockUpdate:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
    
    
    NSString *currentTime = [dateFormatter stringFromDate: [NSDate date]];
    _clockLabel.text = currentTime;
}

- (void)getSatisfiedAchievement:(id)sender
{
    NSLog(@"Got Achievement");
    if(![[[APP_MNG.dataAccess returnAchievements] objectAtIndex:2] isAchieved])
        [[[APP_MNG.dataAccess returnAchievements] objectAtIndex:2] setIsAchieved:YES];
}
@end
