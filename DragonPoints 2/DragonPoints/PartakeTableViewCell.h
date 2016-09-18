//
//  PartakeTableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar/RatingBarView.h"

@interface PartakeTableViewCell : UITableViewCell<RatingBarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numsP;
@property (weak, nonatomic) IBOutlet UILabel *hPlease;
@property (weak, nonatomic) IBOutlet UIImageView *touxiang;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *shopImg;
@property (weak, nonatomic) IBOutlet UIButton *more;
@property (weak, nonatomic) IBOutlet RatingBarView *rating;

@end
