//
//  LoginViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/28.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//                   登录

#import <UIKit/UIKit.h>
#import "RegistrationViewController.h"
#import "ForgetViewController.h"
#import "ViewController.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>
//{
//    UIImageView *touImg;
//    UIImageView *suoImg;
//    UITextField *fieldName;
//    UITextField *fieldPows;
//}
@property(nonatomic)BOOL isFrist;
@property (weak, nonatomic) IBOutlet UITextField *fieldPow;
@property (weak, nonatomic) IBOutlet UITextField *fieldName;
- (IBAction)login:(id)sender;
- (IBAction)zhaoBtn:(id)sender;
- (IBAction)zhuBtn:(id)sender;
@end
