//
//  ModifyViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/13.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "ModifyViewController.h"

@interface ModifyViewController ()

@end

@implementation ModifyViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏TabBar
    [self.tabBarController.tabBar setHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
    
    [[HttpHelper sharedInstance]removeListener:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    btnArr = [NSMutableArray array];
//    type1 = 3;
    btnArr1 = [NSMutableArray array];
    if (_ghing == 1) {
        self.navigationItem.title = @"修改绑定账户";
        if (self.oneType == 1) {
            type = 1;

        }
        else
        {
            type = 2;

        }

    }
    if (_ghing == 2) {
        self.navigationItem.title = @"绑定账户";
        type = 1;

    }
    self.view.backgroundColor = UIWHITE;
    
    [self cteatTable];
    
    
    
    
    [self creatView];
    
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
}
-(void)cteatTable
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 163) style:UITableViewStyleGrouped];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self touchTable:table commentTableViewTouchInSide:@selector(commentTableViewTouchInSide)];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatView
{
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [btn4 setTitle:@"完成" forState:UIControlStateNormal];
    [btn4 setTitleColor:UIWHITE forState:UIControlStateNormal];
    [btn4 setBackgroundColor:UIRED];
    [btn4 addTarget:self action:@selector(submitBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    view.backgroundColor = UIWHITE;
    [self.view addSubview:view];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    lab.font = [UIFont systemFontOfSize:13.0f];
    lab.text = @"选择绑定类型";
    [view addSubview:lab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(90, 10, 30, 30);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1;
    if (type == 1) {
        [btn setBackgroundColor:UIRED];
    }
    [view addSubview:btn];
    [btnArr addObject:btn];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 40, 50)];
    lab1.font = [UIFont systemFontOfSize:13.0f];
    lab1.text = @"银行卡";
    [view addSubview:lab1];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(210, 10, 30, 30);
    if (type == 2) {
        [btn1 setBackgroundColor:UIRED];
    }
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 2;
    [view addSubview:btn1];
    [btnArr addObject:btn1];
    
    [btn.layer setBorderColor:UIRED.CGColor];
    [btn.layer setBorderWidth:1];
    [btn.layer setMasksToBounds:YES];
    [btn1.layer setBorderColor:UIRED.CGColor];
    [btn1.layer setBorderWidth:1];
    [btn1.layer setMasksToBounds:YES];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 40, 50)];
    lab2.font = [UIFont systemFontOfSize:13.0f];
    lab2.text = @"支付宝";
    [view addSubview:lab2];
  
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (_ghing == 1) {
        if (type == 1) {
            return 5;
        }
        if (type == 2) {
            return 4;
        }
//    }
//    if (_ghing == 2) {
//        if (type == 1) {
//            return 4;
//        }
//        if (type == 2) {
//            return 3;
//        }
//    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_ghing == 1) {
        if (type == 1) {
            if (indexPath.row == 0)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
                    cell.tag = 0;
                    cell.selectionStyle = UITableViewCellAccessoryNone;

                    bankTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
                    bankTX.placeholder = @"开户银行";
                    bankTX.delegate = self;
                    [cell addSubview:bankTX];
                }
             
                return cell;
            }
            if (indexPath.row == 1)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e"];
                    cell.tag = 0;

                    cardNumbTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
                    cardNumbTX.placeholder = @"请输入银行卡号";
                    
                    cardNumbTX.delegate = self;
                    [cell addSubview:cardNumbTX];
                    cell.selectionStyle = UITableViewCellAccessoryNone;

                }
              
                return cell;
            }
            if (indexPath.row == 2)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e2"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e2"];
                    cell.tag = 0;

                    cardNumbTX1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
                    cardNumbTX1.placeholder = @"请输入持卡人姓名";
                    
                    cardNumbTX1.delegate = self;
                    [cell addSubview:cardNumbTX1];
                    cell.selectionStyle = UITableViewCellAccessoryNone;

                }
              
                return cell;
            }
            if (indexPath.row == 3)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e3"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e3"];
                    cell.tag = 0;
                    cell.selectionStyle = UITableViewCellAccessoryNone;

                    
                    banNameTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
                    banNameTX.placeholder = @"请输入开户行名称";
                    banNameTX.delegate = self;
                    [cell addSubview:banNameTX];
                }
              
                return cell;
            }
            if (indexPath.row == 4)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e3"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e3"];
                    cell.tag = 0;

                    verifyTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
                    verifyTX.placeholder = @"请输入验证码";
                    verifyTX.delegate = self;
                    [cell addSubview:verifyTX];
                    
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(160, 0, 150, 44);
                    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    [btn setTitleColor:UIRED forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(yanBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:btn];
                    cell.selectionStyle = UITableViewCellAccessoryNone;

                }
            
                return cell;
            }
        }
        ///////////////////////////////////////////////////type///////////////////////////////////////////////////////////
        if (type == 2)
        {
            if (indexPath.row == 0)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
                    bankTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
                    bankTX.placeholder = @"请输入支付宝账户";
                    bankTX.delegate = self;
                    [cell addSubview:bankTX];
                    cell.selectionStyle = UITableViewCellAccessoryNone;

                }
           
                return cell;
            }
            if (indexPath.row == 1)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e"];
                    cell.selectionStyle = UITableViewCellAccessoryNone;

                    cardNumbTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
                    cardNumbTX.placeholder = @"请输入支付宝用户名";
                    
                    cardNumbTX.delegate = self;
                    [cell addSubview:cardNumbTX];
                 
                }
               
                return cell;
            }
            if (indexPath.row == 2) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e2"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e2"];
                    cell.selectionStyle = UITableViewCellAccessoryNone;

                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
                    lab.font = [UIFont systemFontOfSize:13.0f];
                    lab.text = @"选择支付宝类型";
                    [cell addSubview:lab];
                    
                    
                    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 40, 50)];
                    lab1.font = [UIFont systemFontOfSize:13.0f];
                    lab1.text = @"个人";
                    [cell addSubview:lab1];
                    
                    
                    
                    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(290, 0, 40, 50)];
                    lab2.font = [UIFont systemFontOfSize:13.0f];
                    lab2.text = @"企业";
                    [cell addSubview:lab2];
                    
                    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn1.frame = CGRectMake(250, 10, 30, 30);
                    [btn1 addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
                    btn1.tag = 3;
                    [cell addSubview:btn1];
                    [btnArr1 addObject:btn1];
                    
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(130, 10, 30, 30);
                    [btn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
                    btn.tag = 4;
                    if (type1 == 3) {
                        [btn setBackgroundColor:UIRED];
                    }
                    [cell addSubview:btn];
                    [btnArr1 addObject:btn];
                    
                    [btn.layer setBorderColor:UIRED.CGColor];
                    [btn.layer setBorderWidth:1];
                    [btn.layer setMasksToBounds:YES];
                    [btn1.layer setBorderColor:UIRED.CGColor];
                    [btn1.layer setBorderWidth:1];
                    [btn1.layer setMasksToBounds:YES];

                }
                return cell;
            }
            if (indexPath.row == 3)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e3"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e3"];
                    cell.selectionStyle = UITableViewCellAccessoryNone;
                    verifyTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
                    verifyTX.placeholder = @"请输入验证码";
                    verifyTX.delegate = self;
                    [cell addSubview:verifyTX];
                    
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(160, 0, 150, 44);
                    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    [btn setTitleColor:UIRED forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(yanBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:btn];
                   
                }
            
                return cell;
            }

        }
//    }
//    if (_ghing == 2) {
//        if (type == 1) {
//            if (indexPath.row == 0)
//            {
//                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
//                if (!cell)
//                {
//                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
//                    cell.tag = 0;
//                    cell.selectionStyle = UITableViewCellAccessoryNone;
//                    
//                    bankTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//                    bankTX.placeholder = @"开户银行";
//                    bankTX.delegate = self;
//                    [cell addSubview:bankTX];
//                }
//                
//                return cell;
//            }
//            if (indexPath.row == 1)
//            {
//                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e"];
//                if (!cell)
//                {
//                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e"];
//                    cell.tag = 0;
//                    
//                    cardNumbTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//                    cardNumbTX.placeholder = @"请输入银行卡号";
//                    
//                    cardNumbTX.delegate = self;
//                    [cell addSubview:cardNumbTX];
//                    cell.selectionStyle = UITableViewCellAccessoryNone;
//                    
//                }
//                
//                return cell;
//            }
//            if (indexPath.row == 2)
//            {
//                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e2"];
//                if (!cell)
//                {
//                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e2"];
//                    cell.tag = 0;
//                    
//                    cardNumbTX1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//                    cardNumbTX1.placeholder = @"请输入持卡人姓名";
//                    
//                    cardNumbTX1.delegate = self;
//                    [cell addSubview:cardNumbTX1];
//                    cell.selectionStyle = UITableViewCellAccessoryNone;
//                    
//                }
//                
//                return cell;
//            }
//            if (indexPath.row == 3)
//            {
//                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e3"];
//                if (!cell)
//                {
//                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e3"];
//                    cell.tag = 0;
//                    cell.selectionStyle = UITableViewCellAccessoryNone;
//                    
//                    
//                    banNameTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//                    banNameTX.placeholder = @"请输入开户行名称";
//                    banNameTX.delegate = self;
//                    [cell addSubview:banNameTX];
//                }
//                
//                return cell;
//            }
//            
//        }
//        ///////////////////////////////////////////////////type///////////////////////////////////////////////////////////
//        if (type == 2)
//        {
//            if (indexPath.row == 0)
//            {
//                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
//                if (!cell)
//                {
//                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
//                    bankTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//                    bankTX.placeholder = @"请输入支付宝账户";
//                    bankTX.delegate = self;
//                    [cell addSubview:bankTX];
//                    cell.selectionStyle = UITableViewCellAccessoryNone;
//                    
//                }
//                
//                return cell;
//            }
//            if (indexPath.row == 1)
//            {
//                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e"];
//                if (!cell)
//                {
//                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e"];
//                    cell.selectionStyle = UITableViewCellAccessoryNone;
//                    
//                    cardNumbTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//                    cardNumbTX.placeholder = @"请输入支付宝用户名";
//                    
//                    cardNumbTX.delegate = self;
//                    [cell addSubview:cardNumbTX];
//                    
//                }
//                
//                return cell;
//            }
//            if (indexPath.row == 2) {
//                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOn1e2"];
//                if (!cell)
//                {
//                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOn1e2"];
//                    cell.selectionStyle = UITableViewCellAccessoryNone;
//                    
//                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
//                    lab.font = [UIFont systemFontOfSize:13.0f];
//                    lab.text = @"选择绑定类型";
//                    [cell addSubview:lab];
//                    
//                    
//                    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 40, 50)];
//                    lab1.font = [UIFont systemFontOfSize:13.0f];
//                    lab1.text = @"银行卡";
//                    [cell addSubview:lab1];
//                    
//                    
//                    
//                    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 40, 50)];
//                    lab2.font = [UIFont systemFontOfSize:13.0f];
//                    lab2.text = @"支付宝";
//                    [cell addSubview:lab2];
//                    
//                    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//                    btn1.frame = CGRectMake(210, 10, 30, 30);
//                    [btn1 addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
//                    btn1.tag = 3;
//                    [cell addSubview:btn1];
//                    [btnArr1 addObject:btn1];
//                    
//                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    btn.frame = CGRectMake(90, 10, 30, 30);
//                    [btn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
//                    btn.tag = 4;
//                    if (type1 == 3) {
//                        [btn setBackgroundColor:UIRED];
//                    }
//                    [cell addSubview:btn];
//                    [btnArr1 addObject:btn];
//                    
//                    [btn.layer setBorderColor:UIRED.CGColor];
//                    [btn.layer setBorderWidth:1];
//                    [btn.layer setMasksToBounds:YES];
//                    [btn1.layer setBorderColor:UIRED.CGColor];
//                    [btn1.layer setBorderWidth:1];
//                    [btn1.layer setMasksToBounds:YES];
//                    
//                }
//                return cell;
//            }
//            
//            
//        }
//    }
    return nil;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    [textField becomeFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        
    }
    return YES;
}
//获取验证码
-(void)yanBtn:(UIButton *)button
{
    button.titleLabel.text = @"重新获取验证码";
    [[HttpHelper sharedInstance] sendSmsWithtele:[USER_DEFAULT objectForKey:PHONE]];

}
//完成
-(void)submitBtn
{
    if (type == 1) {
        if (NULL_STR(bankTX.text)) {
            [self showAlertWithPoint:1 text:@"银行名字不能为空" color:UIPINK];
         
        }
        if (NULL_STR(cardNumbTX.text) && !NULL_STR(bankTX.text)) {
            [self showAlertWithPoint:1 text:@"银行卡号不能为空" color:UIPINK];

        }
        if (![[GlobalCenter sharedInstance] checkCardNo:cardNumbTX.text])
        {
            [self showAlertWithPoint:1 text:@"请输入正确的银行卡" color:UIPINK];
        }
        if (NULL_STR(cardNumbTX1.text) && !NULL_STR(cardNumbTX.text) && !NULL_STR(bankTX.text))
        {
            [self showAlertWithPoint:1 text:@"持卡人姓名不能为空" color:UIPINK];

        }
        if (NULL_STR(banNameTX.text) && !NULL_STR(cardNumbTX.text) && !NULL_STR(bankTX.text)  && !NULL_STR(cardNumbTX1.text))
        {
            [self showAlertWithPoint:1 text:@"开户行不能为空" color:UIPINK];

        }
//        if (_ghing == 1) {
            if (NULL_STR(verifyTX.text) && !NULL_STR(cardNumbTX.text) && !NULL_STR(bankTX.text)  && !NULL_STR(cardNumbTX1.text)&& !NULL_STR(banNameTX.text))
            {
                [self showAlertWithPoint:1 text:@"验证码不能为空" color:UIPINK];

            }
//        }
        if(!NULL_STR(verifyTX.text) && !NULL_STR(cardNumbTX.text) && !NULL_STR(bankTX.text)  && !NULL_STR(cardNumbTX1.text)&& !NULL_STR(banNameTX.text) && ![[GlobalCenter sharedInstance] checkCardNo:cardNumbTX.text])
        {
            if (_ghing == 2) {
                [[HttpHelper sharedInstance] BindBankCardWithbankName:bankTX.text
                                                           bankCardId:cardNumbTX.text
                                                        bankOwnerName:cardNumbTX1.text
                                                             bankOpen:banNameTX.text
                                                              msmCode:verifyTX.text];
            }
            if (_ghing == 1) {
                [[HttpHelper sharedInstance] ModifyBindBankCardWithbankName:bankTX.text
                                                           bankCardId:cardNumbTX.text
                                                        bankOwnerName:cardNumbTX1.text
                                                             bankOpen:banNameTX.text
                                                              msmCode:verifyTX.text];
            }
        
        }
        

    }
    if (type == 2) {
        if (NULL_STR(bankTX.text))
        {
            [self showAlertWithPoint:1 text:@"支付宝账户不能为空" color:UIPINK];

        }
        else if (NULL_STR(cardNumbTX.text) && !NULL_STR(bankTX.text))
        {
            [self showAlertWithPoint:1 text:@"支付宝主人名字不能为空" color:UIPINK];

        }

        if (NULL_STR(ah) && !NULL_STR(cardNumbTX.text) && !NULL_STR(bankTX.text))
        {
            [self showAlertWithPoint:1 text:@"请选择支付宝类型" color:UIPINK];

        }
//        if (_ghing == 1) {
            if (NULL_STR(verifyTX.text) && !NULL_STR(cardNumbTX.text) && !NULL_STR(ah) )
            {
                [self showAlertWithPoint:1 text:@"验证码不能为空" color:UIPINK];
            }
//        }
        if (!NULL_STR(verifyTX.text) && !NULL_STR(cardNumbTX.text) && !NULL_STR(ah) )
            
        {
            if (_ghing == 2) {
                [[HttpHelper sharedInstance] BindZhifubaoWithzhifubaoCode:bankTX.text
                                                          zhifubaoUseName:cardNumbTX.text
                                                             zhifubaoType:UTF_8(ah)
                                                                  msmCode:verifyTX.text];
            }
            if (_ghing == 1) {
                [[HttpHelper sharedInstance] ModifyBindZhifubaoWithzhifubaoCode:bankTX.text
                                                          zhifubaoUseName:cardNumbTX.text
                                                             zhifubaoType:ah
                                                                  msmCode:verifyTX.text];
            }
           
        }
     

    }
}
-(void)btnClick1:(UIButton *)button
{
    if (button.tag == 3) {
        ah = @"个人账户";
    }
    if (button.tag == 4) {
        ah = @"企业账户";
    }
    for (UIButton *btn in btnArr1) {
        if (btn.tag == button.tag) {
            type1 = btn.tag - 2;
            [btn setBackgroundColor:UIRED];
        }
        else
        {
            [btn setBackgroundColor:UIWHITE];
            [btn.layer setBorderColor:UIRED.CGColor];
            [btn.layer setBorderWidth:1];
            [btn.layer setMasksToBounds:YES];
        }
    }
    
}
-(void)btnClick:(UIButton *)button
{
    if (_ghing == 1) {
        if (type == 1) {
            if (button.tag == 2) {
                [self showAlertWithPoint:1 text:@"你已绑定银行卡,无需选择" color:UIPINK];

            }
            return;

        }
        if (type == 2) {
            if (button.tag == 1) {
                [self showAlertWithPoint:1 text:@"你已绑定支付宝,无需选择" color:UIPINK];

            }
            return;

        }

    }
    if (_ghing == 2)
    {
        [table removeFromSuperview];
        [self cteatTable];
        for (UIButton *btn in btnArr) {
            if (btn.tag == button.tag) {
                type = btn.tag;
                [btn setBackgroundColor:UIRED];
            }
            else
            {
                [btn setBackgroundColor:UIWHITE];
                [btn.layer setBorderColor:UIRED.CGColor];
                [btn.layer setBorderWidth:1];
                [btn.layer setMasksToBounds:YES];
            }
        }
        [table reloadData];
    }

    
    
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    if ([key isEqualToString:BANKCARD])
    {
        /*     code    1  绑定成功
         -1  已经绑定银行卡了，不能重复绑定
         -2  已经绑定支付宝了，不能再绑定银行卡
         -3  数据库错误   */
        NSDictionary *successDic = [notify userInfo][key];
        NSLog(@"%@",successDic);
        if ([successDic[@"code"] isEqualToString:@"1"])
        {
            [self showAlertWithPoint:1 text:@"绑定成功" color:UICYAN];
        }
        else
        {
            [self showAlertWithPoint:1 text:@"绑定失败" color:UIPINK];

        }

    }
    if ([key isEqualToString:ZHIFUBAO])
    {
        /*     code    1  绑定成功
         -1  已经绑定支付宝了，不能重复绑定
         -2  已经绑定银行卡了，不能再绑定支付宝
         -3  数据库错误     */
        NSDictionary *successDic = [notify userInfo][key];
        NSLog(@"%@",successDic);

        if ([successDic[@"code"] isEqualToString:@"1"])
        {
            [self showAlertWithPoint:1 text:@"修改成功" color:UICYAN];
        }
        else
        {
            [self showAlertWithPoint:1 text:@"修改失败" color:UIPINK];
            
        }
    }
    if ([key isEqualToString:SENDSMS])
    {
        NSDictionary *successDic = [notify userInfo][SENDSMS];
//        NSLog(@"%@",successDic);
        NSString *rt_msg = successDic[@"msg"];
        NSString *msg = successDic[@"code"];
        if ([msg isEqualToString:@"1"]) {
            [self showAlertWithPoint:1
                                text:rt_msg
                               color:UICYAN];
        }
        else
        {
            [self showAlertWithPoint:1
                                text:rt_msg
                               color:UIPINK];
        }
        
        
        
    }
    
}

- (void)failure:(NSNotification *)notify
{
        [self dismissIndicatorView];
        [self showAlertWithPoint:1
                            text:[notify userInfo][FAILURE]
                           color:UIPINK];
    
}
-(void)commentTableViewTouchInSide
{
    [bankTX resignFirstResponder];
    [cardNumbTX resignFirstResponder];
    [cardNumbTX1 resignFirstResponder];
    [banNameTX resignFirstResponder];
    [verifyTX resignFirstResponder];

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

@end
