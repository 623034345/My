//
//  AppDelegate.h
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import "BNCoreServices.h"
#import "UPPaymentControl.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager* _mapManager;


}
@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL isReachable;


@end

