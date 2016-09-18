//
//  EffectLabel.h
//  ForNowIosSupper
//
//  Created by fornowIOS on 15/9/23.
//  Copyright © 2015年 fornowIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EffectLabel : UIView
{
    UILabel *_effectLabel;
    CGImageRef _alphaImage;
    CALayer *_textLayer;
}

@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *effectColor;
@property (strong, nonatomic) NSString *text;

- (void)startAnimating;
- (void)stopAnimating;

@end
