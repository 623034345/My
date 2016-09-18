//
//  TableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBarView.h"

@interface TableViewCell : UITableViewCell<RatingBarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *fenlei;
@property (weak, nonatomic) IBOutlet UILabel *juli;
@property (weak, nonatomic) IBOutlet RatingBarView *Rating;
@property (weak, nonatomic) IBOutlet UILabel *pingfen;

@end
