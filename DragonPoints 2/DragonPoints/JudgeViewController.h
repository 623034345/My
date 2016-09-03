//
//  JudgeViewController.h
//  ForNowIosSupper
//
//  Created by   fyj on 15/8/24.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBarView.h"
#import "ZYQAssetPickerController.h"
/*
   评价
 */
@interface JudgeViewController : UIViewController<RatingBarDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,ZYQAssetPickerControllerDelegate>
{
    IBOutlet UITextView *ratingTextView; //输入框
    UILabel *numsLabel;//字数统计label
    int starCount; //星星数

    __weak IBOutlet UIView *addView;
    NSMutableArray *imgArr;
    UIButton *imageBtn;
}

@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet RatingBarView *ratingBarView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLab;
@property (assign, nonatomic) long appointId;
@property (strong, nonatomic) UILabel *placeholderLab;
@property (strong, nonatomic) NSString *studentContent;
@property (assign, nonatomic) float studentStarNum;
@property (assign, nonatomic) int type;
@property (assign, nonatomic) int typeOne;
@property (nonatomic, strong)NSMutableArray *photos;
@property (nonatomic, strong)NSMutableArray *thumbs;
- (IBAction)wac:(id)sender;

@end
