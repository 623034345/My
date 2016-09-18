//
//  MyAppointmentView.h
//  ForNowIosSupper
//
//  Created by chenlei on 15/7/21.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  预约界面
 */
@interface MyAppointmentView : UIView

@property (nonatomic ,strong) UITableView *appointTableView;//预约列表
@property (nonatomic, assign) int type;//类型 0 我的预约 1 预约我的

- (instancetype)initWithFrame:(CGRect)frame;


@end
