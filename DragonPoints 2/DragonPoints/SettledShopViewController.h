//
//  SettledShopViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/5.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//         商家入驻 注册

#import <UIKit/UIKit.h>
#import "CityViewController.h"
#import "ChoosMoreViewController.h"
@interface SettledShopViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UITableView *table;
    UITextField *shopName;
    UITextField *name;
    UITextField *moveTell;
    UITextField *tell;
    UITextField *dc;
    UITextField *adressTX;

    UIButton *typeBtn;
    UIButton *locaBtn;

    UIButton *mapBtn;
    
    UIButton *license;
    UIButton *licenseBtn;
    UIImageView *licenImg;

    UIButton *front;

    UIImageView *frontImg;

    UIButton *reverse;
    UIImageView *reverseImg;

    int num;
    NSMutableArray *imgNameArr;
    NSString *_Z;
    NSString *_L;



}
@end
