//
//  HttpApi.h
//  ForNowIosSupper
//
//  Created by Thomas on 15-6-21.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCenter.h"

/*
 *接口封装
 */
@interface HttpApi : NSObject
{
    HttpCenter *center;
    NSMutableDictionary *apiDic;
}
- (void)loginWithUserName:(NSString *)userNameStr
                 password:(NSString *)passwordStr;
-(void)homeGetdataWithCity:(NSString *)cityName;
-(void)moreGetdata;
-(void)upHeadImageArr:(NSMutableArray *)data;
-(void)classify;
-(void)shopGetdataWithregionId:(NSString *)regionId
               smallCategoryId:(NSString *)smallCategoryId
                     orderType:(NSString *)orderType
                           lng:(NSString *)lng
                           lat:(NSString *)lat;
-(void)shopDailGetdatashopperId:(NSString *)shopperId;
-(void)offlineShopsDailWithproductId:(NSString *)productId;
-(void)registrationgWithtele:(NSString *)teleStr
                    passWord:(NSString *)passWord
             recommenderTele:(NSString *)recommenderTeleStr
                    regionId:(NSString *)regionIdStr
                     smsCode:(NSString *)smsCodeStr;

-(void)forGetWithregTele:(NSString *)regTele
                     Pwd:(NSString *)Pwd
                  smsStr:(NSString *)smsStr;

-(void)evaluateWithproductId:(NSString *)productId;
-(void)sendSmsWithtele:(NSString *)tele;
-(void)changeThePasswordWithOldPwd:(NSString *)oldPwd
                           lnewPwd:(NSString *)lnewPwd;
-(void)tradePowsWithRegtele:(NSString *)regTele
                   transPwd:(NSString *)transPwd
                    smsCode:(NSString *)smsCode;
-(void)myCoinDetailWithtype:(NSString *)type;
-(void)myBeanWithtype:(NSString *)type;
-(void)beanWithNum:(NSString *)beanNum;
-(void)preSaleWithproductId:(NSString *)productId;
-(void)buyOfflineWithproductId:(NSString *)productId
                     buyAmount:(NSString *)buyAmount
                  leavemessage:(NSString *)leavemessage
                transactionPwd:(NSString *)transactionPwd;
-(void)payCoinSuccessWithsaleId:(NSString *)saleId;
-(void)coinToDailWithSaleId:(NSString *)saleId;
-(void)BindBankCardWithbankName:(NSString *)bankName
                     bankCardId:(NSString *)bankCardId
                  bankOwnerName:(NSString *)bankOwnerName
                       bankOpen:(NSString *)bankOpen
                        msmCode:(NSString *)msmCode;
-(void)ModifyBindBankCardWithbankName:(NSString *)bankName
                     bankCardId:(NSString *)bankCardId
                  bankOwnerName:(NSString *)bankOwnerName
                       bankOpen:(NSString *)bankOpen
                        msmCode:(NSString *)msmCode;
-(void)BindZhifubaoWithzhifubaoCode:(NSString *)zhifubaoCode
                    zhifubaoUseName:(NSString *)zhifubaoUseName
                       zhifubaoType:(NSString *)zhifubaoType
                            msmCode:(NSString *)msmCode;
-(void)ModifyBindZhifubaoWithzhifubaoCode:(NSString *)zhifubaoCode
                    zhifubaoUseName:(NSString *)zhifubaoUseName
                       zhifubaoType:(NSString *)zhifubaoType
                            msmCode:(NSString *)msmCode;
-(void)MyBalanceInSystemWithtype:(NSString *)type;
-(void)BeanWithdrawWithwithdrawNum:(NSString *)withdrawNum
                       hasBankCard:(NSString *)hasBankCard
                       hasZhifubao:(NSString *)hasZhifubao;
-(void)WithdrawWithwithdrawNum:(NSString *)withdrawNum
                       hasBankCard:(NSString *)hasBankCard
                       hasZhifubao:(NSString *)hasZhifubao;
-(void)MyAssets;
-(void)BuyNowUseBalanceWithmoneyPay:(NSString *)moneyPay
                                psw:(NSString *)psw;
-(void)MyMainInfo;
-(void)UpdateNickNameWithNickName:(NSString *)NickName;
-(void)MutualFundInfo;
-(void)OpenShopperWithshopperName:(NSString *)shopperName
                  smallCategoryId:(NSString *)smallCategoryId
                           mobile:(NSString *)mobile
                       fixedphone:(NSString *)fixedphone
                         discount:(NSString *)discount
                         regionId:(NSString *)regionId
                   shopperAddress:(NSString *)shopperAddress
                 busilicenseImage:(NSString *)busilicenseImage
             legalmanCardForImage:(NSString *)legalmanCardForImage
            legalmanCardBackImage:(NSString *)legalmanCardBackImage;
-(void)ShopperMain;
-(void)GetOrderListWithType:(NSString *)type;
-(void)CancelOneOrderWithSaleId:(NSString *)saleId;
-(void)AfterConsumeWithSaleId:(NSString *)saleId;
-(void)ScanRedeemCodeWithSaleId:(NSString *)saleId;
-(void)MobileWithredeemCode:(NSString *)redeemCode;
-(void)PrepareToPayWillToThirdpaybuyerMemberId:(NSString *)buyerMemberId
                                     productId:(NSString *)productId
                                  buyAmountStr:(NSString *)buyAmountStr
                                  leavemessage:(NSString *)leavemessage
                                    ifConsumed:(NSString *)ifConsumed;
-(void)MySpendingBonusInfo;
-(void)CustomerCommentHandleWithproductId:(NSString *)productId
                                giveScore:(NSString *)giveScore
                               theComment:(NSString *)theComment
                            manyimageUrls:(NSString *)manyimageUrls;
-(void)buyOfflinePayInBalanceHandlesaleId:(NSString *)saleId
                           transactionPwd:(NSString *)transactionPwd;





-(void)upHeadImage:(UIImage *)data
            number:(NSString *)number
            urlStr:(NSString *)urlStr;

-(void)MyShownGrade;








- (void)cancel;





@end
