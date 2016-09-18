//
//  ModifyViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/13.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//           绑定/修改绑定银行卡支付宝

#import <UIKit/UIKit.h>

@interface ModifyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *table;

    NSInteger type;
    NSInteger type1;

    NSMutableArray *btnArr;
    NSMutableArray *btnArr1;

    UITextField *bankTX;
    UITextField *cardNumbTX;
    UITextField *cardNumbTX1;
    UITextField *banNameTX;
    UITextField *verifyTX;
    NSString *ah;
    
}
@property(nonatomic)NSInteger ghing;
@property(nonatomic)NSInteger oneType;
@end
