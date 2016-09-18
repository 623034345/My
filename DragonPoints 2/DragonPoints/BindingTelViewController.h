//
//  BindingTelViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/11.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//       绑定手机号

#import <UIKit/UIKit.h>

@interface BindingTelViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *telNumber;
@property (weak, nonatomic) IBOutlet UITextField *verifyTX;
@property (weak, nonatomic) IBOutlet UITextField *telNewNumber;
- (IBAction)ConfirmBtn:(id)sender;

@end
