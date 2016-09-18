//
//  LocallTableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocallTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mapLab;
@property (weak, nonatomic) IBOutlet UILabel *tellLab;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIButton *tellBtn;
@property (weak, nonatomic) IBOutlet UIButton *mapBtn;

@end
