//
//  PreSaleViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/8.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "PreSaleViewController.h"

@interface PreSaleViewController ()

@end

@implementation PreSaleViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr = [NSMutableArray array];
    data = [NSDictionary dictionary];
    a = 1;
    if (self.onType == 1) {
        self.navigationItem.title = @"预售";

    }
    else
    {
        self.navigationItem.title = @"立即支付";

    }
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;

    [self.view addSubview:table];
    [self touchTable:table commentTableViewTouchInSide:@selector(commentTableViewTouchInSide)];
    
    UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [subBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [subBtn setTitleColor:UIWHITE forState:UIControlStateNormal];
    [subBtn setBackgroundColor:UIRED];
    [subBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subBtn];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    [self getData];
    
}
-(void)getData
{
    [[HttpHelper sharedInstance] preSaleWithproductId:self.productId];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
//提交订单
-(void)submit
{
    //兑换商品
    if ([data[@"isspecialPrice"] isEqualToString:@"N"]) {
        BalancePayViewController *bvc = [[BalancePayViewController alloc] init];
        bvc.productId = self.productId;
        bvc.buyAmount = [NSString stringWithFormat:@"%d",a];
        bvc.leavemessage = fieldYan.text;
        bvc.number = 1;
        [self.navigationController pushViewController:bvc animated:YES];
    }
    //特价商品
    else
    {
        //预售
        if (_onType == 1)
        {
            [[HttpHelper sharedInstance] PrepareToPayWillToThirdpaybuyerMemberId:[USER_DEFAULT objectForKey:USERID]
                                                                       productId:_productId
                                                                    buyAmountStr:[NSString stringWithFormat:@"%d",a]
                                                                    leavemessage:fieldYan.text
                                                                      ifConsumed:@"N"];
        }
        //立即买单
        if (_onType == 2)
        {
            [[HttpHelper sharedInstance] PrepareToPayWillToThirdpaybuyerMemberId:[USER_DEFAULT objectForKey:USERID]
                                                                       productId:_productId
                                                                    buyAmountStr:[NSString stringWithFormat:@"%d",a]
                                                                    leavemessage:fieldYan.text
                                                                      ifConsumed:@"Y"];
        }
    
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellin"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellin"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
            img.tag = 15;
            [cell addSubview:img];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 150, 30)];
            lab.tag = 16;
            [cell addSubview:lab];
        }
        UIImageView *img = (UIImageView *)[cell viewWithTag:15];
        UILabel *lab = (UILabel *)[cell viewWithTag:16];
        if (data.count >0) {
            [img sd_setImageWithURL:[NSURL URLWithString:data[@"shopperImage"]]];
            lab.text = data[@"shopperName"];

        }
        return cell;
        
    }
    if (indexPath.row == 1) {
        SuccessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuccessTableViewCell"];
        if (!cell ) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SuccessTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;

        }
        if (data.count > 0) {
            [cell.img sd_setImageWithURL:[NSURL URLWithString:data[@"productmainImage"]]];
            cell.shopName.text = data[@"productname"];
            cell.price.text = data[@"productprice"];//productprice
            self.priceStr = data[@"productprice"];
        }
     
        [cell.num removeFromSuperview];
        return cell;
    }
    if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tWcellin"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tWcellin"];
            cell.selectionStyle = UITableViewCellAccessoryNone;

            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 5, 30, 30)];
            lab.tag = 8;
            lab.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:lab];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(SCREEN_WIDTH - 90, 5, 30, 30);
            [btn setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(bian:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 5;
            [cell addSubview:btn];
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(SCREEN_WIDTH - 30, 5, 30, 30);
            [btn1 setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(bian:) forControlEvents:UIControlEventTouchUpInside];
            btn1.tag = 6;
            [cell addSubview:btn1];
            
        }
        UILabel *lab = (UILabel *)[cell viewWithTag:8];
        lab.text = [NSString stringWithFormat:@"%d",a];
        cell.textLabel.text = @"数量";
        return cell;
    }
    if (indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celTslOnT"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celTslOnT"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            fieldYan = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 80)];
            fieldYan.placeholder = @"与商家留言;在这里可以输入商品的规格,或你得特殊需求";
            fieldYan.delegate =self;
            [cell addSubview:fieldYan];
            
            
        }
        
        return cell;
    }
    if (indexPath.row == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellT"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellT"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            
            numLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -10, 50)];
            numLab.textColor = UIRED;
            numLab.textAlignment = NSTextAlignmentRight;
            [cell addSubview:numLab];
        }
        float b = a *[self.priceStr floatValue];
        NSLog(@"%@",self.priceStr);
        if ([data[@"isspecialPrice"] isEqualToString:@"N"]) {
            numLab.text = [NSString stringWithFormat:@"%d件商品,共%@龙点币",a,[[GlobalCenter sharedInstance] decimalwithfloatV:b]];

        }
        else
        {
            numLab.text = [NSString stringWithFormat:@"%d件商品,共%@元",a,[[GlobalCenter sharedInstance] decimalwithfloatV:b]];

        }
        price = [NSString stringWithFormat:@"%@",[[GlobalCenter sharedInstance] decimalwithfloatV:b]];
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DetailedViewController *dvc = [[DetailedViewController alloc] init];
        
        [self.navigationController pushViewController:dvc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 40;
    }
    if (indexPath.row == 1) {
        return 90  ;
    }
    if (indexPath.row == 2) {
        return 40;
    }
    if (indexPath.row == 3) {
        return 80;
    }
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
-(void)bian:(UIButton *)button
{
    if (button.tag == 5) {
        if (a > 1) {
            a --;
            [table reloadData];
        }
        else
        {
            return;
        }
    }
    if (button.tag == 6)
    {
        a++;
        [table reloadData];
        
    }
}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([PRESALE isEqualToString:key] )
    {
        data = [notify userInfo][PRESALE];
//        NSLog(@"%@",successDic);
        [table reloadData];

    }
    if ([PREPARETOPAY isEqualToString:key]) {
        NSDictionary *successDic = [notify userInfo][PREPARETOPAY];
        NSLog(@"%@",successDic);
        PayViewController *pvc = [[PayViewController alloc] init];
        pvc.saleId = successDic[@"code"];
        pvc.numText = price;
        pvc.typeOn = self.onType;
        pvc.buyAmount = [NSString stringWithFormat:@"%d",a];
        [self.navigationController pushViewController:pvc animated:YES];
    }
    
    
}
- (void)failure:(NSNotification *)notify
{
    [self showAlertWithPoint:1
                        text:[notify userInfo][FAILURE]
                       color:UIPINK];
}
-(void)commentTableViewTouchInSide
{
    [fieldYan resignFirstResponder];
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
