//
//  ScrollViewDelegate.h
//  DingDCommunity
//
//  Created by Thomas on 15-1-2.
//  Copyright (c) 2015年 com.dingdong. All rights reserved.
//

#ifndef DingDCommunity_ScrollViewDelegate_h
#define DingDCommunity_ScrollViewDelegate_h

/*
 *焦点图协议
 */
@protocol ScrollViewDelegate <NSObject>

//点击图片
- (void)scrollImageClick:(long)taskTag;

@end

#endif
