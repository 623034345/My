//
//  RegistrationViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/28.
//  Copyright © 2016年 FengYingJie         . All rights reserved.
//                         注册

#import <UIKit/UIKit.h>

#import "CityViewController.h"
@interface RegistrationViewController : UIViewController<UITextFieldDelegate>
{
//    UITextField *fieldName;
//    UITextField *fieldPows;
//    UITextField *fieldYan;
//    UIImageView *touImg;
//    UIImageView *suoImg;
//    UIImageView *yanImg;
    NSInteger _X,_Z;
}
@property (weak, nonatomic) IBOutlet UITextField *fieldName;
@property (weak, nonatomic) IBOutlet UITextField *fieldYan;
@property (weak, nonatomic) IBOutlet UITextField *fieldPow;
@property (weak, nonatomic) IBOutlet UITextField *fieldQ;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
- (IBAction)huoBtn:(id)sender;
- (IBAction)chaButton:(id)sender;
- (IBAction)saoBtn:(id)sender;
- (IBAction)chooseBtn:(id)sender;
- (IBAction)wanBtn:(id)sender;

@end
