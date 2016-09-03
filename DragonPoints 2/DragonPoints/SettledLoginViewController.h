//
//  SettledLoginViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/4.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//         商家登录

#import <UIKit/UIKit.h>
#import "SettledShopViewController.h"
#import "MyShopViewController.h"
@interface SettledLoginViewController : UIViewController<UITextFieldDelegate>
{
    UILabel *nameLab;
    UILabel *powsLab;

}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *pows;
- (IBAction)back:(id)sender;
- (IBAction)nextView:(id)sender;
- (IBAction)insert:(id)sender;
@end
