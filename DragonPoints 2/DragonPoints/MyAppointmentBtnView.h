//
//  MyAppointmentBtnView.h
//  ForNowIosSupper
//
//  Created by chenlei on 15/7/23.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BtnClickDelegate <NSObject>

- (void)btnClick:(UIButton *)btn;

@end

/**
 *  预约按钮View
 */
@interface MyAppointmentBtnView : UIView

@property (assign, nonatomic) int type;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (strong ,nonatomic) id <BtnClickDelegate> delegate;

- (void)createBtn;

@end
