//
//  PwdSettingViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/17.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//    设置交易密码

#import <UIKit/UIKit.h>

@interface PwdSettingViewController : UIViewController
{
    UITextField *topTX;
    UITextField *aNewTX1;
    UILabel *teleTX;
    UITextField *smsTX;
    
    NSMutableArray *dataSource;
    NSMutableArray *dataSource1;
    NSString *pows1;
    NSString *pows2;
    
    
    
}
@end
