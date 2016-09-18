//
//  ForgetViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/28.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//        忘记密码

#import <UIKit/UIKit.h>

@interface ForgetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *fieldName;
@property (weak, nonatomic) IBOutlet UITextField *fieldYan;
@property (weak, nonatomic) IBOutlet UITextField *fieldPow;
@property (weak, nonatomic) IBOutlet UIButton *hqyzm;
- (IBAction)hqBtn:(id)sender;
- (IBAction)lookBtn:(id)sender;
- (IBAction)wcBtn:(id)sender;

@end
