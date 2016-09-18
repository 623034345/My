//
//  LabelAlert.m
//  ForNowIosSupper
//
//  Created by Thomas on 15-7-8.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import "LabelAlert.h"

@implementation LabelAlert

//初始化
- (instancetype)initLabelAlertWithTipDetailLab:(NSString *)tipStr
                                       leftBtn:(NSString *)leftStr
                                      rightBtn:(NSString *)rightStr
{
    if (self = [super init])
    {
        self.layer.cornerRadius = 5;
        
        //遮罩层
        control = [[UIControl alloc] initWithFrame:SCREEN_BOUNDS];
        control.backgroundColor = UIBLACK;
        if (NULL_STR(leftStr))
        {}
        else
        {
            [control addTarget:self
                        action:@selector(dismissView)
              forControlEvents:UIControlEventTouchUpInside];
        }
        
        //文字提示对话框
        self.bounds = CGRectMake(0, 0, SCREEN_WIDTH * 0.8, SCREEN_WIDTH * 0.8 * 0.8);
        self.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        self.backgroundColor = UIWHITE;
        
        //提示
        tipLab = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, self.bounds.size.width - 36, 44)];
        tipLab.backgroundColor = UICLEAR;
        tipLab.text = @"提示";
        tipLab.textColor = UIBLACK;
        tipLab.font = UIFONT(18);
        [self addSubview:tipLab];
        
        //横线
        lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, self.bounds.size.width, 0.5)];
        lineView.backgroundColor = UICOLOR_HEX(0xf0f1f6);
        [self addSubview:lineView];
        
        //提示详情
        tipDetailLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLab.frame.origin.x, lineView.frame.origin.y + 0.5, tipLab.frame.size.width, self.bounds.size.height - 44 - 44)];
        tipDetailLab.backgroundColor = UICLEAR;
        tipDetailLab.text = tipStr;
        tipDetailLab.textColor = UIBLACK;
        tipDetailLab.textAlignment = NSTextAlignmentCenter;
        tipDetailLab.font = UIFONT(18);
        [self addSubview:tipDetailLab];
        
        //左边按钮
        leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (NULL_STR(leftStr))
        {
            leftBtn.frame = CGRectZero;
        }
        else
        {
            leftBtn.frame = CGRectMake(0, self.bounds.size.height - 44, self.bounds.size.width / 2, 44);
        }
        leftBtn.titleLabel.font = UIFONT(18);
        [leftBtn setTitle:leftStr
                 forState:UIControlStateNormal];
        [leftBtn setTitle:leftStr
                 forState:UIControlStateHighlighted];
        [leftBtn setTitleColor:UIWHITE
                      forState:UIControlStateNormal];
        [leftBtn setTitleColor:UIWHITE
                      forState:UIControlStateHighlighted];
        [leftBtn setBackgroundImage:[[GlobalCenter sharedInstance] imageWithColor:UIRED_NORMAL
                                                                             size:CGSizeMake(1, 1)]
                           forState:UIControlStateNormal];
        [leftBtn setBackgroundImage:[[GlobalCenter sharedInstance] imageWithColor:UIRED_HIGHLIGHTED
                                                                             size:CGSizeMake(1, 1)]
                           forState:UIControlStateHighlighted];
        [leftBtn addTarget:self
                    action:@selector(didClickLeftBtn)
          forControlEvents:UIControlEventTouchUpInside];

        //贝赛尔曲线
        path = [UIBezierPath bezierPathWithRoundedRect:leftBtn.bounds
                                     byRoundingCorners:UIRectCornerBottomLeft
                                           cornerRadii:CGSizeMake(5, 5)];
        
        //层
        layer = [[CAShapeLayer alloc] init];
        layer.frame = leftBtn.bounds;
        layer.path = path.CGPath;
        leftBtn.layer.mask = layer;
        [self addSubview:leftBtn];
        
        //右边按钮
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (NULL_STR(leftStr))
        {
            self.rightBtn.frame = CGRectMake(0, self.bounds.size.height - 44, self.bounds.size.width, 44);
        }
        else
        {
            self.rightBtn.frame = CGRectMake(leftBtn.frame.size.width, self.bounds.size.height - 44, self.bounds.size.width / 2, 44);
        }
        self.rightBtn.titleLabel.font = UIFONT(18);
        [self.rightBtn setTitle:rightStr
                       forState:UIControlStateNormal];
        [self.rightBtn setTitle:rightStr
                       forState:UIControlStateHighlighted];
        [self.rightBtn setTitleColor:UIWHITE
                            forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:UIWHITE
                            forState:UIControlStateHighlighted];
        [self.rightBtn setBackgroundImage:[[GlobalCenter sharedInstance] imageWithColor:UIBLUE_NORMAL
                                                                                   size:CGSizeMake(1, 1)]
                                 forState:UIControlStateNormal];
        [self.rightBtn setBackgroundImage:[[GlobalCenter sharedInstance] imageWithColor:UIBLUE_HIGHLIGHTED
                                                                                   size:CGSizeMake(1, 1)]
                                 forState:UIControlStateHighlighted];
        [self.rightBtn addTarget:self
                          action:@selector(didClickRightBtn)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBtn];
        
        if (NULL_STR(leftStr))
        {
            //贝赛尔曲线
            path = [UIBezierPath bezierPathWithRoundedRect:self.rightBtn.bounds
                                         byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                               cornerRadii:CGSizeMake(5, 5)];
        }
        else
        {
            //贝赛尔曲线
            path = [UIBezierPath bezierPathWithRoundedRect:self.rightBtn.bounds
                                         byRoundingCorners:UIRectCornerBottomRight
                                               cornerRadii:CGSizeMake(5, 5)];
        }
        
        //层
        layer = [[CAShapeLayer alloc] init];
        layer.frame = self.rightBtn.bounds;
        layer.path = path.CGPath;
        self.rightBtn.layer.mask = layer;
        [self addSubview:self.rightBtn];
    }
    return self;
}

//显示
- (void)showView
{
    [KEYWINDOW_VIEW addSubview:control];
    [KEYWINDOW_VIEW addSubview:self];
    [self fadeIn];
}

//移除
- (void)dismissView
{
    [self fadeOut];
}

//渐入
- (void)fadeIn
{
    control.alpha = 0;
    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform, 1.4, 1.4);
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
    {
        self.transform = CGAffineTransformScale(self.transform, 1/1.4, 1/1.4);
    }
                     completion:^(BOOL finished)
    {
        if (finished)
        {
            control.alpha = 0.3;
            self.alpha = 1;
        }
    }];
}

//渐出
- (void)fadeOut
{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
    {
         self.transform = CGAffineTransformScale(self.transform, 0.7, 0.7);
    }
                     completion:^(BOOL finished)
    {
        if (finished)
        {
            control.alpha = 0;
            self.alpha = 0;
            [control removeFromSuperview];
            [tipLab removeFromSuperview];
            [lineView removeFromSuperview];
            [tipDetailLab removeFromSuperview];
            [leftBtn removeFromSuperview];
            [self.rightBtn removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

//左边按钮
- (void)didClickLeftBtn
{
    [self dismissView];
}

//右边按钮
- (void)didClickRightBtn
{
    [self dismissView];
    if (self.rightBlock)
    {
        self.rightBlock();
    }
}

@end
