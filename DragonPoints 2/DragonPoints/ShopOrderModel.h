//
//  ShopOrderModel.h
//  DragonPoints
//
//  Created by shangce on 16/8/29.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopOrderModel : NSObject
@property (nonatomic, copy)NSString *saleId;
@property (nonatomic, copy)NSString *buyermemberId;
@property (nonatomic, copy)NSString *buytime;
@property (nonatomic, copy)NSString *ifpayed;
@property (nonatomic, copy)NSString *productImage;
@property (nonatomic, copy)NSString *productName;
@property (nonatomic, copy)NSString *productPrice;
@property (nonatomic, copy)NSString *coinnum;
@property (nonatomic, copy)NSString *buyAmount;
@property (nonatomic, copy)NSString *isExchange;
@property (nonatomic, copy)NSString *saleTime;
@property (nonatomic, copy)NSString *coinChange;
@property (nonatomic, copy)NSString *isSpecial;
@property (nonatomic, copy)NSString *ifCancancel;
@end
