//
//  ShopDtailTableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface ShopDtailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet SDCycleScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *rPrice;
@property (weak, nonatomic) IBOutlet UILabel *hPrice;
@property (weak, nonatomic) IBOutlet UILabel *shou;
@property (weak, nonatomic) IBOutlet UIButton *fenxiang;
@property (weak, nonatomic) IBOutlet UIButton *shoucang;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;

@end
