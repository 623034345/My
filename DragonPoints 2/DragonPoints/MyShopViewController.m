//
//  MyShopViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/6.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "MyShopViewController.h"

@interface MyShopViewController ()

@end

@implementation MyShopViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"我的店铺";
    //    [self hideNavigationBarLine];
    [self.tabBarController.tabBar setHidden:YES];
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dataDic = [NSDictionary dictionary];
    _tating.isBig = YES;
    [_tating setImageDeselected:@"star2"
                   halfSelected:@"starB"
                   fullSelected:@"rating_show"
                    andDelegate:self];

    _tating.isIndicator = YES;
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    _lab1.layer.masksToBounds = YES;
    _lab1.layer.cornerRadius = 20;
    
    _lab2.layer.masksToBounds = YES;
    _lab2.layer.cornerRadius = 20;
    [_lab2 setHidden:YES];
    
    _lab3.layer.masksToBounds = YES;
    _lab3.layer.cornerRadius = 20;
    _img.image = [UIImage imageNamed:@"shiyan"];

    [self getData];
    
}
-(void)getData
{
    [[HttpHelper sharedInstance] ShopperMain];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    if ([key isEqualToString:SHOPPERMINE])
    {
        dataDic = [notify userInfo][SHOPPERMINE];
//        NSLog(@"%@",dataDic);
        [_tating displayRating:[dataDic[@"score"] integerValue]];
        _name.text = dataDic[@"shopperName"];
        [_img sd_setImageWithURL:[NSURL URLWithString:dataDic[@"shopperImage"]]];
        if ([dataDic[@"orderCount"] integerValue] >0) {
            _lab1.text = dataDic[@"orderCount"];
        }
        if ([dataDic[@"orderCount"] integerValue] == 0) {
            [_lab1 setHidden:YES];
        }
        if ([dataDic[@"notReadCommentCount"] integerValue] >0) {
            _lab3.text = dataDic[@"notReadCommentCount"];
        }
        if ([dataDic[@"notReadCommentCount"] integerValue] == 0) {
            [_lab3 setHidden:YES];
        }
        _num.text = [NSString stringWithFormat:@"%@分",dataDic[@"score"]];

    }
    //扫码验证
    if ([key isEqualToString:SCANREDEEM]) {
//        NSDictionary *successDic =[notify userInfo][SCANREDEEM];
    }
 
    
}

- (void)failure:(NSNotification *)notify
{
    [self dismissView];
    [self showAlertWithPoint:0
                        text:[notify userInfo][FAILURE]
                       color:UIPINK];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)ratingChanged:(float)newRating
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//验证
- (IBAction)verifyBtn:(id)sender
{
    [[HttpHelper sharedInstance] MobileWithredeemCode:_verifyFiled.text];
//    CancelViewController *cvc = [[CancelViewController alloc] init];
//    
//    [self.navigationController pushViewController:cvc animated:YES];
}

- (IBAction)sBtn:(id)sender
{
    type = 1;
    if ([[GlobalCenter sharedInstance] isCameraAvailable]) {
        ScanQRcode *vc = [[ScanQRcode alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self showAlertWithPoint:0 text:@"未获取相机权限" color:UIPINK];
    }
 
}
#pragma mark- ImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //2.初始化一个监测器
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    [picker dismissViewControllerAnimated:YES completion:^{
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >=1)
        {
            /**结果对象 */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            if (scannedResult)
            {
                NSString *contents = scannedResult;
                if ([contents containsString:@"http://"])
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:contents]];
                }
                else
                {
                    NSLog(@"扫描结果：%@",contents);
                    //云币扫描
                    if (type == 1)
                    {
                        [[HttpHelper sharedInstance] MobileWithredeemCode:contents];

//                        [[HttpHelper sharedInstance] coinToDailWithSaleId:contents];

                    }
                    //现金扫描
                    else
                    {
                        
                    }
                }
            }
        }
        else
        {
            [self showAlertWithPoint:0 text:@"该二维码不能被找到" color:UIPINK];
            NSLog(@"该图片没有包含一个二维码！");
        }
    }];
}
- (IBAction)orderBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 0) {
        UIButton *btn = (UIButton *)sender;
        TransactionViewController *tvc = [[TransactionViewController alloc] init];
        tvc.type = btn.tag;
        [self.navigationController pushViewController:tvc animated:YES];
    }
    if (btn.tag == 1)
    {
        AccountViewController *avc = [[AccountViewController alloc] init];
        [self.navigationController pushViewController:avc animated:YES];
    }
    if (btn.tag == 2)
    {
        AppraiseViewController *avc = [[AppraiseViewController alloc] init];
        [self.navigationController pushViewController:avc animated:YES];
    }
}

- (IBAction)sao:(id)sender {
    type = 2;
    ToDealViewController *tvc = [[ToDealViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
}
@end
