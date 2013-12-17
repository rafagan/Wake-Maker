//
//  CustomCell.h
//  alarme
//
//  Created by André Traleski de Campos on 12/12/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AchieveCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;

@end
