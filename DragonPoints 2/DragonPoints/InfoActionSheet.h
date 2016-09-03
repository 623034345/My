//
//  InfoActionSheet.h
//  DingDCommunity
//
//  Created by Thomas on 15-1-9.
//  Copyright (c) 2015年 com.dingdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^choiceBlock)(int tag);

/*
 *带选择的对话框
 */
@interface InfoActionSheet : UIView
{
    UIImageView *view;//背景
    UIButton *btn;    //按钮
    CGFloat height;   //高度
}

@property (nonatomic, copy) choiceBlock block;

- (instancetype)initInfoActionSheetWithChoiceBtn:(NSMutableArray *)choiceArr;
- (void)showView;

@end
