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
#import "CustomCell.h"

@interface AlarmViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIView *HeaderView;
@property (weak, nonatomic) IBOutlet UIButton *editBtOut;

- (IBAction)addBtAc:(id)sender;
- (IBAction)editBtAc:(id)sender;
- (IBAction)backBtAc:(id)sender;
@end
