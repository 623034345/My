//
//  HelpViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏TabBar
    [self.tabBarController.tabBar setHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
    
    [[HttpHelper sharedInstance]removeListener:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"申请帮助";
    imgArr = [NSMutableArray arrayWithCapacity:0];
    [imgArr addObject:[UIImage imageNamed:@"add"]];
    imgArr1 = [NSMutableArray arrayWithCapacity:0];
    [imgArr1 addObject:[UIImage imageNamed:@"add"]];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self touchTable:table commentTableViewTouchInSide:@selector(commentTableViewTouchInSide)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
    [btn setBackgroundColor:UIRED];
    [btn addTarget:self action:@selector(tjBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
//提交数据
-(void)tjBtn
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.textLabel.text = @"请仔细阅读<公益互助基金使用管理规则>并认真填写下列资料:";
        return cell;
    }
    if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTwo"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTwo"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];
            
            nameTX = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, SCREEN_WIDTH - 120, 50)];
            nameTX.placeholder = @"请输入姓名";
            [cell addSubview:nameTX];
            
        }
        cell.textLabel.text = @"申请人姓名";
        return cell;
    }
    if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellThird"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellThird"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];
            
            numberTX = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, SCREEN_WIDTH - 120, 50)];
            numberTX.placeholder = @"请输入身份证号码";
            [cell addSubview:numberTX];
            
        }
        cell.textLabel.text = @"身份证号码";
        return cell;
    }
    if (indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFour"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFour"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];
            
            homeTX = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, SCREEN_WIDTH - 120, 50)];
            homeTX.placeholder = @"请输入家庭住址";
            [cell addSubview:homeTX];
            
        }
        cell.textLabel.text = @"家庭住址";
        return cell;
    }
    if (indexPath.row == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFever"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFever"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];
            
            telTX = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, SCREEN_WIDTH - 120, 50)];
            telTX.placeholder = @"请输入电话号码";
            [cell addSubview:telTX];
            
        }
        cell.textLabel.text = @"联系电话";
        return cell;
    }
    if (indexPath.row == 5) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFever"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFever"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];

            
        }
        cell.textLabel.text = @"申请原因";
        return cell;
    }
    if (indexPath.row == 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFever"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFever"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];
            
            
        }
        cell.textLabel.text = @"上传资料";
        return cell;
    }
    if (indexPath.row == 7)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFever"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFever"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            lab.text = @"请上传本人身份证正反面和父(母)身份证正反面,共四张!!!";
            lab.textColor = UIRED;
            lab.font = [UIFont systemFontOfSize:13.0f];
            lab.numberOfLines = 0;
            [cell addSubview:lab];
            
        }
        //列间距
        int columnLength = 1;
        for (int i = 0; i <imgArr.count; i ++)
        {
            int x = (i %4)*((SCREEN_WIDTH - 1)/4 + columnLength) + columnLength ;

            imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            imageBtn.frame = CGRectMake(x, 40, SCREEN_WIDTH/4-10, 70);
            [imageBtn setImage:imgArr[i] forState:UIControlStateNormal];
            imageBtn.tag = 1;
            [imageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:imageBtn];
        }
        return cell;
    }
    if (indexPath.row == 8)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFever"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFever"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 239, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            lab.text = @"请上传申请的其他资料!!!";
            lab.textColor = UIRED;
            lab.font = [UIFont systemFontOfSize:13.0f];
            lab.numberOfLines = 0;
            [cell addSubview:lab];
            
        }
        //行间距
        
        int rowLength = 5;
        
        //列间距
        int columnLength = 1;
        for (int i = 0; i <imgArr1.count; i ++)
        {
            int x = (i %4)*((SCREEN_WIDTH - 1)/4 + columnLength) + columnLength ;
            
            int y = (i/4)*((SCREEN_WIDTH - 1)/4  + rowLength) + rowLength +40;
            imageBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            imageBtn1.frame = CGRectMake(x, y, SCREEN_WIDTH/4-10, 70);
            [imageBtn1 setImage:imgArr1[i] forState:UIControlStateNormal];
            imageBtn1.tag = 2;
            [imageBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:imageBtn1];
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5)
    {
        textView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
        textView.alpha = 0;
        textView.backgroundColor = UIBLACK;
        [self.view addSubview:textView];
        [UIView animateWithDuration:1 animations:^{
            textView.alpha = 0.98;
        }];
        
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 2 - 120, SCREEN_WIDTH, 240)];
        view.backgroundColor = UIWHITE;
        view.alpha = 1;
        [textView addSubview:view];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        lab.text = @"请输入申请理由";
        lab.textColor = UICYAN;
        lab.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lab];

        onView = [[UITextView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 150)];
        onView.delegate = self;
        [view addSubview:onView];
        
        numLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 120, 150, 30)];
        numLab.text = @"还可输入300字";
        numLab.textColor = UICOLOR_HEX(0x939393);
        [onView addSubview:numLab];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 190, SCREEN_WIDTH, 50);
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
        [btn setBackgroundColor:UIRED];
        [btn addTarget:self action:@selector(sumbit) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
    }
}
//确定移除弹框
-(void)sumbit
{
    content = onView.text;
    [onView resignFirstResponder];

    [UIView animateWithDuration:0.2
                     animations:^
     {
         textView.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         if (finished)
         {
             [self performSelector:@selector(dismissView)];
         }
     }];
}
-(void)dismissView
{
    [textView removeFromSuperview];
}
- (void)textViewDidChange:(UITextView *)textView
{
    //自动获取焦点弹出键盘
    [onView becomeFirstResponder];
    long num = 300 - onView.text.length;
    numLab.text = [NSString stringWithFormat:@"还可输入%ld字", num];
    if (num < 0)
    {
        numLab.textColor = [UIColor redColor];
    }
    else
    {
        numLab.textColor = UICOLOR_HEX(0x939393);
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        [onView resignFirstResponder];
        
    }
    return YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7 ) {
        return 120;
    }
    if (indexPath.row == 8) {
        return 240;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
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
//上传身份证
-(void)btnClick:(UIButton *)btn
{
    type = btn.tag;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([[GlobalCenter sharedInstance] isCameraAvailable])
        {
            [self snapImage];
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
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([[GlobalCenter sharedInstance] isFrontCameraAvailable])
    {
        imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    imagePickerVC.allowsEditing = YES;
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
    imagePickerVC.mediaTypes = mediaTypes;
    imagePickerVC.delegate = self;
    [self presentViewController:imagePickerVC
                       animated:YES
                     completion:^(void)
     {}];
    
    
}
- (void)didClickOtherImageView:(int)tag
{
    LabelAlert *labelAlert = [[LabelAlert alloc] initLabelAlertWithTipDetailLab:@"您确定要删除该图片吗?"
                                                                        leftBtn:@"取消"
                                                                       rightBtn:@"确定"];
    [labelAlert showView];
    labelAlert.rightBlock = ^
    {
        //        [publishVC.imgageArray removeObjectAtIndex:tag];
        //        [_upTableView reloadData];
    };
}
//从相册中选取图片
- (void)btnActionForEditPortrait
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc]init];
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,NSDictionary *bindings){
        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
            return duration >= 5;
        }else{
            return  YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:nil];
    
}
/*
 得到选中的图片
 */
#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didSelectAsset:(ALAsset*)asset
{
    if (type == 1) {
        picker.maximumNumberOfSelection = 5 - [imgArr count];

    }
    else
    {
        picker.maximumNumberOfSelection = 9 - [imgArr count];

    }
}

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    if (type == 1) {
        [imgArr removeAllObjects];
        [picker dismissViewControllerAnimated:YES completion:nil];
        for (int i=0; i<assets.count; i++) {
            ALAsset *asset=assets[i];
            
            UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            [imgArr addObject:tempImg];
            
            
        }
        
        
        [[HttpHelper sharedInstance] upHeadImageArr:imgArr];
    }
    else
    {
        [imgArr1 removeAllObjects];
        [picker dismissViewControllerAnimated:YES completion:nil];
        for (int i=0; i<assets.count; i++) {
            ALAsset *asset=assets[i];
            
            UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            [imgArr1 addObject:tempImg];
            
            
        }
        
        
        [[HttpHelper sharedInstance] upHeadImageArr:imgArr1];
    }
    [table reloadData];

}
-(void)commentTableViewTouchInSide
{
    [nameTX resignFirstResponder];
    [numberTX resignFirstResponder];
    [homeTX resignFirstResponder];
    [telTX resignFirstResponder];

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
