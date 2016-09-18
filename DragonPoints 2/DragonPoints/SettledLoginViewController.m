//
//  SettledLoginViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/4.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "SettledLoginViewController.h"

@interface SettledLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *insertBtn;

@end

@implementation SettledLoginViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.navigationItem.title = @"";
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backImg.image = [UIImage imageNamed:@"backImg"];
    [self.view addSubview:backImg];
    [self.name.layer setBorderColor:UICOLOR_HEX(0xea4b35).CGColor];
    [self.name.layer setBorderWidth:1];
    [self.name.layer setMasksToBounds:YES];
    [self.pows.layer setBorderColor:UICOLOR_HEX(0xea4b35).CGColor];
    [self.pows.layer setBorderWidth:1];
    [self.pows.layer setMasksToBounds:YES];
    [self.insertBtn.layer setBorderColor:UICOLOR_HEX(0xea4b35).CGColor];
    [self.insertBtn.layer setBorderWidth:1];
    [self.insertBtn.layer setMasksToBounds:YES];
    
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, _name.frame.size.height)];
    nameLab.textColor = UIBLUE;
    nameLab.backgroundColor = UICLEAR;
    nameLab.text = @"请输入账号";
    [_name addSubview:nameLab];
    
    powsLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 200, _pows.frame.size.height)];
    powsLab.textColor = UIBLUE;
    powsLab.backgroundColor = UICLEAR;
    powsLab.text = @"请输入商家登录密码";
    [_pows addSubview:powsLab];
    
    
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//-(void)creatView
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    view.backgroundColor = UIBLACK;
//    view.alpha = 0.7;
//    [self.view addSubview:view];
//    
//    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    saveBtn.frame = CGRectMake(0, 10, 30, 30);
//    [saveBtn setImage:[UIImage imageNamed:@"bbb"] forState:UIControlStateNormal];
//    [saveBtn addTarget:self
//                action:@selector(backView)
//      forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:saveBtn];
//    
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, SCREEN_WIDTH - 100, 50)];
//    lab.backgroundColor = UICLEAR;
//    lab.textAlignment = NSTextAlignmentCenter;
//    lab.text = @"商家入口";
//    lab.textColor = UIWHITE;
//    [view addSubview:lab];
//    
//    
//}





#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    if ([JUDGE isEqualToString:key])
    //    {
    //        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
    //                                                                    text:@"评论成功"
    //                                                                   color:UICYAN];
    //        [KEYWINDOW addSubview:infoAlert];
    //        [infoAlert showView];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            if (self.typeOne == 1)
    //            {
    //
    //            }
    //
    //            [self.navigationController popViewControllerAnimated:YES];
    //
    //        });
    //
    //
    //    }
    
}

- (void)failure:(NSNotification *)notify
{
    //    [self dismissView];
    //    [self showAlertWithPoint:0
    //                        text:[notify userInfo][FAILURE]
    //                       color:UIPINK];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ((textField = _name)) {
        nameLab.text = @"";
    }
    if ((textField = _pows)) {
        powsLab.text = @"";
    }

    
    return YES;
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

- (IBAction)nextView:(id)sender
{
    MyShopViewController *mvc = [[MyShopViewController alloc] init];
    [self.navigationController pushViewController:mvc animated:YES];
    if (NULL_STR(_name.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
                                                                    text:@"用户名不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    if (NULL_STR(_pows.text) && !NULL_STR(_name.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
                                                                    text:@"密码不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
}

- (IBAction)insert:(id)sender
{
    SettledShopViewController *svc =[[SettledShopViewController  alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
@end
