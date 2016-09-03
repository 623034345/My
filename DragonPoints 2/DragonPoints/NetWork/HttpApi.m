//
//  HttpApi.m
//  ForNowIosSupper
//
//  Created by Thomas on 15-6-21.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import "HttpApi.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>
#import "JSONAutoSerializer.h"

@implementation HttpApi

//初始化
- (id)init
{
    if (self = [super init])
    {
        //AFNetworking封装
        center = [[HttpCenter alloc] init];
        
        //apiDic
        apiDic = [[NSMutableDictionary alloc] init];
        
        /*
         *User
         */
        [apiDic setObject:@"%@/app/user/login?userName=%@&password=%@"
                   forKey:LOGIN];
        
        
        
        
    }
    return self;
}

//上抛成功数据
- (void)postSuccess:(id)successStr
                key:(NSString *)keyStr
{
    if (successStr)
    {
        [NOTIFICATION_CENTER postNotificationName:SUCCESS
                                           object:self
                                         userInfo:[NSDictionary dictionaryWithObject:successStr
                                                                              forKey:keyStr]];
    }
    else
    {
        [NOTIFICATION_CENTER postNotificationName:FAILURE
                                           object:self
                                         userInfo:[NSDictionary dictionaryWithObject:@"暂无符合条件数据"
                                                                              forKey:FAILURE]];
    }
}

//上抛失败数据
- (void)postFailure:(NSString *)failureStr
{
    [NOTIFICATION_CENTER postNotificationName:FAILURE
                                       object:self
                                     userInfo:[NSDictionary dictionaryWithObject:failureStr
                                                                          forKey:FAILURE]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark- 登录注册
/*
 *User
 */
#pragma mark//登录
- (void)loginWithUserName:(NSString *)userNameStr
                 password:(NSString *)passwordStr
{
    //http://192.168.1.125:8080/Web1/test1
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/servlet/LoginHandle",SERVER_NAME];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:userNameStr
                          forKey:@"tele"];
    [parametersDic setObject:passwordStr
                      forKey:@"pwd"];

        [center post:urlStr
          parameters:parametersDic
             success:^(NSString *successStr)
        {
            [self postSuccess:successStr
                          key:LOGIN];
    
        }
             failure:^(NSString *failureStr)
        {
            [self postFailure:failureStr];
        }];

}
#pragma mark//注册
-(void)registrationgWithtele:(NSString *)teleStr
                    passWord:(NSString *)passWord
             recommenderTele:(NSString *)recommenderTeleStr
                    regionId:(NSString *)regionIdStr
                     smsCode:(NSString *)smsCodeStr
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/servlet/RegisterHandle",SERVER_NAME];

    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:teleStr
                      forKey:@"registerTele"];
    [parametersDic setObject:passWord
                      forKey:@"registerPassword"];
    [parametersDic setObject:recommenderTeleStr
                      forKey:@"recommenderTele"];
    [parametersDic setObject:regionIdStr
                      forKey:@"regionId"];
    [parametersDic setObject:smsCodeStr
                      forKey:@"smsCode"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:RIGISTRATION];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//忘记密码
-(void)forGetWithregTele:(NSString *)regTele
                     Pwd:(NSString *)Pwd
                  smsStr:(NSString *)smsStr
{
    //ShoppingMall/servlet/FindNewPassword
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/member/FindNewPassword",SERVER_NAME ];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:regTele
                      forKey:@"regTele"];
    [parametersDic setObject:Pwd
                      forKey:@"newPwd"];
    [parametersDic setObject:smsStr
                      forKey:@"smsCode"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:FORGET];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];

}
#pragma mark//获取验证码
-(void)sendSmsWithtele:(NSString *)tele
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/servlet/SendSms",SERVER_NAME];
   
 
//    [center get:urlStr
//     parameters:nil
//        success:^(NSString *successStr)
//     {
//         [self postSuccess:successStr
//                       key:SENDSMS];
//     }
//        failure:^(NSString *failureStr)
//     {
//         [self postFailure:failureStr];
//     }];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
//    NSLog(@"%@",tele);
    [parametersDic setObject:tele
                      forKey:@"tele"];

    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:SENDSMS];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#pragma mark 首页
#pragma mark//首页
-(void)homeGetdataWithCity:(NSString *)cityName
{
  //  http://192.168.1.125:8080/ShoppingMall/servlet/FirstPageRecommendMobile
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/FirstPageRecommendMobile?cityName=%@",SERVER_NAME,cityName];
    [center get:urlStr
          parameters:nil
             success:^(NSString *successStr)
          {
              [self postSuccess:successStr
                            key:HOME];
          }
             failure:^(NSString *failureStr)
          {
              [self postFailure:failureStr];
          }];
}
#pragma mark//更多分类
-(void)moreGetdata
{
   // http://192.168.1.122:8080/ShoppingMall/servlet/CategoryAllOfflineMobile
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/servlet/CategoryAllOfflineMobile",SERVER_NAME];
    [center get:urlStr
     parameters:nil
        success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:MORE];
     }
        failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//获取分类地区数据
-(void)classify
{
    //ShoppingMall/servlet/Register   ShoppingMall/servlet/RegionAllMobile
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/servlet/Register",SERVER_NAME];
    [center get:urlStr
     parameters:nil
        success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:CLASSL];
     }
        failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -  商家
#pragma mark//商家列表
-(void)shopGetdataWithregionId:(NSString *)regionId
               smallCategoryId:(NSString *)smallCategoryId
                     orderType:(NSString *)orderType
                           lng:(NSString *)lng
                           lat:(NSString *)lat
{
    //http://192.168.1.122:8080/ShoppingMall/servlet/OneShopperOffline?name
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/ShopperFirstPageForMobile?regionId=%@&categoryId=%@&orderType=%@&customerJingdu=%@&customerWeidu=%@",SERVER_NAME,regionId,smallCategoryId,orderType,lng,lat];
//    NSLog(@"%@",urlStr);
    [center get:urlStr
     parameters:nil
        success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:SHOPS];
     }
        failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//线下商家店铺
-(void)shopDailGetdatashopperId:(NSString *)shopperId
{
    //ShoppingMall/servlet/OneShopperOffline
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/servlet/OneShopperOffline?shopperId=%@",SERVER_NAME,shopperId];
    [center get:urlStr
     parameters:nil
        success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:SHOPSDAIL];
     }
        failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//线下商品详情
-(void)offlineShopsDailWithproductId:(NSString *)productId
{
    //ShoppingMall/servlet/OneProductOffline
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/servlet/OneProductOffline?productId=%@",SERVER_NAME,productId];
//    NSLog(@"%@",urlStr);
    [center get:urlStr
     parameters:nil
        success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:OFSHOPS];
     }
        failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//评价列表
-(void)evaluateWithproductId:(NSString *)productId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/servlet/AllComment?productId=%@",SERVER_NAME,productId];
    [center get:urlStr
     parameters:nil
        success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:EVALUATE];
     }
        failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];

}
#pragma mark//线下预售云币界面
-(void)preSaleWithproductId:(NSString *)productId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/buyOffline/GetProductOfflineInfo",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //    NSLog(@"%@",tele);
    //    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
    //                      forKey:@"memberId"];
    [parametersDic setObject:productId
                      forKey:@"productId"];

    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:PRESALE];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//云币支付
-(void)buyOfflineWithproductId:(NSString *)productId
                     buyAmount:(NSString *)buyAmount
                  leavemessage:(NSString *)leavemessage
                transactionPwd:(NSString *)transactionPwd
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/buyOffline/PayUseCoinHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
        [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                          forKey:@"buyerMemberId"];
    [parametersDic setObject:productId
                      forKey:@"productId"];
    [parametersDic setObject:buyAmount
                      forKey:@"buyAmount"];
    [parametersDic setObject:leavemessage
                      forKey:@"leavemessage"];
    [parametersDic setObject:transactionPwd
                      forKey:@"transactionPwd"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:PAYCOIN];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//预售云币支付成功
-(void)payCoinSuccessWithsaleId:(NSString *)saleId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/buyOffline/SeeProductAfterPayCoinSuccess",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:saleId
                      forKey:@"saleId"];

    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:PAYCOINSUCCESS];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//去支付生成订单
-(void)PrepareToPayWillToThirdpaybuyerMemberId:(NSString *)buyerMemberId
                                     productId:(NSString *)productId
                                  buyAmountStr:(NSString *)buyAmountStr
                                  leavemessage:(NSString *)leavemessage
                                    ifConsumed:(NSString *)ifConsumed
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/buyOffline/PrepareToPayWillToThirdpay",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:buyerMemberId
                      forKey:@"buyerMemberId"];
    
    [parametersDic setObject:productId
                      forKey:@"productId"];
    [parametersDic setObject:buyAmountStr
                      forKey:@"buyAmount"];
    [parametersDic setObject:leavemessage
                      forKey:@"leavemessage"];
    [parametersDic setObject:ifConsumed
                      forKey:@"ifConsumed"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:PREPARETOPAY];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//买单余额支付
-(void)BuyNowUseBalanceWithmoneyPay:(NSString *)moneyPay
                                psw:(NSString *)psw
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/buyOffline/BuyNowUseBalanceHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:moneyPay
                      forKey:@"moneyPay"];
    [parametersDic setObject:psw
                      forKey:@"transactionPwd"];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:BUYNOWUSE];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//商品余额支付
-(void)buyOfflinePayInBalanceHandlesaleId:(NSString *)saleId
                           transactionPwd:(NSString *)transactionPwd
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/buyOffline/PayInBalanceHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:saleId
                      forKey:@"saleId"];
    [parametersDic setObject:transactionPwd
                      forKey:@"transactionPwd"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:BUYINUSE];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark- 我的
-(void)MyMainInfo
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/GetMyMainInfo",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:MYMAIN];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 用户提交评价
-(void)CustomerCommentHandleWithproductId:(NSString *)productId
                                giveScore:(NSString *)giveScore
                               theComment:(NSString *)theComment
                            manyimageUrls:(NSString *)manyimageUrls
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/buyOffline/CustomerCommentHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:productId
                      forKey:@"productId"];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [parametersDic setObject:giveScore
                      forKey:@"giveScore"];
    [parametersDic setObject:theComment
                      forKey:@"theComment"];
    [parametersDic setObject:manyimageUrls
                      forKey:@"manyimageUrls"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:CUSTOMERCOMMENT];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 消费分红
-(void)MySpendingBonusInfo
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/GetMySpendingBonusInfo",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:SPENDING];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 修改昵称

-(void)UpdateNickNameWithNickName:(NSString *)NickName
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/UpdateNickNameHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [parametersDic setObject:NickName
                      forKey:@"newNickName"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:UPNICKNAME];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 云豆提现确认按钮
-(void)WithdrawWithwithdrawNum:(NSString *)withdrawNum
                   hasBankCard:(NSString *)hasBankCard
                   hasZhifubao:(NSString *)hasZhifubao
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/BeanWithdrawHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:withdrawNum
                      forKey:@"withdrawNum"];
    [parametersDic setObject:hasBankCard
                      forKey:@"hasBankCard"];
    [parametersDic setObject:hasZhifubao
                      forKey:@"hasZhifubao"];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:DRAWBEA];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];

}
#pragma mark 云豆提现确认界面
-(void)BeanWithdrawWithwithdrawNum:(NSString *)withdrawNum
                       hasBankCard:(NSString *)hasBankCard
                       hasZhifubao:(NSString *)hasZhifubao
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/BeanWithdrawConfirm",SERVER_NAME];

    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:withdrawNum
                      forKey:@"withdrawNum"];
    [parametersDic setObject:hasBankCard
                      forKey:@"hasBankCard"];
    [parametersDic setObject:hasZhifubao
                      forKey:@"hasZhifubao"];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:DRAWBEAN];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];

}
#pragma mark 我的财产
-(void)MyAssets
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/MyAssetsInfo",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];

    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:ASSETS];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 公益互助
-(void)MutualFundInfo
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/GetMutualFundInfo",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:MUTUAL];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 绑定支付宝
-(void)BindZhifubaoWithzhifubaoCode:(NSString *)zhifubaoCode
                    zhifubaoUseName:(NSString *)zhifubaoUseName
                       zhifubaoType:(NSString *)zhifubaoType
                            msmCode:(NSString *)msmCode
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/BindZhifubaoHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [parametersDic setObject:zhifubaoCode
                      forKey:@"zhifubaoCode"];
    [parametersDic setObject:zhifubaoUseName
                      forKey:@"zhifubaoUseName"];
    [parametersDic setObject:zhifubaoType
                      forKey:@"zhifubaoType"];
    [parametersDic setObject:msmCode
                      forKey:@"smsCode"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:ZHIFUBAO];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 绑定银行卡
-(void)BindBankCardWithbankName:(NSString *)bankName
                     bankCardId:(NSString *)bankCardId
                  bankOwnerName:(NSString *)bankOwnerName
                       bankOpen:(NSString *)bankOpen
                        msmCode:(NSString *)msmCode
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/BindBankCardHandle",SERVER_NAME];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [parametersDic setObject:bankName
                      forKey:@"bankName"];
    [parametersDic setObject:bankCardId
                      forKey:@"bankCardId"];
    [parametersDic setObject:bankOwnerName
                      forKey:@"bankOwnerName"];
    [parametersDic setObject:bankOpen
                      forKey:@"bankOpen"];
    [parametersDic setObject:msmCode
                      forKey:@"smsCode"];

    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:BANKCARD];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 修改绑定银行卡

-(void)ModifyBindBankCardWithbankName:(NSString *)bankName
                           bankCardId:(NSString *)bankCardId
                        bankOwnerName:(NSString *)bankOwnerName
                             bankOpen:(NSString *)bankOpen
                              msmCode:(NSString *)msmCode
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/UpdateBankCardHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [parametersDic setObject:bankName
                      forKey:@"bankName"];
    [parametersDic setObject:bankCardId
                      forKey:@"bankCardId"];
    [parametersDic setObject:bankOwnerName
                      forKey:@"bankOwnerName"];
    [parametersDic setObject:bankOpen
                      forKey:@"bankOpen"];
    [parametersDic setObject:msmCode
                      forKey:@"smsCode"];
//    NSLog(@"%@",parametersDic);

    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:BANKCARD];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 修改绑定支付宝
-(void)ModifyBindZhifubaoWithzhifubaoCode:(NSString *)zhifubaoCode
                          zhifubaoUseName:(NSString *)zhifubaoUseName
                             zhifubaoType:(NSString *)zhifubaoType
                                  msmCode:(NSString *)msmCode
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/UpdateZhifubaoHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [parametersDic setObject:zhifubaoCode
                      forKey:@"zhifubaoCode"];
    [parametersDic setObject:zhifubaoUseName
                      forKey:@"zhifubaoUseName"];
    [parametersDic setObject:zhifubaoType
                      forKey:@"zhifubaoType"];
    [parametersDic setObject:msmCode
                      forKey:@"smsCode"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:ZHIFUBAO];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark商家云币订单扫描
-(void)coinToDailWithSaleId:(NSString *)saleId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/buyOffline/AfterConsumeCoinProductHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:saleId
                      forKey:@"saleId"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:COINTODAIL];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//云豆转余额
-(void)beanWithNum:(NSString *)beanNum
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/BeanToBalance",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //    NSLog(@"%@",tele);
    //    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
    //                      forKey:@"memberId"];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [parametersDic setObject:beanNum
                      forKey:@"beanNum"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:BALANCE];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//我的余额

-(void)MyBalanceInSystemWithtype:(NSString *)type
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/MyBalanceInSystem",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [parametersDic setObject:type
                      forKey:@"type"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:SYSTEM];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//我的云豆
-(void)myBeanWithtype:(NSString *)type
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/MyBeanDetail",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //    NSLog(@"%@",tele);
    //    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
    //                      forKey:@"memberId"];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [parametersDic setObject:type
                      forKey:@"type"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:BEAND];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//我得云币
-(void)myCoinDetailWithtype:(NSString *)type
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/MyCoinDetail",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //    NSLog(@"%@",tele);
//    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
//                      forKey:@"memberId"];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    [parametersDic setObject:type
                      forKey:@"type"];
        [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:COINDETAIL];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//设置交易密码
-(void)tradePowsWithRegtele:(NSString *)regTele
                   transPwd:(NSString *)transPwd
                    smsCode:(NSString *)smsCode
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/SetTransactionPwdHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //    NSLog(@"%@",tele);
    [parametersDic setObject:regTele
                      forKey:@"regTele"];
    [parametersDic setObject:transPwd
                      forKey:@"transPwd"];
    [parametersDic setObject:smsCode
                      forKey:@"smsCode"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:TRADEP];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//修改登录密码
-(void)changeThePasswordWithOldPwd:(NSString *)oldPwd
                           lnewPwd:(NSString *)lnewPwd
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/UpdateRegisterPwd",SERVER_NAME];

    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //    NSLog(@"%@",tele);
    [parametersDic setObject:oldPwd
                      forKey:@"oldPwd"];
    [parametersDic setObject:lnewPwd
                      forKey:@"newPwd"];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:CHANGEP];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//我的等级

-(void)MyShownGrade
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/my/MyShownGrade",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:GRADE];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark- 商家入驻
-(void)OpenShopperWithshopperName:(NSString *)shopperName
                  smallCategoryId:(NSString *)smallCategoryId
                           mobile:(NSString *)mobile
                       fixedphone:(NSString *)fixedphone
                         discount:(NSString *)discount
                         regionId:(NSString *)regionId
                   shopperAddress:(NSString *)shopperAddress
                 busilicenseImage:(NSString *)busilicenseImage
             legalmanCardForImage:(NSString *)legalmanCardForImage
            legalmanCardBackImage:(NSString *)legalmanCardBackImage
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/shopperInMobile/OpenShopperHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //    NSLog(@"%@",tele);
    [parametersDic setObject:shopperName
                      forKey:@"shopperName"];
    [parametersDic setObject:smallCategoryId
                      forKey:@"smallCategoryId"];
    [parametersDic setObject:mobile
                      forKey:@"mobile"];
    [parametersDic setObject:fixedphone
                      forKey:@"fixedphone"];
    [parametersDic setObject:discount
                      forKey:@"discount"];
    [parametersDic setObject:regionId
                      forKey:@"regionId"];
    [parametersDic setObject:shopperAddress
                      forKey:@"shopperAddress"];
    [parametersDic setObject:busilicenseImage
                      forKey:@"busilicenseImage"];
    [parametersDic setObject:legalmanCardForImage
                      forKey:@"legalmanCardForImage"];
    [parametersDic setObject:legalmanCardBackImage
                      forKey:@"legalmanCardBackImage"];
    [parametersDic setObject:[USER_DEFAULT objectForKey:USERID]
                      forKey:@"memberId"];
    
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:OPENSHOPPER];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 预售订单扫码验证
-(void)MobileWithredeemCode:(NSString *)redeemCode
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/shopperInMobile/ScanRedeemCode",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:redeemCode
                      forKey:@"redeemCode"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:SCANREDEEM];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 商店订单
-(void)GetOrderListWithType:(NSString *)type
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/shopperInMobile/GetOrderList",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[USER_DEFAULT objectForKey:SHOPPERID]
                      forKey:@"shopperId"];
    [parametersDic setObject:type
                      forKey:@"type"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:SHOPORDERLIST];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 兑换商品商家确认订单

-(void)ScanRedeemCodeWithSaleId:(NSString *)saleId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/buyOffline/AfterConsumeCoinProductHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:saleId
                      forKey:@"saleId"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:AFTERCONSUME1];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 特价商品商家确认订单

-(void)AfterConsumeWithSaleId:(NSString *)saleId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/shopperInMobile/AfterConsumeHandle",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:saleId
                      forKey:@"saleId"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:AFTERCONSUME];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 商家或顾客取消订单
-(void)CancelOneOrderWithSaleId:(NSString *)saleId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/shopperInMobile/CancelOneOrder",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:saleId
                      forKey:@"saleId"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:CANCELORDER];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark 我的商店
-(void)ShopperMain
{
    NSString *urlStr = [NSString stringWithFormat:@"%@ShoppingMall/shopperInMobile/GetShopperMainFrmInfo",SERVER_NAME];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //    NSLog(@"%@",tele);
    [parametersDic setObject:[USER_DEFAULT objectForKey:SHOPPERID]
                      forKey:@"shopperId"];
    [center post:urlStr
      parameters:parametersDic
         success:^(NSString *successStr)
     {
         [self postSuccess:successStr
                       key:SHOPPERMINE];
         
     }
         failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
     }];
}
#pragma mark//上传图片数组
-(void)upHeadImageArr:(NSMutableArray *)data
{
    NSString *urlStr = [NSString stringWithFormat:@"dsadsadsa"];
    [center postImgsArrWithUrl:urlStr imageArr:data
                       success:^(id successObj)
    {
        [self postSuccess:successObj
                      key:IMAGEARR];
    }
     failure:^(NSString *failureStr)
    {
        [self postFailure:failureStr];

    }];
}
-(void)upHeadImage:(UIImage *)data
            number:(NSString *)number
            urlStr:(NSString *)urlStr
{
    [center postImg:urlStr parameters:data
             number:number
            success:^(id successObj)
     {
         [self postSuccess:successObj
                       key:IMAGEARR];
     }
            failure:^(NSString *failureStr)
     {
         [self postFailure:failureStr];
         
     }];
}


#pragma mark//取消请求
- (void)cancel
{
    [center cancel];
}

@end
