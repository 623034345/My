//
//  ScrollView.h
//  DingDCommunity
//
//  Created by Thomas on 14-12-29.
//  Copyright (c) 2014年 com.dingdong. All rights reserved.
//
//#import "UIImageView+WebCache.h"
#define UIColorWithRGBA(r,g,b,a) \
[UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DDPageControl.h"
#import "Picture.h"
#import "ScrollViewDelegate.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
/*
 *焦点图
 */
@interface ScrollView : UIView <UIScrollViewDelegate>
{
    UIScrollView *scrolledView;//焦点图滑动界面
    DDPageControl *pageControl;//焦点图指示
    NSMutableArray *imageArr;  //图片数组
    NSTimer *timer;            //计时器
    CATransition *transition;  //动画效果
}

@property (nonatomic, assign) id<ScrollViewDelegate> delegate;//代理

//初始化
- (id)initWithFrame:(CGRect)frame
           ImageArr:(NSMutableArray *)arr;

- (instancetype)initWithFrame:(CGRect)frame images:(NSMutableArray *)images;

@end
