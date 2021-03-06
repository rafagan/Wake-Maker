//
//  AlarmViewController.m
//  alarme
//
//  Created by André Traleski de Campos on 12/10/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "AchievementViewController.h"
#import "Achievement.h"

@interface AchievementViewController ()

@end

@implementation AchievementViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        UINib *nib = [UINib nibWithNibName:@"AchieveCustomCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"AchieveCustomCell"];
        [[self tableView] setTableHeaderView:[self achievementHeaderView]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"AchievementTableView Successfully Reloaded");
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)achievementHeaderView
{
    if (!_achievementHeaderView)
        [[NSBundle mainBundle]loadNibNamed:@"AchievementHeaderView" owner:self options:nil];
    
    return _achievementHeaderView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger number = [[APP_MNG.dataAccess returnAchievements] count];
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"AchieveCustomCell";
    AchieveCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Achievement* achievement = [[APP_MNG.dataAccess returnAchievements] objectAtIndex:[indexPath row]];
    
    [[cell text] setText:achievement.name];
    [[cell description] setText:achievement.description];
    if (achievement.isAchieved)
    {
        [[cell text] setTextColor:[UIColor whiteColor]];
        [[cell description] setTextColor:[UIColor whiteColor]];
        [[cell checkImg] setHidden:NO];
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    
    // Configure the cell...
    
    return cell;
}

- (IBAction)backBtAc:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [APP_MNG.dataAccess removeAlarm:[[APP_MNG.dataAccess returnAlarms] objectAtIndex:[indexPath row]]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddViewController* addvc = [[AddViewController alloc] init];
    addvc.editing = YES;
    addvc.row = [indexPath row];
    
    [self presentViewController:addvc animated:YES completion:nil];
}
*/

@end
