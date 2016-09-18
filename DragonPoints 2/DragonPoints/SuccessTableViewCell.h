//
//  SuccessTableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/8/6.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *num;

@end
