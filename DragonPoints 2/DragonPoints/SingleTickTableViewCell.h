//
//  NoneTableViewCell.h
//  ForNowIosSupper
//
//  Created by fornowIOS on 15/7/14.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *带单选择的的表格
 */
@interface SingleTickTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UIImageView *tipView;

@end
