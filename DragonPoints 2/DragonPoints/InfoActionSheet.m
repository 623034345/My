//
//  InfoActionSheet.m
//  DingDCommunity
//
//  Created by Thomas on 15-1-9.
//  Copyright (c) 2015年 com.dingdong. All rights reserved.
//

#import "InfoActionSheet.h"

@implementation InfoActionSheet

//初始化
- (instancetype)initInfoActionSheetWithChoiceBtn:(NSMutableArray *)choiceArr
{
    if (self = [super init])
    {
        //高度
        height = 0;
        self.frame = SCREEN_BOUNDS;
        self.backgroundColor = UIColorWithRGBA(0, 0, 0, 0.2);
        
        //背景
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0)];
        view.backgroundColor = UIWHITE;
        view.userInteractionEnabled = YES;
        [self addSubview:view];
        
        //按钮
        for (int i = 0; i < choiceArr.count; i++)
        {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = UICLEAR;
            [btn setTitleColor:UIGRAY
                      forState:UIControlStateNormal];
            [btn setTitleColor:UIBLACK
                      forState:UIControlStateHighlighted];
            btn.titleLabel.font = UIFONT(18);
            [btn setTitle:[choiceArr objectAtIndex:i]
                 forState:UIControlStateNormal];
            [btn setTitle:[choiceArr objectAtIndex:i]
                 forState:UIControlStateHighlighted];
            btn.frame = CGRectMake(0, height + 44 * i, self.frame.size.width, 44);
            btn.tag = i;
            [btn addTarget:self
                    action:@selector(choiceBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            
            //分割条
            UIView *cutView = [[UIView alloc] initWithFrame:CGRectMake(0, btn.frame.origin.y + btn.frame.size.height - 0.5, self.frame.size.width, 0.5)];
            cutView.backgroundColor = UICOLOR_HEX(0xf0f1f6);
            [view addSubview:cutView];
        }
        height = btn.frame.origin.y + btn.frame.size.height;
        
        //添加轻按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(removeView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

//显示
- (void)showView
{
    [KEYWINDOW addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.2
                     animations:^
    {
        CGRect rect = view.frame;
        rect.origin.y = rect.origin.y - height;
        rect.size.height = rect.size.height + height;
        view.frame = rect;
        self.alpha = 1;
    }
                     completion:^(BOOL finished)
    {
        if (finished)
        {}
    }];
}

//移除
- (void)removeView
{
    [UIView animateWithDuration:0.2
                     animations:^
    {
        CGRect rect = view.frame;
        rect.origin.y = rect.origin.y + height;
        rect.size.height = rect.size.height - height;
        view.frame = rect;
        self.alpha = 0;
    }
                     completion:^(BOOL finished)
    {
        if (finished)
        {
            [btn removeFromSuperview];
            [view removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

//按钮
- (void)choiceBtnClick:(UIButton *)sender
{
    self.block((int)sender.tag);
    [self removeView];
}

@end
