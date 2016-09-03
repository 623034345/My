//
//  EdetailTableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/8/4.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar/RatingBarView.h"
@interface EdetailTableViewCell : UITableViewCell<RatingBarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet RatingBarView *star;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
