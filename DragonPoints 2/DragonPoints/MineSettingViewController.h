//
//  MineSettingViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/8.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//       个人中心

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "ChangePasswordViewController.h"
#import "TradePowsViewController.h"
#import "NicknameViewController.h"
#import "BindingTelViewController.h"
#import "PwdSettingViewController.h"
#import "ViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface MineSettingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,VPImageCropperDelegate>
{
    UITableView *table;
    UILabel *shopName;
    UITextField *name;
    UITextField *moveTell;
    UITextField *tell;
    UITextField *dc;
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
    NSMutableArray *imageArr;
    UILabel *sexLab;
    
    UIView *sexOnView; //性别弹窗
    NSMutableArray *sexArr;
    NSString *sexName;
    
    
}
@end
