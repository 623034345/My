//
//  InfoAlert.h
//  ForNowIosSupper
//
//  Created by Thomas on 15-6-21.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *带提示弹窗的对话框
 */
@interface InfoAlert : UIView
{
    UILabel *tipLab;//提示
}

- (id)initInfoAlertWithPoint:(int)flag
                        text:(NSString *)textStr
                       color:(UIColor *)color;
- (void)showView;

@end
