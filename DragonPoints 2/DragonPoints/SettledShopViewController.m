//
//  SettledShopViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/5.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "SettledShopViewController.h"

@interface SettledShopViewController ()

@end
NSString *TMP_UPLOAD_IMG_PATH=@"";
@implementation SettledShopViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;

    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    if (SCREEN_HEIGHT <= 568)
    {
        [self registerForKeyboardNotifications];
        
    }
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我要入驻";
    imgNameArr = [NSMutableArray array];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
    [btn setBackgroundColor:UIRED];
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    table  = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-113) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7 || indexPath.row == 8 ||indexPath.row == 9) {
        return 120;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            shopName = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, SCREEN_WIDTH - 130, 44)];
            shopName.placeholder = @"此店铺名作为平台登录名";
            shopName.delegate = self;
            [cell addSubview:shopName];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
            lab.text = @"店铺名称";
            [cell addSubview:lab];
        }
        
        
        return cell;
    }
//        if (indexPath.row == 1) {
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
//            if (!cell) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
//                cell.selectionStyle = UITableViewCellAccessoryNone;
//                name = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, SCREEN_WIDTH - 130, 44)];
//                name.placeholder = @"此密码为登陆密码";
//                name.delegate = self;
//                [cell addSubview:name];
//                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
//                lab.text = @"店铺密码";
//                [cell addSubview:lab];
//            }
//    
//            
//            return cell;
//        }
    if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            typeBtn.frame = CGRectMake(130, 0, SCREEN_WIDTH - 200, 44);
            typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [typeBtn setTitleColor:UIGRAY forState:UIControlStateNormal];
            [typeBtn setTitle:@"点击选择" forState:UIControlStateNormal];
//            typeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [typeBtn addTarget:self action:@selector(typeBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:typeBtn];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
            lab.text = @"申请类别";
            [cell addSubview:lab];
        }
        
        
        return cell;
    }


    if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            moveTell = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, SCREEN_WIDTH - 130, 44)];
            moveTell.placeholder = @"非常重要,用于回访";
            moveTell.delegate = self;
            [cell addSubview:moveTell];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
            lab.text = @"联系方式";
            [cell addSubview:lab];
        }
        
        
        return cell;
    }
    if (indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell6"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell6"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            tell = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, SCREEN_WIDTH - 130, 44)];
            tell.placeholder = @"输入店铺座机号码";
            tell.delegate = self;
            [cell addSubview:tell];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
            lab.text = @"店铺座机";
            [cell addSubview:lab];
        }
        
        
        return cell;
    }
    if (indexPath.row == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell7"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell7"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            dc = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, SCREEN_WIDTH - 130, 44)];
            dc.placeholder = @"输入优惠折扣,8.5折请输入0.85";
            dc.delegate = self;
            [cell addSubview:dc];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
            lab.text = @"优惠折扣";
            [cell addSubview:lab];
        }
        
        
        return cell;
    }
    if (indexPath.row == 5) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            locaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            locaBtn.frame = CGRectMake(130, 0, SCREEN_WIDTH - 130, 44);
            locaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            locaBtn.titleEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            [locaBtn setTitleColor:UICOLOR_HEX(0x969fa8) forState:UIControlStateNormal];
            [locaBtn setTitle:@"选择与营业执照一致的地址" forState:UIControlStateNormal];
            locaBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [locaBtn addTarget:self action:@selector(locaBtn1) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:locaBtn];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
            lab.text = @"经营地址";
            [cell addSubview:lab];
        }
        
        
        return cell;
    }
    if (indexPath.row == 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell50"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell7"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            adressTX = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, SCREEN_WIDTH - 130, 44)];
            adressTX.placeholder = @"请输入详细街道";
            adressTX.delegate = self;
            [cell addSubview:adressTX];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
            lab.text = @"详细地址";
            [cell addSubview:lab];
        }
        
        
        return cell;
    }
//    if (indexPath.row == 6) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell8"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell8"];
//            cell.selectionStyle = UITableViewCellAccessoryNone;
//            mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            mapBtn.frame = CGRectMake(130, 0, SCREEN_WIDTH - 200, 44);
//            mapBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
//            [mapBtn setTitleColor:UIGRAY forState:UIControlStateNormal];
//            [mapBtn setTitle:@"请选择店铺位置" forState:UIControlStateNormal];
//            [mapBtn addTarget:self action:@selector(mapBtn) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:mapBtn];
//            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
//            lab.text = @"添加位置";
//            [cell addSubview:lab];
//        }
//        
//        
//        return cell;
//    }
    
    if (indexPath.row == 7) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell9"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell9"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            licenseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            licenseBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 40, 10, 80, 80);
            [licenseBtn setTitleColor:UIGRAY forState:UIControlStateNormal];
            [licenseBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [licenseBtn addTarget:self action:@selector(license:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:licenseBtn];
            licenImg =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 10, 160, 80)];
            licenImg.backgroundColor = UICLEAR;
            [cell addSubview:licenImg];
            license = [UIButton buttonWithType:UIButtonTypeCustom];
            license.frame = CGRectMake(SCREEN_WIDTH/2 - 80, 90, 160, 30);
            [license setTitleColor:UIBLACK forState:UIControlStateNormal];
            [license setTitle:@"上传营业执照" forState:UIControlStateNormal];
            [license addTarget:self action:@selector(license:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:license];
 
        }
        
        
        return cell;
    }
    if (indexPath.row == 8) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell10"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell10"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(SCREEN_WIDTH/2 - 40, 10, 80, 80);
            [btn setTitleColor:UIGRAY forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(front) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
            frontImg =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 10, 160, 80)];
            frontImg.backgroundColor = UICLEAR;
            [cell addSubview:frontImg];
            front = [UIButton buttonWithType:UIButtonTypeCustom];
            front.frame = CGRectMake(SCREEN_WIDTH/2 - 80, 90, 160, 30);
            [front setTitle:@"上传身份证正面" forState:UIControlStateNormal];

            [front setTitleColor:UIBLACK forState:UIControlStateNormal];
            [front addTarget:self action:@selector(front) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:front];
            
        }
        
        
        return cell;
    }
    
    if (indexPath.row == 9) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell11"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell11"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(SCREEN_WIDTH/2 - 40, 10, 80, 80);
            [btn setTitleColor:UIGRAY forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(reverse) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
            reverseImg =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 10, 160, 80)];
            reverseImg.backgroundColor = UICLEAR;
            [cell addSubview:reverseImg];
            reverse = [UIButton buttonWithType:UIButtonTypeCustom];
            reverse.frame = CGRectMake(SCREEN_WIDTH/2 - 80, 90, 160, 30);
            [reverse setTitle:@"上传身份证反面" forState:UIControlStateNormal];
            [reverse setTitleColor:UIBLACK forState:UIControlStateNormal];
            [reverse addTarget:self action:@selector(reverse) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:reverse];
            
        }
        
        
        return cell;
    }
    
    
    
    return nil;
}
//上传身份证正面
-(void)reverse
{
    num = 3;
    [self choos];
    
}
//上传身份证正面
-(void)front
{
    num = 2;
    [self choos];

}
//上传营业执照
-(void)license:(UIButton *)button
{
    num = 1;
    [self choos];


}
//选择地图位置
-(void)mapBtn
{
    
}
//选择地址
-(void)locaBtn1
{
    CityViewController *city = [[CityViewController alloc] init];
    //选择以后的回调
    [city returnCityInfo:^(NSString *province, NSString *city, NSString *area,NSString *town, NSInteger S, NSInteger Q, NSInteger X, NSInteger Z) {
        _Z = [NSString stringWithFormat:@"%ld",(long)Z];
        NSString *locStr = [NSString stringWithFormat:@"%@ %@ %@ %@",province,city,area,town];
        [locaBtn setTitle:locStr forState:UIControlStateNormal];
        
    }];
    [self.navigationController pushViewController:city animated:YES];
}
//选择申请类别
-(void)typeBtn
{
    
    ChoosMoreViewController *cvc = [[ChoosMoreViewController alloc] init];
    //选择以后的回调
    [cvc returnTypeInfo:^(NSString *province, NSString *Z) {
        _L = Z;
        [typeBtn setTitle:province forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:cvc animated:YES];
}
-(void)choos
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([[GlobalCenter sharedInstance] isCameraAvailable])
        {
            [self snapImage];
        }
        else
        {
            [self showAlertWithPoint:1 text:@"未获取相机权限" color:UIPINK];
        }
        
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self btnActionForEditPortrait];
        
        
    }];
    [alert addAction:cancle];
    [alert addAction:camera];
    [alert addAction:picture];
    [self presentViewController:alert animated:YES completion:nil];
}
//拍照
- (void) snapImage{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    ipc.sourceType=UIImagePickerControllerSourceTypeCamera;
    ipc.delegate=self;
    ipc.allowsEditing=NO;
//    [self presentModalViewController:ipc animated:YES];
    [self presentViewController:ipc animated:YES completion:NULL];

    
}
//从相册中选取图片或拍照
- (void)btnActionForEditPortrait
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *_avatar = info[UIImagePickerControllerOriginalImage];
    if (num == 1) {
        licenImg.image = _avatar;
        [license setTitle:@"重新上传" forState:UIControlStateNormal];
        [self saveImage:_avatar WithName:@"userAvatar1"];
    }
    if (num == 2) {
        frontImg.image = _avatar;
        [front setTitle:@"重新上传" forState:UIControlStateNormal];
        [self saveImage:_avatar WithName:@"userAvatar2"];
    }
    if (num == 3) {
        reverseImg.image = _avatar;
        [reverse setTitle:@"重新上传" forState:UIControlStateNormal];
        [self saveImage:_avatar WithName:@"userAvata3"];
    }
    //处理完毕，回到个人信息页面
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [table reloadData];
}
//保存图片
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{

    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];
    TMP_UPLOAD_IMG_PATH=totalPath;
    NSArray *nameAry=[TMP_UPLOAD_IMG_PATH componentsSeparatedByString:@"/"];
    NSLog(@"===new FileName===%@",[nameAry objectAtIndex:[nameAry count]-1]);
    //保存到 document
    [imageData writeToFile:totalPath atomically:NO];
    NSLog(@"这是图片吗%@",totalPath);
    
    //保存到 NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:totalPath forKey:imageName];
    NSString *str = [NSString stringWithFormat:@"%@_%d",[USER_DEFAULT objectForKey:USERID],num];
    NSString *fileName;
    
    if (UIImagePNGRepresentation(tempImage)) {
        //返回为png图像。
        fileName = [NSString stringWithFormat:@"%@.png", str];
    }else
    {
        //返回为JPEG图像。
        fileName = [NSString stringWithFormat:@"%@.jpg", str];
    }
    [imgNameArr addObject:fileName];
//    [[HttpHelper sharedInstance] upHeadImage:tempImage number:fileName urlStr:[NSString stringWithFormat:@"%@images/openshopper",SERVER_NAME]];


}
//从document取得图片
- (UIImage *)getImage:(NSString *)urlStr
{
    return [UIImage imageWithContentsOfFile:urlStr];
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    if ([key isEqualToString:OPENSHOPPER]) {
        NSDictionary *successDic = [notify userInfo][key];
        NSLog(@"%@",successDic);
        if ([successDic[@"code"] integerValue] > 0)
        {
            [USER_DEFAULT setObject:successDic[@"code"] forKey:SHOPPERID];
            [self showAlertWithPoint:1 text:@"申请成功" color:UICYAN];
        }
        else
        {
            [self showAlertWithPoint:1 text:@"申请失败" color:UICYAN];

        }

    }

    
}

- (void)failure:(NSNotification *)notify
{
    //    [self dismissView];
    //    [self showAlertWithPoint:0
    //                        text:[notify userInfo][FAILURE]
    //                       color:UIPINK];
}
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}
-(void)submit
{
    if (NULL_STR(shopName.text) && NULL_STR(_L) && NULL_STR(moveTell.text) && NULL_STR(tell.text) && NULL_STR(dc.text) && NULL_STR(_Z) && NULL_STR(adressTX.text) &&imgNameArr.count>0)
    {
        [self showAlertWithPoint:1 text:@"以上任何信息不能为空" color:UIPINK];
    }
    else
    {
        [[HttpHelper sharedInstance] OpenShopperWithshopperName:shopName.text
                                                smallCategoryId:_L
                                                         mobile:moveTell.text
                                                     fixedphone:tell.text
                                                       discount:dc.text
                                                       regionId:_Z
                                                 shopperAddress:adressTX.text
                                               busilicenseImage:@"2123"
                                           legalmanCardForImage:@"24"
                                          legalmanCardBackImage:@"1212"];
    }
   

}
- (void) keyboardWasShown:(NSNotification *) notif
{
    
    NSDictionary* info = [notif userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    table.frame =  CGRectMake(0,  -kbSize.height+150, SCREEN_WIDTH, SCREEN_HEIGHT - kbSize.height+150);
    
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
    NSDictionary* info = [notif userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    table.frame =  CGRectMake(0,  -kbSize.height, SCREEN_WIDTH, SCREEN_HEIGHT - kbSize.height);
}
- (void)didReceiveMemoryWarning {
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

@end
