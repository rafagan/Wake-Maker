//
//  MainViewController.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "MainViewController.h"
#import "Alarm.h"
#import "gameViewController.h"

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
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    [self clockUpdate:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    
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

- (void)clockUpdate:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
    
    
    NSString *currentTime = [dateFormatter stringFromDate: [NSDate date]];
    _clockLabel.text = currentTime;
}

@end
