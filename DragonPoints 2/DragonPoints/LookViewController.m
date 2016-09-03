//
//  LookViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/3.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "LookViewController.h"

@interface LookViewController ()

@end

@implementation LookViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"买单";
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    self.view.backgroundColor = UIWHITE;
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 110) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [btn setBackgroundColor:UIRED];
    [btn setTitle:@"去支付" forState:UIControlStateNormal];
    [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    fieldYan = [[UITextField alloc] initWithFrame:CGRectMake(20, 180, SCREEN_WIDTH - 40, 40)];
    fieldYan.placeholder = @"请输入金额";
    fieldYan.delegate =self;
    fieldYan.layer.borderWidth = 1.0f;
    fieldYan.keyboardType = UIKeyboardTypeNumberPad;
    fieldYan.layer.cornerRadius = 5;
    fieldYan.layer.borderColor = UIBLACK.CGColor;
    [self.view addSubview:fieldYan];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 235, SCREEN_WIDTH, 30)];
    lab.text = @"提示:请仔细核对账单无误后输入实际买单金额!!!";
    lab.font = [UIFont systemFontOfSize:15];
    lab.textColor = UIRED;
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil] lastObject];
    }
    [cell.Rating displayRating:3.5];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)nextBtn
{
    if (NULL_STR(fieldYan.text))
    {

        [self showAlertWithPoint:1 text:@"金额不能为空" color:UIPINK];
    }
    else
    {
        if ([self isNumText:fieldYan.text]) {
            PayViewController *pvc = [[PayViewController alloc] init];
            pvc.numText = fieldYan.text;
            pvc.typeOn = 3;
            [self.navigationController pushViewController:pvc animated:YES];

        }
            else
        {
                [self showAlertWithPoint:1 text:@"金额只能为数字" color:UIPINK];

        }
     
    }

}
//是否是纯数字
-(BOOL)isNumText:(NSString *)str{
    NSString * regex      = @"^[0-9]+([.]{0}|[.]{1}[0-9]+)$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (isMatch)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
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
