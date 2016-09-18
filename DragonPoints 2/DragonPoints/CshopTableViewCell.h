//
//  CshopTableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/8/8.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBarView.h"
@interface CshopTableViewCell : UITableViewCell<RatingBarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet RatingBarView *rating;
@property (weak, nonatomic) IBOutlet UILabel *pf;

@end
