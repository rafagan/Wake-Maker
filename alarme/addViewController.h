//
//  addViewController.h
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationManager.h"

@interface addViewController : UIViewController <UITextFieldDelegate, MPMediaPickerControllerDelegate>
{
    int minutes, hour;
    MPMediaItemCollection* selectedMusic;
}

@property NSMutableArray* specificDays;
@property Alarm* alarm;
@property bool editing;
@property int row;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

- (IBAction)selectSong:(id)sender;
- (IBAction)sundayChanged:(id)sender;
- (IBAction)mondayChanged:(id)sender;
- (IBAction)tuesdayChanged:(id)sender;
- (IBAction)wednesdayChanged:(id)sender;
- (IBAction)thursdayChanged:(id)sender;
- (IBAction)fridayChanged:(id)sender;
- (IBAction)saturdayChanged:(id)sender;
- (IBAction)setBtAc:(id)sender;
- (IBAction)cancelBtAc:(id)sender;
- (void)dismissKeyboard:(UITapGestureRecognizer*)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISwitch *sundayOut;
@property (weak, nonatomic) IBOutlet UISwitch *mondayOut;
@property (weak, nonatomic) IBOutlet UISwitch *tuesdayOut;
@property (weak, nonatomic) IBOutlet UISwitch *wednesdayOut;
@property (weak, nonatomic) IBOutlet UISwitch *thursdayOut;
@property (weak, nonatomic) IBOutlet UISwitch *fridayOut;
@property (weak, nonatomic) IBOutlet UISwitch *saturdayOut;
@end
