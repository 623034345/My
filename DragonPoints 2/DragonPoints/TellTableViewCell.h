//
//  TellTableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/8/1.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *tellBtn;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *mapBtn;

@end
