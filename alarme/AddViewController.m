//
//  addViewController.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _editing = false;
        _specificDays = [[NSMutableArray alloc] init];
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if(!_editing)
    {
        _specificDays = [[NSMutableArray alloc] init];
        for(int i = 0; i < 7; i++)
        {
            int j = i + 1;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
            [self.view addGestureRecognizer:tap];
            [[self specificDays] addObject:[NSString stringWithFormat:@"%d",j]];
        }
    }
    else if (_editing)
    {
        [[self textField] setText:[[[APP_MNG.dataAccess returnAlarms] objectAtIndex:_row] alertBody]];
        _alarm = [[APP_MNG.dataAccess returnAlarms] objectAtIndex:_row];
        selectedMusic = _alarm.music;
        [self.musicButton setTitle:selectedMusic.name forState:UIControlStateNormal];
        
        [[self sundayOut] setOn:NO];
        [[self mondayOut] setOn:NO];
        [[self tuesdayOut] setOn:NO];
        [[self thursdayOut] setOn:NO];
        [[self wednesdayOut] setOn:NO];
        [[self fridayOut] setOn:NO];
        [[self saturdayOut] setOn:NO];
        
        for (int i = 0; i < [[[[APP_MNG.dataAccess returnAlarms] objectAtIndex:_row]days] count]; i++)
        {
            NSUInteger j = [[[[[APP_MNG.dataAccess returnAlarms] objectAtIndex:_row] days] objectAtIndex:i] integerValue];
            
            switch (j) {
                case 1:
                    [[self sundayOut] setOn:YES];
                    [_specificDays addObject:@"1"];
                    break;
                
                case 2:
                    [[self mondayOut] setOn:YES];
                    [_specificDays addObject:@"2"];
                    break;
                    
                case 3:
                    [[self tuesdayOut] setOn:YES];
                    [_specificDays addObject:@"3"];
                    break;
                    
                case 4:
                    [[self wednesdayOut] setOn:YES];
                    [_specificDays addObject:@"4"];
                    break;
                    
                case 5:
                    [[self thursdayOut] setOn:YES];
                    [_specificDays addObject:@"5"];
                    break;
                    
                case 6:
                    [[self fridayOut] setOn:YES];
                    [_specificDays addObject:@"6"];
                    break;
                    
                case 7:
                    [[self saturdayOut] setOn:YES];
                    [_specificDays addObject:@"7"];
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textField.delegate = self;
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
    
    static int v = 1000;
    AudioServicesPlaySystemSound(v);
    v++;
}

- (IBAction)setBtAc:(id)sender
{
    NSDateComponents *componentsOfTime = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[[self timePicker] date]];
    
    hour = [componentsOfTime hour];
    minutes = [componentsOfTime minute];
    
    if (selectedMusic == nil)
        isMusic = false;
    else
        isMusic = true;
    
    if(selectedMusic == nil) {
        selectedMusic = [Song new];
        selectedMusic.isNative = YES;
        selectedMusic.canVibrate = YES;
        selectedMusic.volume = 0.5f;
    }
    
    _alarm = [Alarm createAlarmWithMinutes:(int)minutes Hour:(int)hour Description:[[self textField] text] Days:_specificDays Music:selectedMusic];
    
    if (!_editing)
        [APP_MNG.dataAccess addAlarm:_alarm];
    else {
        [APP_MNG.dataAccess removeAlarm:[[APP_MNG.dataAccess returnAlarms] objectAtIndex:_row]];
        [APP_MNG.dataAccess addAlarm:_alarm];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectSong:(id)sender
{
    MPMediaPickerController *picker =
    [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    
    picker.delegate                     = self;
    picker.allowsPickingMultipleItems   = NO;
    picker.prompt                       = @"Select any song";
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    MPMediaItem* music = [[mediaItemCollection items]objectAtIndex:0];
    
    selectedMusic = [Song new];
    selectedMusic.collectionItem = mediaItemCollection;
    selectedMusic.item = music;
    [selectedMusic reset];
    
    [self.musicButton setTitle:selectedMusic.name forState:UIControlStateNormal];
}
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[self textField] resignFirstResponder];
    return YES;
}

- (IBAction)cancelBtAc:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissKeyboard:(UITapGestureRecognizer *)sender
{
    [self.textField resignFirstResponder];
}
@end
