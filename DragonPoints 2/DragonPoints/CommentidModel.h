//
//  CommentidModel.h
//  DragonPoints
//
//  Created by shangce on 16/8/17.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentidModel : NSObject
@property (nonatomic, copy)NSString * commentid;
@property (nonatomic, copy)NSString * commenttime;
@property (nonatomic, copy)NSString * commentuserid;
@property (nonatomic, copy)NSString * givescore;
@property (nonatomic, copy)NSString * memberHeadImageUrl;
@property (nonatomic, copy)NSString * thecomment;
@property (nonatomic, copy)NSMutableArray * imageList;
@end