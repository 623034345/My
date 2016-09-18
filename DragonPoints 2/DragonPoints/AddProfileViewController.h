//
//  AddProfileViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/10.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//        添加收货地址

#import <UIKit/UIKit.h>
#import "CityViewController.h"
@interface AddProfileViewController : UIViewController
{
    BOOL isSelected;
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *tell;
@property (weak, nonatomic) IBOutlet UIButton *choosLoc;
@property (weak, nonatomic) IBOutlet UITextField *locLab;
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)lBtn:(UIButton *)sender;
- (IBAction)save:(id)sender;
- (IBAction)choosL:(UIButton *)sender;

@end
