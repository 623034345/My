//
//  ChoosMoreViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/24.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//           选择申请类别

#import <UIKit/UIKit.h>
#import "MoreOneModel.h"
#import "MoreTwoModel.h"
typedef void(^TypeBlock)(NSString *province,NSString *Z); //定义一个代码块

@interface ChoosMoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *firstArr;
    NSMutableArray *secondArr;
    __weak IBOutlet UITableView *table1;
    __weak IBOutlet UITableView *table2;
    NSInteger indexSeleted;
    NSInteger currentIndex;
}

@property (copy, nonatomic) TypeBlock typeInfo; //选择的类型信息
@property (copy, nonatomic) NSString *type; //选中的省
@property (nonatomic) NSString *Z;


- (IBAction)sumitBtn:(id)sender;
- (void)returnTypeInfo:(TypeBlock)block; //赋值的时候回调
@end
