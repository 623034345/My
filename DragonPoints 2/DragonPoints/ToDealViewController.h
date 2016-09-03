//
//  ToDealViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/21.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//           现金扫描处理

#import <UIKit/UIKit.h>

@interface ToDealViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;
@property (weak, nonatomic) IBOutlet UILabel *lab7;
- (IBAction)pay:(id)sender;

@end
