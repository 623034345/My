//
//  MyShopViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/6.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//           我的商店

#import <UIKit/UIKit.h>
#import "RatingBarView.h"
#import "TransactionViewController.h"
#import "AccountViewController.h"
#import "AppraiseViewController.h"
#import "CancelViewController.h"
#import "ToDealViewController.h"
@interface MyShopViewController : UIViewController<RatingBarDelegate>
{
    NSInteger type;
    NSDictionary *dataDic;
}
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet RatingBarView *tating;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UITextField *verifyFiled;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;

- (IBAction)verifyBtn:(id)sender;
- (IBAction)sBtn:(id)sender;
- (IBAction)orderBtn:(id)sender;
- (IBAction)sao:(id)sender;

@end
