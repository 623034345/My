//
//  InfoAlert.m
//  ForNowIosSupper
//
//  Created by Thomas on 15-6-21.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import "InfoAlert.h"

@implementation InfoAlert

//初始化
- (id)initInfoAlertWithPoint:(int)flag
                                  text:(NSString *)textStr
                                 color:(UIColor *)color
{
    if (self = [super init])
    {
        //背景
        self.backgroundColor = color;
        
        //大小
        self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        
        //中心点
        CGPoint point;
        
        //0代表无TabBar,1代表有TabBar
        if (flag == 0)
        {
            point = CGPointMake(self.bounds.size.width / 2, SCREEN_HEIGHT - self.bounds.size.height / 2);
        }
        else
        {
            point = CGPointMake(self.bounds.size.width / 2, SCREEN_HEIGHT - self.bounds.size.height / 2 - TAB_TAB_HEIGHT);
        }
        self.center = point;
        
        //提示标签
        tipLab = [[UILabel alloc] init];
        
        //背景
        tipLab.backgroundColor = UICLEAR;
        
        //大小
        tipLab.bounds = CGRectMake(0, 0, self.bounds.size.width, 40);
        
        //中心点
        tipLab.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        
        //文本
        tipLab.font = UIFONT(18);
        tipLab.text = textStr;
        tipLab.textColor = UIWHITE;
        tipLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tipLab];
    }
    return self;
}

//显示
- (void)showView
{
    [self fadeIn];
}

//移除
- (void)dismissView
{
    [tipLab removeFromSuperview];
    [self removeFromSuperview];
}

//渐入
- (void)fadeIn
{
    self.alpha = 0;
    [UIView animateWithDuration:0.2
                     animations:^
    {
        self.alpha = 0.7;
    }
                     completion:^(BOOL finished)
    {
        if (finished)
        {
            [self performSelector:@selector(fadeOut)
                       withObject:nil
                       afterDelay:1];
        }
    }];
}

//渐出
- (void)fadeOut
{
    [UIView animateWithDuration:0.2
                     animations:^
    {
        self.alpha = 0;
    }
                     completion:^(BOOL finished)
    {
        if (finished)
        {
            [self performSelector:@selector(dismissView)];
        }
    }];
}

@end
