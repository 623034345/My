//
//  MyAppointmentBtnView.m
//  ForNowIosSupper
//
//  Created by chenlei on 15/7/23.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import "MyAppointmentBtnView.h"

@implementation MyAppointmentBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
    }
    return self;
}

- (void)createBtn
{
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    NSArray *btnArray;
    CGFloat width;
    CGFloat height;
    if (_type == 0)
    {
        width = SCREEN_WIDTH / 3.0;
        height = CGRectGetHeight(self.frame);
        btnArray = @[_btn1, _btn2, _btn3];
    }
    else
    {
        width = (SCREEN_WIDTH) / 4.0;
        height = CGRectGetHeight(self.frame);
        btnArray = @[_btn1, _btn2];
    }
    for (int i = 0; i < btnArray.count; i++)
    {
        UIButton *btn = btnArray[i];
        btn.frame = CGRectMake(width * i, 0, width, height);
        [btn setTitleColor:UIBLACK
                  forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bBtn"] forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(btnClick:)
      forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = UIFONT(14);
        [self addSubview:btn];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(width * i - 1, 0, 1, height)];
        lineView.backgroundColor = UICOLOR_HEX(0xe6e6e6);
        [self addSubview:lineView];
    }
}

- (void)btnClick:(UIButton *)sender
{
    if (_delegate)
    {
        [_delegate btnClick:sender];
    }
}

@end
