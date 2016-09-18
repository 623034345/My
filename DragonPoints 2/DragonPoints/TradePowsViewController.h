//
//  TradePowsViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/10.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//          修改交易密码

#import <UIKit/UIKit.h>

@interface TradePowsViewController : UIViewController
{
    UITextField *topTX;
    UITextField *aNewTX1;
    UITextField *aNewTX2;

    NSMutableArray *dataSource;
    NSMutableArray *dataSource1;
    NSMutableArray *dataSource2;
    NSString *pows1;
    NSString *pows2;

    NSString *pows3;

}
@end
