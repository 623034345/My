//
//  HttpHelper.m
//  ForNowIosSupper
//
//  Created by fornowIOS on 15/6/4.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import "HttpHelper.h"

@implementation HttpHelper

static HttpHelper *instance = nil;

//单例
+ (HttpHelper *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        instance = [[self alloc] init];
    });
    return instance;
}

//初始化
- (id)init
{
    if (self = [super init])
    {
        //接口封装
        api = [[HttpApi alloc] init];
    }
    return self;
}

//添加观察者
- (void)addListener:(id)obj
            success:(SEL)successFunction
            failure:(SEL)failureFunction
{
    
    [NOTIFICATION_CENTER addObserver:obj
                            selector:successFunction
                                name:SUCCESS
                              object:api];
    [NOTIFICATION_CENTER addObserver:obj
                            selector:failureFunction
                                name:FAILURE
                              object:api];
}

- (void)removeListener:(id)obj
{
    [NOTIFICATION_CENTER removeObserver:obj
                                   name:SUCCESS
                                 object:api];
    [NOTIFICATION_CENTER removeObserver:obj
                                   name:FAILURE
                                 object:api];
}
- (void)loginWithUserName:(NSString *)userNameStr
                 password:(NSString *)passwordStr
{
    [api loginWithUserName:userNameStr password:passwordStr];
}
#pragma mark 登录注册
//注册
-(void)registrationgWithtele:(NSString *)teleStr
                    passWord:(NSString *)passWord
             recommenderTele:(NSString *)recommenderTeleStr
                    regionId:(NSString *)regionIdStr
                     smsCode:(NSString *)smsCodeStr
{
    [api registrationgWithtele:teleStr
                      passWord:passWord
               recommenderTele:recommenderTeleStr
                      regionId:regionIdStr
                       smsCode:smsCodeStr];
}
//忘记密码
-(void)forGetWithregTele:(NSString *)regTele
                     Pwd:(NSString *)Pwd
                  smsStr:(NSString *)smsStr
{
    [api forGetWithregTele:regTele
                       Pwd:Pwd
                    smsStr:smsStr];
}
//获取验证码
-(void)sendSmsWithtele:(NSString *)tele
{
    [api sendSmsWithtele:tele];
}
#pragma mark 首页
//首页
-(void)homeGetdataWithCity:(NSString *)cityName
{
    [api homeGetdataWithCity:cityName];
}
//更多分类
-(void)moreGetdata
{
    [api moreGetdata];
}
//乡镇列表
-(void)classify
{
    [api classify];
}
#pragma mark 商家
//商家
-(void)shopGetdataWithregionId:(NSString *)regionId
               smallCategoryId:(NSString *)smallCategoryId
                     orderType:(NSString *)orderType
                           lng:(NSString *)lng
                           lat:(NSString *)lat{
    [api shopGetdataWithregionId:regionId
                 smallCategoryId:smallCategoryId
                       orderType:orderType
                             lng:lng
                             lat:lat];
}
//线下店铺详情
-(void)shopDailGetdatashopperId:(NSString *)shopperId
{
    [api shopDailGetdatashopperId:shopperId];
}
//线下商品详情
-(void)offlineShopsDailWithproductId:(NSString *)productId
{
    [api offlineShopsDailWithproductId:productId];
}
//评价列表
-(void)evaluateWithproductId:(NSString *)productId
{
    [api evaluateWithproductId:productId];
}
//线下预售云币界面
-(void)preSaleWithproductId:(NSString *)productId
{
    [api preSaleWithproductId:productId];
}
//云币支付
-(void)buyOfflineWithproductId:(NSString *)productId
                     buyAmount:(NSString *)buyAmount
                  leavemessage:(NSString *)leavemessage
                transactionPwd:(NSString *)transactionPwd
{
    [api buyOfflineWithproductId:productId
                       buyAmount:buyAmount
                    leavemessage:leavemessage
                  transactionPwd:transactionPwd];
}
//预售云币支付成功
-(void)payCoinSuccessWithsaleId:(NSString *)saleId
{
    [api payCoinSuccessWithsaleId:saleId];
}
//买单余额支付
-(void)BuyNowUseBalanceWithmoneyPay:(NSString *)moneyPay psw:(NSString *)psw
{
    [api BuyNowUseBalanceWithmoneyPay:moneyPay
                                  psw:psw];
}
//确定商品余额支付
-(void)buyOfflinePayInBalanceHandlesaleId:(NSString *)saleId
                           transactionPwd:(NSString *)transactionPwd
{
    [api buyOfflinePayInBalanceHandlesaleId:saleId
                             transactionPwd:transactionPwd];
}
//去支付生成订单
-(void)PrepareToPayWillToThirdpaybuyerMemberId:(NSString *)buyerMemberId
                                     productId:(NSString *)productId
                                  buyAmountStr:(NSString *)buyAmountStr
                                  leavemessage:(NSString *)leavemessage
                                    ifConsumed:(NSString *)ifConsumed
{
    [api PrepareToPayWillToThirdpaybuyerMemberId:buyerMemberId
                                       productId:productId
                                    buyAmountStr:buyAmountStr
                                    leavemessage:leavemessage
                                      ifConsumed:ifConsumed];
}
#pragma mark 我的
-(void)MyMainInfo
{
    [api MyMainInfo];
}
//用户提交评论
-(void)CustomerCommentHandleWithproductId:(NSString *)productId
                                giveScore:(NSString *)giveScore
                               theComment:(NSString *)theComment
                            manyimageUrls:(NSString *)manyimageUrls
{
    [api CustomerCommentHandleWithproductId:productId
                                  giveScore:giveScore
                                 theComment:theComment
                              manyimageUrls:manyimageUrls];
}
//我的等级
-(void)MyShownGrade
{
    [api MyShownGrade];
}
//消费分红
-(void)MySpendingBonusInfo
{
    [api MySpendingBonusInfo];
}
//修改昵称
-(void)UpdateNickNameWithNickName:(NSString *)NickName
{
    [api UpdateNickNameWithNickName:NickName];
}
//云豆提现确认按钮

-(void)WithdrawWithwithdrawNum:(NSString *)withdrawNum
                   hasBankCard:(NSString *)hasBankCard
                   hasZhifubao:(NSString *)hasZhifubao
{
    [api WithdrawWithwithdrawNum:withdrawNum
                         hasBankCard:hasBankCard
                            hasZhifubao:hasZhifubao];
}
//云豆提现确认界面
-(void)BeanWithdrawWithwithdrawNum:(NSString *)withdrawNum
                       hasBankCard:(NSString *)hasBankCard
                       hasZhifubao:(NSString *)hasZhifubao
{
    [api BeanWithdrawWithwithdrawNum:withdrawNum
                         hasBankCard:hasBankCard
                         hasZhifubao:hasZhifubao];
}
//我的财产
-(void)MyAssets
{
    [api MyAssets];
}
//公益互助
-(void)MutualFundInfo
{
    [api MutualFundInfo];
}
//绑定支付宝
-(void)BindZhifubaoWithzhifubaoCode:(NSString *)zhifubaoCode
                    zhifubaoUseName:(NSString *)zhifubaoUseName
                       zhifubaoType:(NSString *)zhifubaoType
                            msmCode:(NSString *)msmCode
{
    [api BindZhifubaoWithzhifubaoCode:zhifubaoCode
                      zhifubaoUseName:zhifubaoUseName
                         zhifubaoType:zhifubaoType
                              msmCode:msmCode];
}
//绑定银行卡
-(void)BindBankCardWithbankName:(NSString *)bankName
                     bankCardId:(NSString *)bankCardId
                  bankOwnerName:(NSString *)bankOwnerName
                       bankOpen:(NSString *)bankOpen
                        msmCode:(NSString *)msmCode
{
    [api BindBankCardWithbankName:bankName
                       bankCardId:bankCardId
                    bankOwnerName:bankOwnerName
                         bankOpen:bankOpen
                          msmCode:msmCode];
}
// 修改绑定银行卡
-(void)ModifyBindBankCardWithbankName:(NSString *)bankName
                           bankCardId:(NSString *)bankCardId
                        bankOwnerName:(NSString *)bankOwnerName
                             bankOpen:(NSString *)bankOpen
                              msmCode:(NSString *)msmCode
{
    [api ModifyBindBankCardWithbankName:bankName
                       bankCardId:bankCardId
                    bankOwnerName:bankOwnerName
                         bankOpen:bankOpen
                          msmCode:msmCode];
}
//修改绑定支付宝

-(void)ModifyBindZhifubaoWithzhifubaoCode:(NSString *)zhifubaoCode
                          zhifubaoUseName:(NSString *)zhifubaoUseName
                             zhifubaoType:(NSString *)zhifubaoType
                                  msmCode:(NSString *)msmCode
{
    [api ModifyBindZhifubaoWithzhifubaoCode:zhifubaoCode
                      zhifubaoUseName:zhifubaoUseName
                         zhifubaoType:zhifubaoType
                              msmCode:msmCode];
}
//商家云币订单扫描
-(void)coinToDailWithSaleId:(NSString *)saleId
{
    [api coinToDailWithSaleId:saleId];
}
//云豆转余额
-(void)beanWithNum:(NSString *)beanNum
{
    [api beanWithNum:beanNum];
}
//我的余额
-(void)MyBalanceInSystemWithtype:(NSString *)type
{
    [api MyBalanceInSystemWithtype:type];
}
//我的云豆
-(void)myBeanWithtype:(NSString *)type
{
    [api myBeanWithtype:type];
}
//我得云币
-(void)myCoinDetailWithtype:(NSString *)type
{
    [api myCoinDetailWithtype:type];
}
//设置交易密码
-(void)tradePowsWithRegtele:(NSString *)regTele
                   transPwd:(NSString *)transPwd
                    smsCode:(NSString *)smsCode
{
    [api tradePowsWithRegtele:regTele
                     transPwd:transPwd
                      smsCode:smsCode];
}
//修改登录密码
-(void)changeThePasswordWithOldPwd:(NSString *)oldPwd
                           lnewPwd:(NSString *)lnewPwd
{
    [api changeThePasswordWithOldPwd:oldPwd
                             lnewPwd:lnewPwd];
}
//上传图片
-(void)upHeadImageArr:(NSMutableArray *)data
{
    [api upHeadImageArr:data];
}
//我的商店
-(void)ShopperMain
{
    [api ShopperMain];
}
//商家入驻
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
    [api OpenShopperWithshopperName:shopperName
                    smallCategoryId:smallCategoryId
                             mobile:mobile
                         fixedphone:fixedphone
                           discount:discount
                           regionId:regionId
                     shopperAddress:shopperAddress
                   busilicenseImage:busilicenseImage
               legalmanCardForImage:legalmanCardForImage
              legalmanCardBackImage:legalmanCardBackImage];
}
//商店订单
-(void)GetOrderListWithType:(NSString *)type
{
    [api GetOrderListWithType:type];
}
//商家或顾客取消订单
-(void)CancelOneOrderWithSaleId:(NSString *)saleId
{
    [api CancelOneOrderWithSaleId:saleId];
}
//商家特价商品确认订单
-(void)AfterConsumeWithSaleId:(NSString *)saleId
{
    [api AfterConsumeWithSaleId:saleId];
}
//商家兑换商品确认
-(void)ScanRedeemCodeWithSaleId:(NSString *)saleId
{
    [api ScanRedeemCodeWithSaleId:saleId];
}
//预售商品扫码验证
-(void)MobileWithredeemCode:(NSString *)redeemCode
{
    
    [api MobileWithredeemCode:redeemCode];
}




//上传单个图片
-(void)upHeadImage:(UIImage *)data
            number:(NSString *)number
            urlStr:(NSString *)urlStr
{
    [api upHeadImage:data
              number:number
              urlStr:urlStr];
}
- (void)cancel
{
    [api cancel];
}

@end
