//
//  RegistrationViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/28.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()
@property (retain, nonatomic) IBOutlet UITextField *areaText;
@property (retain, nonatomic) IBOutlet UITextField *cityText;
@property (strong, nonatomic) NSString *areaValue, *cityValue;

//-(void)cancelLocatePicker;
@end

@implementation RegistrationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
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
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = UIWHITE;
//    [[HttpHelper sharedInstance] classify];

//    fieldName = [[UITextField alloc] initWithFrame:CGRectMake(20, 104, SCREEN_WIDTH - 40, 55)];
//    fieldName.placeholder = @"               输入手机号或用户名";
//    fieldName.delegate =self;
//    fieldName.layer.borderWidth = 1.0f;
//    fieldName.layer.cornerRadius = 5;
//    fieldName.layer.borderColor = UIBLACK.CGColor;
//    [self.view addSubview:fieldName];
//    
//    touImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 30, 30)];
//    touImg.image = [UIImage imageNamed:@"name"];
//    [fieldName addSubview:touImg];
//    
//    fieldYan = [[UITextField alloc] initWithFrame:CGRectMake(20, 180, SCREEN_WIDTH - 40, 55)];
//    fieldYan.placeholder = @"               输入验证码";
//    fieldYan.delegate =self;
//    fieldYan.layer.borderWidth = 1.0f;
//    fieldYan.layer.cornerRadius = 5;
//    fieldYan.layer.borderColor = UIBLACK.CGColor;
//    [self.view addSubview:fieldYan];
//    yanImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 30, 30)];
//    yanImg.image = [UIImage imageNamed:@"yanzheng"];
//    [fieldYan addSubview:yanImg];
//    UIButton *yanzhengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    yanzhengBtn.frame = CGRectMake(SCREEN_WIDTH - 130, 0, 80, 55);
//    [yanzhengBtn setTitle:@"点击获取" forState:UIControlStateNormal];
//    [yanzhengBtn setTitleColor:UIBLACK forState:UIControlStateNormal];
//    [yanzhengBtn addTarget:self action:@selector(yanzhengBtn) forControlEvents:UIControlEventTouchUpInside];
//    [fieldYan addSubview:yanzhengBtn];
//
//    
//    fieldPows = [[UITextField alloc] initWithFrame:CGRectMake(20, 252, SCREEN_WIDTH - 40, 55)];
//    fieldPows.placeholder = @"               输入密码";
//    fieldPows.delegate =self;
//    [fieldPows setSecureTextEntry:YES];
//    fieldPows.layer.borderWidth = 1.0f;
//    fieldPows.layer.cornerRadius = 5;
//    fieldPows.layer.borderColor = UIBLACK.CGColor;
//    [self.view addSubview:fieldPows];
//    suoImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 30, 30)];
//    suoImg.image = [UIImage imageNamed:@"pow"];
//    [fieldPows addSubview:suoImg];
//    UIButton *chakanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    chakanBtn.frame = CGRectMake(SCREEN_WIDTH - 90, 10, 40, 40);
//    [chakanBtn setBackgroundImage:[UIImage imageNamed:@"look"] forState:UIControlStateNormal];
//    [chakanBtn setTitleColor:UIBLACK forState:UIControlStateNormal];
//    chakanBtn.userInteractionEnabled = YES;
//    [chakanBtn addTarget:self action:@selector(chakanBtn) forControlEvents:UIControlEventTouchUpInside];
//    [fieldPows addSubview:chakanBtn];
//
//    
//    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    loginBtn.frame = CGRectMake(20, 320, SCREEN_WIDTH - 40, 55);
//    [loginBtn setTitle:@"完成" forState:UIControlStateNormal];
//    [loginBtn setBackgroundImage:[UIImage imageNamed:@"bigBtn"] forState:UIControlStateNormal];
//    [loginBtn addTarget:self action:@selector(wancheng) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginBtn];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backUp)];
    
}
-(void)backUp
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(CGRect)textRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset(bounds, 50, 0);
//    CGRect inset = CGRectMake(bounds.origin.x+190, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    
//    return inset;
//    
//}
////控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset( bounds, 10 , 0 );
//    
//    CGRect inset = CGRectMake(bounds.origin.x +50, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
//}

#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([key isEqualToString:RIGISTRATION]) {
        NSDictionary *successDic = [notify userInfo][RIGISTRATION];
        NSLog(@"%@",successDic);
        //    NSString *rt_code = successDic[@"rt_code"];
        NSString *rt_msg = successDic[@"rt_msg"];
        NSString *rt_code =successDic[@"rt_code"];
        if ([rt_code isEqualToString:@"1"]) {
            [self showAlertWithPoint:0
                                text:rt_msg
                               color:UICYAN];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [self showAlertWithPoint:0
                                text:rt_msg
                               color:UIPINK];
        }
    }
    if ([key isEqualToString:SENDSMS])
    {
        NSDictionary *successDic = [notify userInfo][SENDSMS];
        NSLog(@"%@",successDic);
        NSString *rt_msg = successDic[@"msg"];
        NSString *msg = successDic[@"code"];
        if ([msg isEqualToString:@"1"]) {
            [self showAlertWithPoint:0
                                text:rt_msg
                               color:UICYAN];
        }
        else
        {
            [self showAlertWithPoint:0
                                text:rt_msg
                               color:UIPINK];
        }
      


    }

//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"Region.plist"];
//    NSLog(@"地址%@",path);
//    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
//        
//    {
//        
//        NSFileManager* fileManager = [NSFileManager defaultManager];
//        
//        [fileManager createFileAtPath:path contents:nil attributes:nil];
//        
//        [successDic writeToFile:path atomically:YES];
//        
//    }
    
    
}

- (void)failure:(NSNotification *)notify
{
        [self dismissIndicatorView];
        [self showAlertWithPoint:0
                            text:[notify userInfo][FAILURE]
                           color:UIPINK];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)huoBtn:(id)sender
{
    if (NULL_STR(_fieldName.text)) {
        [self showAlertWithPoint:0
                            text:@"手机号不能为空"
                           color:UIPINK];
    }
   
    else
    {
        if ([[GlobalCenter sharedInstance] isMobileStr:_fieldName.text])
        {
            [[HttpHelper sharedInstance] sendSmsWithtele:_fieldName.text];
            
        }
        else
        {
            [self showAlertWithPoint:0
                                text:@"请输入正确的手机号"
                               color:UIPINK];
        }

    }
}

- (IBAction)chaButton:(id)sender {
    [self.fieldPow setSecureTextEntry:NO];

}

- (IBAction)saoBtn:(id)sender
{
}

- (IBAction)chooseBtn:(id)sender {

    CityViewController *city = [[CityViewController alloc] init];

    [city returnCityInfo:^(NSString *province, NSString *city, NSString *area,NSString *town, NSInteger S, NSInteger Q, NSInteger X, NSInteger Z) {
//                province.text = province; //选择的省
//                    area.text = area; //选择的地区
                    NSString *name = [NSString stringWithFormat:@"%@ %@ %@ %@",province,city,area,town];
                    _cityField.text = name;
        _X = X;
        _Z = Z;
        
    }];
    [self.navigationController pushViewController:city animated:YES];

    
}
- (IBAction)wanBtn:(id)sender {
    NSString *zhen = [NSString stringWithFormat:@"%ld",(long)_Z];
    NSString *xian = [NSString stringWithFormat:@"%ld",(long)_X];
    if (NULL_STR(_fieldName.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
                                                                    text:@"用户名不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    if (![[GlobalCenter sharedInstance] isPasswordStr:_fieldPow.text]) {
        [self showAlertWithPoint:0 text:@"密码不少于6位且最少有一个数字" color:UIPINK];
    }

    else if ((NULL_STR(_fieldYan.text) && !NULL_STR(_fieldName.text)))
    {
        [self showAlertWithPoint:0
                            text:@"验证码不能为空"
                           color:UIPINK];
    }
    else if (NULL_STR(_fieldPow.text) && !NULL_STR(_fieldName.text) && !NULL_STR(_fieldYan.text))
    {
        [self showAlertWithPoint:0
                            text:@"密码不能为空"
                           color:UIPINK];
    }
    
    else if (NULL_STR(_cityField.text) && !NULL_STR(_fieldName.text) && !NULL_STR(_fieldYan.text))
    {
                [self showAlertWithPoint:0
                                    text:@"注册地址不能为空"
                                   color:UIPINK];
    }
  
    else if (!NULL_STR(_cityField.text) && !NULL_STR(_fieldName.text) && !NULL_STR(_fieldYan.text) && [[GlobalCenter sharedInstance] isPasswordStr:_fieldPow.text])
    {
        NSString *regionId;
        
        
                if (!NULL_STR(zhen)) {
                    regionId = zhen;
                }
                else
                {
                    regionId = xian;
        
                }
                [[HttpHelper sharedInstance]
                 //注册人手机号
                 registrationgWithtele:UTF_8(_fieldName.text)
                 //密码
                 passWord:UTF_8(_fieldPow.text)
                 //推荐人
                 recommenderTele:UTF_8(_fieldQ.text)
                 //注册地址
                 regionId:UTF_8(regionId)
                 //验证码
                 smsCode:_fieldYan.text];
    }

    
    


}
@end
