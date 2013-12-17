//
//  AlarmViewController.h
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationManager.h"
#import "AddViewController.h"
#import "AchieveCustomCell.h"

@interface AchievementViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIView *achievementHeaderView;
- (IBAction)backBtAc:(id)sender;
@end
