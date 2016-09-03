//
//  ViewController.h
//  NaviDemo
//
//  Created by Baidu on 14/12/18.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//                 导航

#import <UIKit/UIKit.h>

@interface PhoneGPSViewController : UIViewController
{
    NSMutableArray *imagesURLStrings;
    BMKLocationService *_locService ;
    BMKGeoCodeSearch *_geocodesearch;
    long locaLatitude;
    long locaLongitude;
    UILabel* startNodeLabel;

}
@property(nonatomic)double locaLatitude,locaLongitude;
@property(nonatomic, copy) NSString *purpose,*current;
@end

