//
//  MainViewController.h
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmViewController.h"

@interface MainViewController : UIViewController
@property bool nightTime;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel;
@property (weak, nonatomic) IBOutlet UIButton *alarmsBtOut;
@property (weak, nonatomic) IBOutlet UIButton *nightBtOut;

- (IBAction)alarmsBtAc:(id)sender;
- (IBAction)nightBtAc:(id)sender;
- (IBAction)cancelSnoozeBtAc:(id)sender;

- (void)clockUpdate:(id)sender;
@end
