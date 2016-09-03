//
//  ProfileTableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/8/10.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *cont;
@property (weak, nonatomic) IBOutlet UIButton *deletel;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end
