//
//  CityViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CityBlock)(NSString *province, NSString *city,NSString *area,NSString *town,NSInteger S,NSInteger Q,NSInteger X,NSInteger Z); //定义一个代码块

@interface CityViewController : UIViewController<UIPickerViewDelegate>
{
    NSMutableArray *provinceArr,*cityArr,*areaArr,*townArr;
    
    

}
@property (copy, nonatomic) NSString *province1; //选中的省
@property (copy, nonatomic) NSString *area1; //选中的地区
@property (copy, nonatomic) NSString *city1; //选中的地区
@property (copy, nonatomic) NSString *town1; //选中的地区
@property (nonatomic) NSInteger S,Q,X,Z;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (copy, nonatomic) CityBlock cityInfo; //选择的城市信息
- (void)returnCityInfo:(CityBlock)block; //赋值的时候回调
- (IBAction)wancheng:(id)sender;

@end
