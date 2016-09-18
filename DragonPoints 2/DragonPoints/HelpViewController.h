//
//  HelpViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//          申请帮助

#import <UIKit/UIKit.h>
#import "ZYQAssetPickerController.h"

@interface HelpViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,ZYQAssetPickerControllerDelegate>
{
    UITableView *table;
    UITextField *nameTX;
    UITextField *numberTX;
    UITextField *homeTX;
    UITextField *telTX;
    
    NSString *content;
    UIView *textView;
    UITextView *onView;
    UILabel *numLab;
    NSMutableArray *imgArr;
    UIButton *imageBtn;
    
    
    NSMutableArray *imgArr1;
    UIButton *imageBtn1;
    NSInteger type;
    
}
@end
