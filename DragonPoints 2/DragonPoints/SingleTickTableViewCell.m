//
//  NoneTableViewCell.m
//  ForNowIosSupper
//
//  Created by fornowIOS on 15/7/14.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import "SingleTickTableViewCell.h"

@implementation SingleTickTableViewCell

//初始化
- (void)awakeFromNib
{
    //点击背景
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = UICOLOR_HEX(0xe6e6e8);
    self.selectedBackgroundView = bgView;
    
    self.tipView.hidden = YES;
}

@end
