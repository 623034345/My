//
//  MineSettingViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/8.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "MineSettingViewController.h"

@interface MineSettingViewController ()

@end

@implementation MineSettingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    //    [self hideNavigationBarLine];
    [self.tabBarController.tabBar setHidden:YES];
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sexArr = [NSMutableArray arrayWithCapacity:0];
    sexName = @"-1";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"设置";
    imageArr = [NSMutableArray array];
    table  = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
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

    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            shopName = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 130, 0, 130, 44)];
            [cell addSubview:shopName];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
            lab.text = @"昵称";
            [cell addSubview:lab];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
        }
        shopName.text = @"用户昵称aaa";

        
        return cell;
    }
    if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            typeBtn.frame = CGRectMake(SCREEN_WIDTH - 80, 0, 40, 40);
//            [typeBtn addTarget:self action:@selector(typeBtn) forControlEvents:UIControlEventTouchUpInside];
            typeBtn.userInteractionEnabled = NO;
            typeBtn.layer.masksToBounds = YES;
            typeBtn.layer.cornerRadius = 20;
            [cell addSubview:typeBtn];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
            lab.text = @"头像";
            [cell addSubview:lab];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
        }
        if (imageArr.count == 0) {
            [typeBtn setBackgroundImage:[UIImage imageNamed:@"shiyan"] forState:UIControlStateNormal];

        }
        
        
        return cell;
    }
    if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            sexLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 0, 100, 40)];
            sexLab.textAlignment = NSTextAlignmentRight;
            [cell addSubview:sexLab];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
            lab.text = @"性别";
            [cell addSubview:lab];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
        }
        sexLab.text = @"请选择性别";

        return cell;
    }
    if (indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
            
        }
        cell.textLabel.text = @"收货地址";
        
        return cell;
    }
    if (indexPath.row == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
            
        }
        cell.textLabel.text = @"注册地址";
        
        return cell;
    }
    if (indexPath.row == 5) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 40, 40)];
            lab1.text = @"修改";
            [cell addSubview:lab1];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 230, 44)];
            lab.tag = 530;
            [cell addSubview:lab];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
        }
        UILabel *lab = (UILabel *)[cell viewWithTag:530];
        lab.text = @"绑定手机";

        
        return cell;
    }
//    if (indexPath.row == 6) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
//            cell.selectionStyle = UITableViewCellAccessoryNone;
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
//            lineView.backgroundColor = UIBLACK;
//            [cell addSubview:lineView];
//            
//        }
//        cell.textLabel.text = @"我的二维码";
//        
//        return cell;
//    }
    if (indexPath.row == 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
            
        }
        cell.textLabel.text = @"修改密码";
        
        return cell;
    }
    if (indexPath.row == 7) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
            
        }
        cell.textLabel.text = @"交易密码";
        
        return cell;
    }
    if (indexPath.row == 8) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell9"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell9"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
            
        }
        cell.textLabel.text = @"退出登录";
        
        return cell;
    }
//    if (indexPath.row == 2) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
//            cell.selectionStyle = UITableViewCellAccessoryNone;
//            locaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            locaBtn.frame = CGRectMake(SCREEN_WIDTH - 80, 0, 40, 40);
//            
//            [locaBtn addTarget:self action:@selector(locaBtn) forControlEvents:UIControlEventTouchUpInside];
//            [locaBtn setTitle:@"设置" forState:UIControlStateNormal];
//            [cell addSubview:locaBtn];
//            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 44)];
//            lab.text = @"密码";
//            [cell addSubview:lab];
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
//            lineView.backgroundColor = UIBLACK;
//            [cell addSubview:lineView];
//        }
//        
//        
//        return cell;
//    }
//  
// 
//    if (indexPath.row == 5) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell6"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell6"];
//            cell.selectionStyle = UITableViewCellAccessoryNone;
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
//            lineView.backgroundColor = UIBLACK;
//            [cell addSubview:lineView];
//            
//        }
//        cell.textLabel.text = @"检查更新";
//        
//        return cell;
//    }
//    if (indexPath.row == 6) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell7"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell7"];
//            cell.selectionStyle = UITableViewCellAccessoryNone;
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
//            lineView.backgroundColor = UIBLACK;
//            [cell addSubview:lineView];
//            
//        }
//        cell.textLabel.text = @"联系我们";
//        
//        return cell;
//    }
//    if (indexPath.row == 7) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell8"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell8"];
//            cell.selectionStyle = UITableViewCellAccessoryNone;
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
//            lineView.backgroundColor = UIBLACK;
//            [cell addSubview:lineView];
//            
//        }
//        cell.textLabel.text = @"关于APP";
//        
//        return cell;
//    }
//    if (indexPath.row == 8) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell9"];
//        if (!cell)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell9"];
//            cell.selectionStyle = UITableViewCellAccessoryNone;
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
//            lineView.backgroundColor = UIBLACK;
//            [cell addSubview:lineView];
//            
//        }
//        cell.textLabel.text = @"退出登录";
//        
//        return cell;
//    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //修改昵称
    if (indexPath.row == 0)
    {
        NicknameViewController *nvc = [[NicknameViewController alloc] init];
        [self.navigationController pushViewController:nvc animated:YES];
    }
    //选择头像
    if (indexPath.row == 1)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择方式" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
            
        }];
        
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            if ([[GlobalCenter sharedInstance] isCameraAvailable])
            {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                           NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];

            }
            else
            {
                [self showAlertWithPoint:0 text:@"未获取访问相机权限" color:UIPINK];
            }
            
        }];
        
        UIAlertAction *picture = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
//            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//            picker.delegate = self;
//            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            picker.allowsEditing = YES;
//            [self presentViewController:picker animated:YES completion:nil];
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];

        }];
        [alert addAction:cancle];
        [alert addAction:camera];
        [alert addAction:picture];
        [self presentViewController:alert animated:YES completion:nil];
    }
    //性别
    if (indexPath.row == 2) {
        [self sexViewOn];
    }
    //收货地址
    if (indexPath.row == 3) {
        ProfileViewController *pvc = [[ProfileViewController alloc] init];
        [self.navigationController pushViewController:pvc animated:YES];
    }
    //注册地址
    if (indexPath.row == 4) {
    
    }
    //绑定手机
    if (indexPath.row == 5) {
        BindingTelViewController *bvc = [[BindingTelViewController alloc] init];
        [self.navigationController pushViewController:bvc animated:YES];
    }
//    //我的二维码
//    if (indexPath.row == 6) {
//        
//    }
    //修改登录密码
    if (indexPath.row == 6) {
        ChangePasswordViewController *cvc = [[ChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:cvc animated:YES];
        
    }
    //修改交易密码
    if (indexPath.row == 7) {
//        TradePowsViewController *tvc = [[TradePowsViewController alloc] init];
//        [self.navigationController pushViewController:tvc animated:YES];
        PwdSettingViewController *pvc = [[PwdSettingViewController alloc] init];
        [self.navigationController pushViewController:pvc animated:YES];
    }
    //退出登录
    if (indexPath.row == 8) {
        [USER_DEFAULT setObject:@""
                         forKey:USERID];
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.isFrist = YES;
        [self.navigationController pushViewController:vc animated:NO];
    }
 
  

}
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    [typeBtn setBackgroundImage:editedImage forState:UIControlStateNormal];
    [imageArr addObject:editedImage];
    [[HttpHelper sharedInstance] upHeadImageArr:imageArr];
    [table reloadData];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
       
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}


-(void)sexViewOn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:@"警告:性别只能选择一次,请谨慎选择" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action)
                             {
                                 
                             }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        sexLab.text = @"男";
        }];
    UIAlertAction *camera1 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        sexLab.text = @"女";
    }];
    [alert addAction:camera];
    [alert addAction:camera1];
    [alert addAction:cancle];

    [self presentViewController:alert animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:NO completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];

//    UIImage *infoImg =[info objectForKey:UIImagePickerControllerOriginalImage];
//    [typeBtn setBackgroundImage:infoImg forState:UIControlStateNormal];
//    [imageArr addObject:infoImg];
//    [[HttpHelper sharedInstance] upHeadImageArr:imageArr];
    //处理完毕，回到个人信息页面
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    [table reloadData];

}
//设置密码
-(void)locaBtn
{
    
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    //    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    NSDictionary *successDic = [notify userInfo][key];
    
}

- (void)failure:(NSNotification *)notify
{
    //    [self dismissIndicatorView];
    //    [self showAlertWithPoint:0
    //                        text:[notify userInfo][FAILURE]
    //                       color:UIPINK];
    
}

////上传头像
//-(void)typeBtn
//{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择方式" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
//        
//    }];
//    
//    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        if ([[GlobalCenter sharedInstance] isCameraAvailable])
//        {
//            
//        }
//        else
//        {
//            [self showAlertWithPoint:0 text:@"未获取访问相机权限" color:UIPINK];
//        }
//        
//    }];
//    
//    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
////        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
////        picker.delegate = self;
////        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
////        picker.allowsEditing = YES;
////        [self presentViewController:picker animated:YES completion:NULL];
//        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
//        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
//        controller.mediaTypes = mediaTypes;
//        controller.delegate = self;
//        [self presentViewController:controller
//                           animated:YES
//                         completion:^(void){
//                             NSLog(@"Picker View Controller is presented");
//                         }];
//    }];
//    [alert addAction:cancle];
//    [alert addAction:camera];
//    [alert addAction:picture];
//    [self presentViewController:alert animated:YES completion:nil];
//}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
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
