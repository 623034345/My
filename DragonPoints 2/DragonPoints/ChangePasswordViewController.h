//
//  ChangePasswordViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/10.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//         修改登录密码

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldpows;
@property (weak, nonatomic) IBOutlet UITextField *aNewPows1;
@property (weak, nonatomic) IBOutlet UITextField *aNewPows2;
- (IBAction)save:(id)sender;

@end
