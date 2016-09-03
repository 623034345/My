//
//  DetailOneTableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "RatingBarView.h"
@interface DetailOneTableViewCell : UITableViewCell<RatingBarDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *scrollImg;
@property (weak, nonatomic) IBOutlet RatingBarView *Rating;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *fen;
@property (weak, nonatomic) IBOutlet UIButton *fenx;
@property (weak, nonatomic) IBOutlet UIButton *shoucang;
@property (weak, nonatomic) IBOutlet UIButton *mBtn;

@end
