//
//  Picture.h
//  DingDCommunity
//
//  Created by Thomas on 15-1-13.
//  Copyright (c) 2015年 com.dingdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 *焦点图(完成)
 */
@interface Picture : NSObject

@property (nonatomic,copy)NSString* Code;
@property (nonatomic,copy)NSString* ImgSrc;
@property (nonatomic,copy)NSString* ObjectId;
@property (nonatomic,copy)NSString* Url;

//初始化
- (id)initPictureWithDic:(NSDictionary *)dic;

@end
