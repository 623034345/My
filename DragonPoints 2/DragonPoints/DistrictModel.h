//
//  DistrictModel.h
//  DragonPoints
//
//  Created by shangce on 16/8/16.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistrictModel : NSObject
@property (nonatomic , copy)NSString *districtid;
@property (nonatomic , copy)NSString *districtName;
@property (nonatomic , copy)NSMutableArray *townList;
@end
