//
//  ShopListModel.h
//  DragonPoints
//
//  Created by shangce on 16/8/17.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopListModel : NSObject
@property (nonatomic , copy)NSString *address;
@property (nonatomic , copy)NSString *distance;
@property (nonatomic , copy)NSString *memberId;
@property (nonatomic , copy)NSString *shopperId;
@property (nonatomic , copy)NSString *shopperImage;
@property (nonatomic , copy)NSString *shopperName;
@property (nonatomic , copy)NSString *tradesCount;
@end
