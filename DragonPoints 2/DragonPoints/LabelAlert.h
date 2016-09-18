//
//  LabelAlert.h
//  ForNowIosSupper
//
//  Created by Thomas on 15-7-8.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *带文字的对话框
 */
@interface LabelAlert : UIView
{
    UIControl *control;   //遮罩层
    UILabel *tipLab;      //提示
    UILabel *tipDetailLab;//提示详情
    UIView *lineView;     //横线
    UIButton *leftBtn;    //左边按钮
    UIBezierPath *path;   //贝赛尔曲线
    CAShapeLayer *layer;  //层
}

@property (strong, nonatomic) UIButton *rightBtn;       //右边按钮
@property (nonatomic, copy) dispatch_block_t rightBlock;//右边按钮block

- (instancetype)initLabelAlertWithTipDetailLab:(NSString *)tipStr
                                       leftBtn:(NSString *)leftStr
                                      rightBtn:(NSString *)rightStr;
- (void)showView;

@end
