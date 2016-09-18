//
//  MapViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/5.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
{
    BMKMapView* _mapView ;
    float locaLatitude;
    float locaLongitude;
    BMKPoiSearch *_search;
    BMKLocationService *_locService ;
    BMKGeoCodeSearch *_geocodesearch;

}
@end
