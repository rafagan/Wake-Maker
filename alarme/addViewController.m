//
//  addViewController.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "addViewController.h"

@interface addViewController ()

@end

@implementation addViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _editing = false;
        _specificDays = [[NSMutableArray alloc] init];
        for(int i = 0; i < 7; i++)
        {
            int j = i + 1;
            
            [[self specificDays] addObject:[NSString stringWithFormat:@"%d",j]];
        }
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sundayChanged:(id)sender
{
    if(![[self sundayOut] isOn])
    {
        [_specificDays removeObject:@"1"];
    }
    else
    {
        [_specificDays addObject:@"1"];
    }
}

- (IBAction)mondayChanged:(id)sender
{
    if(![[self mondayOut] isOn])
    {
        [_specificDays removeObject:@"2"];
    }
    else
    {
        [_specificDays addObject:@"2"];
    }
}

- (IBAction)tuesdayChanged:(id)sender
{
    if(![[self tuesdayOut] isOn])
    {
        [_specificDays removeObject:@"3"];
    }
    else
    {
        [_specificDays addObject:@"3"];
    }
}

- (IBAction)wednesdayChanged:(id)sender
{
    if(![[self wednesdayOut] isOn])
    {
        [_specificDays removeObject:@"4"];
    }
    else
    {
        [_specificDays addObject:@"4"];
    }
}

- (IBAction)thursdayChanged:(id)sender
{
    if(![[self thursdayOut] isOn])
    {
        [_specificDays removeObject:@"5"];
    }
    else
    {
        [_specificDays addObject:@"5"];
    }
}

- (IBAction)fridayChanged:(id)sender
{
    if(![[self fridayOut] isOn])
    {
        [_specificDays removeObject:@"6"];
    }
    else
    {
        [_specificDays addObject:@"6"];
    }
}

- (IBAction)saturdayChanged:(id)sender
{
    if(![[self saturdayOut] isOn])
    {
        [_specificDays removeObject:@"7"];
    }
    else
    {
        [_specificDays addObject:@"7"];
    }
}

- (IBAction)setBtAc:(id)sender
{
    NSDateComponents *componentsOfTime = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[[self timePicker] date]];
    
    hour = [componentsOfTime hour];
    minutes = [componentsOfTime minute];
    
    if (!_editing)
    {
        _alarm = [Alarm createAlarmWithMinutes:minutes Hour:hour Message:[[self textField] text] Days:_specificDays];
        [APP_MNG.dataAccess addAlarm:_alarm];
    }
    else
    {
        [APP_MNG.dataAccess removeAlarm:[[APP_MNG.dataAccess returnAlarms] objectAtIndex:_row]];
        [[APP_MNG.dataAccess returnAlarms] insertObject:[Alarm createAlarmWithMinutes:minutes Hour:hour Message:[[self textField] text] Days:_specificDays] atIndex:_row];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelBtAc:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
