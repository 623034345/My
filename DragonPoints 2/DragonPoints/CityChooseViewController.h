//
//  CityChooseViewController.h
//  yoyo
//
//  Created by YoYo on 16/5/12.
//  Copyright © 2016年 cn.yoyoy.mw. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void(^CityBlock)(NSString *province, NSString *area); //定义一个代码块
typedef void(^City1Block)(NSString *province, NSString *area); //定义一个代码块
@interface CityChooseViewController : UIViewController
@property (copy, nonatomic) City1Block cityInfo; //选择的城市信息
- (void)returnCityInfo:(City1Block)block; //赋值的时候回调
/// Typedef redefinition with different types ('void (^)(NSString *__strong, NSString *__strong)' vs 'void (^)(NSString *__strong, NSString *__strong, NSString *__strong)')
@end
