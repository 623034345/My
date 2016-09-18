//
//  AliPayViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/5.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
@interface Product : NSObject
{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;

@end
@interface AliPayViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *table;
}
@property(nonatomic, strong)NSMutableArray *productList;
@end
