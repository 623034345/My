//
//  JudgeViewController.m
//  ForNowIosSupper
//
//  Created by   zmei on 15/8/24.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//
#define kMaxTopikLenth 200
#import "JudgeViewController.h"

@interface JudgeViewController ()

@end

@implementation JudgeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    if (SCREEN_HEIGHT <= 568)
    {
        [self registerForKeyboardNotifications];
        
    }
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    imgArr = [NSMutableArray arrayWithCapacity:0];
    [imgArr addObject:[UIImage imageNamed:@"add"]];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //背景
    self.view.backgroundColor = UICOLOR_HEX(0xf0f1f6);
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"评价";
    //星星
    [self.ratingBarView setImageDeselected:@"bigstar"
                              halfSelected:@"starB"
                              fullSelected:@"bigstar2"
                               andDelegate:self];
    //背景
    self.view.backgroundColor = UICOLOR_HEX(0xf0f1f6);
    
    ratingTextView.delegate = self;
    //隐形文字
    self.placeholderLab = [[UILabel alloc] initWithFrame:CGRectMake(14, 17, CGRectGetWidth(ratingTextView.frame) - 10, 20)];
    self.placeholderLab.text = @"是否满意,评论告诉更多人";
    self.placeholderLab.font = UIFONT(15);
    self.placeholderLab.textColor = UICOLOR_HEX(0x939393);
    self.placeholderLab.textAlignment = NSTextAlignmentLeft;
    [ratingTextView addSubview:self.placeholderLab];
    
    //字数统计
    numsLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, CGRectGetMaxY(ratingTextView.frame) - 10, 70, 20)];
    numsLabel.font = UIFONT(14);
    numsLabel.textColor = UICOLOR_HEX(0x939393);
    numsLabel.textAlignment = NSTextAlignmentRight;
    numsLabel.text = [NSString stringWithFormat:@"%d", kMaxTopikLenth];
    [ratingTextView addSubview:numsLabel];
    if (self.type == 1)
    {
        [ratingTextView setEditable:NO];
        self.ratingBarView.isIndicator = YES;
        ratingTextView.text = self.studentContent;
        [self.ratingBarView displayRating:self.studentStarNum];
        self.placeholderLab.text = @"";
    }
    else
    {
//        [self addNextBtnWithImageNormal:@"m_chark_normal"
//                            highlighted:@"m_chark_normal"
//                                fuction:@selector(submit)];
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.bounds = CGRectMake(0, 0, 20, 20);
        [saveBtn setTitle:@"提交" forState:UIControlStateNormal];
  
        [saveBtn addTarget:self
                    action:@selector(submit)
          forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
        self.navigationItem.rightBarButtonItem = saveBtnItem;
    }
    //列间距
    int columnLength = 1;
    for (int i = 0; i <imgArr.count; i ++)
    {
        int x = (i %4)*((SCREEN_WIDTH - 1)/4 + columnLength) + columnLength ;
        
        imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = CGRectMake(x, 40, SCREEN_WIDTH/4-10, 70);
        [imageBtn setImage:imgArr[i] forState:UIControlStateNormal];
        imageBtn.tag = 1;
        [imageBtn addTarget:self action:@selector(choosBtn) forControlEvents:UIControlEventTouchUpInside];
        [addView addSubview:imageBtn];
    }
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];
}
-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
//添加图片
-(void)choosBtn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([[GlobalCenter sharedInstance] isCameraAvailable])
                            {
                                [self snapImage];
                            }

        
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self btnActionForEditPortrait];

     
    }];
    [alert addAction:cancle];
    [alert addAction:camera];
    [alert addAction:picture];
    [self presentViewController:alert animated:YES completion:nil];
}

//拍照
- (void) snapImage{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([[GlobalCenter sharedInstance] isFrontCameraAvailable])
    {
        imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    else
    {
        [self showAlertWithPoint:1 text:@"未获取访问相机权限" color:UIPINK];
    }
    imagePickerVC.allowsEditing = YES;
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
    imagePickerVC.mediaTypes = mediaTypes;
    imagePickerVC.delegate = self;
    [self presentViewController:imagePickerVC
                       animated:YES
                     completion:^(void)
     {}];

    
}
- (void)didClickOtherImageView:(int)tag
{
    LabelAlert *labelAlert = [[LabelAlert alloc] initLabelAlertWithTipDetailLab:@"您确定要删除该图片吗?"
                                                                        leftBtn:@"取消"
                                                                       rightBtn:@"确定"];
    [labelAlert showView];
    labelAlert.rightBlock = ^
    {
//        [publishVC.imgageArray removeObjectAtIndex:tag];
//        [_upTableView reloadData];
    };
}
//从相册中选取图片
- (void)btnActionForEditPortrait
{

    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc]init];
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,NSDictionary *bindings){
        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
            return duration >= 5;
        }else{
            return  YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:nil];
   
}
/*
 得到选中的图片
 */
#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didSelectAsset:(ALAsset*)asset
{
    picker.maximumNumberOfSelection = 4 - [self.photos count];
}

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    [imgArr removeAllObjects];
    [picker dismissViewControllerAnimated:YES completion:nil];
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset=assets[i];
        
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [imgArr addObject:tempImg];
        
        
    }
    //列间距
    int columnLength = 1;
    for (int i = 0; i <imgArr.count; i ++)
    {
        int x = (i %4)*((SCREEN_WIDTH - 1)/4 + columnLength) + columnLength ;
        
        imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = CGRectMake(x, 40, SCREEN_WIDTH/4-10, 70);
        [imageBtn setImage:imgArr[i] forState:UIControlStateNormal];
        imageBtn.tag = 1;
        [imageBtn addTarget:self action:@selector(choosBtn) forControlEvents:UIControlEventTouchUpInside];
        [addView addSubview:imageBtn];
    }
    [[HttpHelper sharedInstance] upHeadImageArr:imgArr];

}
//触摸加减星星
- (void)ratingChanged:(float)newRating
{
    starCount = (int)newRating;
    NSString *newCout =@"零";
    switch ((int)newRating) {
        case 0:
            newCout = @"零";
            break;
        case 1:
            newCout = @"一";
            break;
        case 2:
            newCout = @"二";
            break;
        case 3:
            newCout = @"三";
            break;
        case 4:
            newCout = @"四";
            break;
        case 5:
            newCout = @"五";
            break;
            
        default:
            break;
    }
    self.ratingLab.text = [NSString stringWithFormat:@"%@星",newCout];
}
- (void)textViewDidChange:(UITextView *)textView
{
    //自动获取焦点弹出键盘
    [ratingTextView becomeFirstResponder];
    self.placeholderLab.text = @"";
    long num = kMaxTopikLenth - ratingTextView.text.length;
    numsLabel.text = [NSString stringWithFormat:@"%ld", num];
    if (num < 0)
    {
        numsLabel.textColor = [UIColor redColor];
    }
    else
    {
        numsLabel.textColor = UICOLOR_HEX(0x939393);
    }
}
-(void)submit
{
    }
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    if ([key isEqualToString:CUSTOMERCOMMENT])
    {
        NSDictionary *successDic = [notify userInfo][CUSTOMERCOMMENT];
//        NSLog(@"%@",successDic);
        if ([successDic[@"code"] isEqualToString:@"1"])
        {
            [self showAlertWithPoint:1 text:successDic[@"msg"] color:UICYAN];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [self showAlertWithPoint:1 text:successDic[@"msg"] color:UIPINK];

        }
    }
    
}

- (void)failure:(NSNotification *)notify
{
    [self dismissView];
    [self showAlertWithPoint:1
                        text:[notify userInfo][FAILURE]
                       color:UIPINK];
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}
- (void) keyboardWasShown:(NSNotification *) notif
{
    self.placeholderLab.text = @"";

    NSDictionary* info = [notif userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.view.frame =  CGRectMake(0,  -kbSize.height+150, SCREEN_WIDTH, SCREEN_HEIGHT - kbSize.height+150);
    
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
    self.view .frame =  SCREEN_BOUNDS;
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    self.placeholderLab.text = @"";

    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        
    }
    return YES;
}

//返回按钮
- (void)didClickBackBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (IBAction)wac:(id)sender {
    [ratingTextView resignFirstResponder];
    
    if (ratingTextView.text.length > kMaxTopikLenth)
    {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
                                                                    text:@"字数超过限制！"
                                                                   color:UIPINK];
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
        
    }
    else
    {
        if (ratingTextView.text.length > 0 || starCount > 0)
        {
            //            [[HttpHelper sharedInstance] judgeWithuserId:[[USER_DEFAULT objectForKey:USERID] longValue]
            //                                               appointId:self.appointId
            //                                                 content:ratingTextView.text
            //                                                   score:starCount];
            [[HttpHelper sharedInstance] CustomerCommentHandleWithproductId:@"61"
                                                                  giveScore:[NSString stringWithFormat:@"%d",starCount]
                                                                 theComment:ratingTextView.text manyimageUrls:@"15451"];
        }
        else
        {
            InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
                                                                        text:@"请选择评分或输入内容!"
                                                                       color:UIPINK];
            [KEYWINDOW addSubview:infoAlert];
            [infoAlert showView];
            
            
        }
        
    }

}
@end
