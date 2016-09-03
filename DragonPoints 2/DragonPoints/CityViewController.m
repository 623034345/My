//
//  CityViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()

@end

@implementation CityViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    provinceArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"county.plist" ofType:nil]];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Region.plist" ofType:nil]];
    provinceArr = dic[@"provinceList"];
    cityArr = [[provinceArr objectAtIndex:0] objectForKey:@"cityList"];
    
    areaArr = [[cityArr objectAtIndex:0] objectForKey:@"districtList"];
    townArr = [[areaArr objectAtIndex:0] objectForKey:@"townList"];
//    [_pickerView selectRow:1 inComponent:1 animated:YES];
}
/**
 
 *通过自定义view去显示pickerView中的内容,这样做的好处是可以自定义的调整pickerView中显示内容的格式
 
 */

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{

    UILabel *myView = nil;
    
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
    
    myView.textAlignment = NSTextAlignmentCenter;
    
    myView.font = [UIFont systemFontOfSize:15];         //用label来设置字体大小
    
    if (component==0) {
        
        myView.text = [[provinceArr objectAtIndex:row] objectForKey:@"provinceName"];
        
    }else if (component==1)
        
    {
        
        myView.text = [[cityArr objectAtIndex:row] objectForKey:@"cityName"];
        
    }else if (component == 2)
        
    {
        
        myView.text = [areaArr objectAtIndex:row][@"districtName"];
        
    }
    else
    {
        myView.text = [townArr objectAtIndex:row][@"townname"];
    }
    
    return myView;
    
}
#pragma mark - UIPickerViewDelegate

/**
 
 *返回每一列的数据个数
 
 */

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    if (component==0) {
        
        return [provinceArr count];
        
    }else if(component==1)
        
    {
        
        return [cityArr count];
        
    }else if (component == 2)
        
    {
        
        return [areaArr count];
        
    }
    else
    {
        return townArr.count;
    }
    
    
}
/**
 
 *返回pickerView分几列，因为是省市区选择，所以分3列
 
 */

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 4;
    
}

/**
 
 *触发的事件
 
 */

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    if (component==0) {   //当是省的时候
        
        cityArr = [[provinceArr objectAtIndex:row] objectForKey:@"cityList"];
        
        [pickerView selectRow:0 inComponent:1 animated:NO];
        
        [self.pickerView reloadComponent:1];
        
        if ([cityArr count]!=0) {
            
            areaArr = [[cityArr objectAtIndex:0] objectForKey:@"districtList"];
            
            [pickerView selectRow:0 inComponent:2 animated:NO];
            
            [self.pickerView reloadComponent:2];
            
        }
        
    }
    
    else if (component==1)
        
    {
        
        areaArr = [[cityArr objectAtIndex:row] objectForKey:@"districtList"];
        
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
        [self.pickerView reloadComponent:2];
        
    }
    else if (component == 2)
    {
        townArr = [[areaArr objectAtIndex:row] objectForKey:@"townList"];

        [pickerView selectRow:0 inComponent:3 animated:NO];
        
        [self.pickerView reloadComponent:3];
    }

    _province1= [[provinceArr objectAtIndex:[self.pickerView selectedRowInComponent:0]] objectForKey:@"provinceName"];  //获取province
    _S = [[[provinceArr objectAtIndex:[self.pickerView selectedRowInComponent:0]] objectForKey:@"provinceId"] integerValue];  //获取province

    _city1=  [[cityArr objectAtIndex:[self.pickerView selectedRowInComponent:1]] objectForKey:@"cityName"];
    _Q = [[[cityArr objectAtIndex:[self.pickerView selectedRowInComponent:1]] objectForKey:@"cityId"] integerValue];  //获取province

    
    if ([areaArr count]>0) {
        
        _area1 =  [[areaArr objectAtIndex:[self.pickerView selectedRowInComponent:2]] objectForKey:@"districtName"];
        _X = [[[areaArr objectAtIndex:[self.pickerView selectedRowInComponent:2]] objectForKey:@"districtid"] integerValue];  //获取province

    }
    if (townArr.count > 0) {
        _town1 =  [[townArr objectAtIndex:[self.pickerView selectedRowInComponent:3]] objectForKey:@"townname"];
        _Z = [[[townArr objectAtIndex:[self.pickerView selectedRowInComponent:3]] objectForKey:@"townid"] integerValue];  //获取province


    }

        if (NULL_STR(_area1)) {
            _area1 = @"";
        }
    if (NULL_STR(_town1)) {
        _area1 = @"";
    }
    NSString *name = [NSString stringWithFormat:@"%@ %@ %@ %@",_province1,_city1,_area1,_town1];
    self.lab.text = name;
    

    
}
//赋值
- (void)returnCityInfo:(CityBlock)block {
    _cityInfo = block;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)wancheng:(id)sender {
//    _cityInfo(_province1,_city1, _area1);
    if (NULL_STR(_province1)) {
        [self showAlertWithPoint:1 text:@"请选择地区" color:UIPINK];
    }
    else
    {
        _cityInfo(_province1,_city1,_area1,_town1,_S,_Q,_X,_Z);
        [self.navigationController popViewControllerAnimated:YES];
    }
   

}
@end
