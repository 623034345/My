//
//  PayViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/2.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"支付";
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
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];
    self.view.backgroundColor = UIWHITE;
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self addBackBtnWithImageNormal:@"back" fuction:@selector(backBtn)];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 44;
        }
        if (indexPath.row == 1) {
            return 96;
        }
        if (indexPath.row == 2) {
            return 44;
        }
    }
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == -1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Onecell"];
            if (!cell ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Onecell"];
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
                img.image = [UIImage imageNamed:@"Hair"];
                [cell addSubview:img];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 200, 30)];
                lab.tag = 30;
                [cell addSubview:lab];
            }
            UILabel *lab = (UILabel *)[cell viewWithTag:30];
            lab.text = @"美人驾到";
            return cell;
        }
        if (indexPath.row == -1) {
            PayOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayOneTableViewCell"];
            if (!cell ) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PayOneTableViewCell" owner:self options:nil] lastObject];
            }
            cell.img.image = [UIImage imageNamed:@"shiyan"];
            
            
            return cell;
        }
        if (indexPath.row == 0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTwo"];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTwo"];
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH/2-10, 30)];
                    lab.textColor = UIBLACK;
                    lab.textAlignment = NSTextAlignmentLeft;
                    lab.font = [UIFont systemFontOfSize:15.0];
                    lab.text = @"请选择支付方式";
                    lab.tag = 4;
                    [cell addSubview:lab];
                    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 5, SCREEN_WIDTH/2-10, 30)];
                    lab1.textColor = UICOLOR_HEX(0xea4b35);
                    lab1.textAlignment = NSTextAlignmentRight;
                    lab1.font = [UIFont systemFontOfSize:15.0];
                    lab1.tag = 5;
                    [cell addSubview:lab1];
                    
                }
                UILabel *lab = (UILabel *)[cell viewWithTag:5];
                if (!NULL_STR(self.cardName)) {
                    lab.text = [NSString stringWithFormat:@"%@￥:%@",self.cardName,self.numText];

                }
                else
                {
                    lab.text = [NSString stringWithFormat:@"￥:%@",self.numText];

                }
                return cell;
        }
    }
    PayBTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"PayBTableViewCell "];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PayBTableViewCell" owner:self options:nil] lastObject];
    }
    if (indexPath.section == 1) {
      
        cell.img.image = [UIImage imageNamed:@"wx"];
        cell.name.text = @"微信";
        cell.lab.text = @"推荐";
//        return cell;
    }
    if (indexPath.section == 2) {
        cell.img.image = [UIImage imageNamed:@"zfb"];
        cell.name.text = @"支付宝";
    }
    if (indexPath.section == 3) {
        cell.img.image = [UIImage imageNamed:@"wy"];
        cell.name.text = @"银联支付";
    }

    if (indexPath.section == 4) {
        cell.img.image = [UIImage imageNamed:@"ye"];
        cell.name.text = @"余额支付";
    }
    if (indexPath.section == 5) {
        cell.img.image = [UIImage imageNamed:@"mq"];
        cell.name.text = @"现金支付";
    }
    
    return cell;
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
   
    
}

- (void)failure:(NSNotification *)notify
{
        [self dismissIndicatorView];
        [self showAlertWithPoint:0
                            text:[notify userInfo][FAILURE]
                           color:UIPINK];
    
}
-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///微信支付
    if (indexPath.section == 1) {
        [self weChatPay];
    }
    //支付宝支付
    if (indexPath.section ==2)
    {
        
//        AliPayViewController *avc = [[AliPayViewController alloc] init];
//        [self.navigationController pushViewController:avc animated:YES];
        [self apliPay];

      
    }
    ///银联支付
    if (indexPath.section == 3) {
        NSString *tn = @"543194615734916437913";
        //当获得的tn不为空时，调用支付接口
        if (tn != nil && tn.length > 0)
        {
            [[UPPaymentControl defaultControl]
             startPay:tn
             fromScheme:@"DragonPoints.DragonPoints"
             mode:kMode_Development
             viewController:self]; 
        }

    }
    //余额支付
    if (indexPath.section == 4)
    {
        //商店买单
        if (_typeOn == 3)
        {
            BalancePayViewController *bvc = [[BalancePayViewController alloc] init];
            bvc.priceNum = self.numText;
            bvc.number = 2;
            bvc.onType = 3;
            [self.navigationController pushViewController:bvc animated:YES];

        }
        //预售
        if (_typeOn == 1)
        {
            BalancePayViewController *bvc = [[BalancePayViewController alloc] init];
            bvc.saleId = self.saleId;
            bvc.number = 2;
            bvc.onType = 1;
            bvc.buyAmount = self.buyAmount;

            [self.navigationController pushViewController:bvc animated:YES];
        }
        //立即购买
        if (_typeOn == 2)
        {
            BalancePayViewController *bvc = [[BalancePayViewController alloc] init];
            bvc.saleId = self.saleId;

            bvc.number = 2;
            bvc.onType = 2;
            [self.navigationController pushViewController:bvc animated:YES];
        }
    }
    //现金支付
    if (indexPath.section == 5) {
        CashpaymentsViewController *cvc = [[CashpaymentsViewController alloc] init];
        
        [self.navigationController pushViewController:cvc animated:YES];
    }
}
-(void)weChatPay
{
    //微信测试接口,集成时换位自己的后台接口.
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                NSLog(@"%@",retcode);
                NSLog(@"%@",stamp);
                //NSMutableDictionary *signDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:dict[@""], nil]
                
                //调起微信支付
                PayReq* req = [[PayReq alloc] init];
                req.partnerId = [dict objectForKey:@"partnerid"];
                req.prepayId = [dict objectForKey:@"prepayid"];
                req.nonceStr = [dict objectForKey:@"noncestr"];
                req.timeStamp = stamp.intValue;
                req.package = [dict objectForKey:@"package"];
                req.sign = [dict objectForKey:@"sign"];// @"47B7A45B8DB4E7BB88B8F9F4E268CB5D"; //[dict objectForKey:@"sign"];
                BOOL result = [WXApi sendReq:req];
                
                NSLog(@"-=-=-=-=- %d", result);
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            }else{
                NSLog(@"%@",[dict objectForKey:@"retmsg"]) ;
            }
        }else{
            NSLog(@"服务器返回错误，未获取到json对象") ;

        }
    }else{
        NSLog(@"服务器返回错误") ;
    }
}

-(void)apliPay
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"14524154564";
    NSString *seller = @"456456415214";
    NSString *privateKey = @"154213245121234534";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = @"131312"; //订单ID（由商家自行制定）
    order.subject = @"这是一个商品"; //商品标题
    order.body = @"这货是一个坑爹货"; //商品描述
    order.totalFee = @"0.1"; //商品价格
    order.notifyURL =  @"DragonPoints.DragonPoints"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"成功了吗?reslut = %@",resultDic);
        }];
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
