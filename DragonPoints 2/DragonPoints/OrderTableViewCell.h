//
//  OrderTableViewCell.h
//  DragonPoints
//
//  Created by shangce on 16/8/3.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAppointmentBtnView.h"
@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UIImageView *shopImg;
@property (weak, nonatomic) IBOutlet UILabel *shangName;
@property (weak, nonatomic) IBOutlet UILabel *xing;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *jie;
@property (weak, nonatomic) IBOutlet UIButton *saoBtn;
@property (weak, nonatomic) IBOutlet MyAppointmentBtnView *myOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;

@end
