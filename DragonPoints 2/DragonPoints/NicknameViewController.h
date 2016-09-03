//
//  NicknameViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/11.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//       昵称

#import <UIKit/UIKit.h>

@interface NicknameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTX;
- (IBAction)saveBtn:(id)sender;

@end
