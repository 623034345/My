//
//  EvaluateViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/1.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "EvaluateViewController.h"

@interface EvaluateViewController ()

@end

@implementation EvaluateViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"全部评价";
    // Do any additional setup after loading the view.
    [[HttpHelper sharedInstance] evaluateWithproductId:@"21"];
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    imgArr = [NSMutableArray array];
    dataArr = [NSMutableArray array];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *conteLab;

    NSString *name = [NSString stringWithFormat:@"cellO%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        UIImageView *touImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
        touImg.layer.masksToBounds = YES;
        touImg.layer.cornerRadius = 15;
        touImg.tag = 10;
        [cell addSubview:touImg];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, SCREEN_WIDTH - 55, 30)];
        nameLab.font = [UIFont systemFontOfSize:13];
        nameLab.tag = 11;
        [cell addSubview:nameLab];
        RatingBarView *ratView = [[RatingBarView alloc] initWithFrame:CGRectMake(50, 30, 200, 50)];
        ratView.tag = 182;
        [ratView setImageDeselected:@"star2"
                       halfSelected:@"starB"
                       fullSelected:@"rating_show"
                        andDelegate:self];
        ratView.isIndicator = YES;
        [cell addSubview:ratView];
        
        
        
        conteLab = [[UILabel alloc] init];
        conteLab.font = [UIFont systemFontOfSize:13];
        conteLab.numberOfLines = 0;
        [cell addSubview:conteLab];
        
    }
    CommentidModel *mod = dataArr[indexPath.row];
    RatingBarView *ratView = (RatingBarView *)[cell viewWithTag:182];
    [ratView displayRating:[mod.givescore floatValue]];
    UILabel *nameLab = (UILabel *) [cell viewWithTag:11];
    nameLab.text = [NSString stringWithFormat:@"%@     %@",mod.commentuserid,mod.commenttime];
    UIImageView *touImg = (UIImageView *)[cell viewWithTag:10];
    [touImg sd_setImageWithURL:[NSURL URLWithString:mod.memberHeadImageUrl]];
    CGSize size = CGSizeMake(SCREEN_WIDTH-20, 10000);
    float b = [[GlobalCenter sharedInstance] TextHeightSize:size Font:13 Text:mod.thecomment];

    conteLab.frame = CGRectMake(10, 50, SCREEN_WIDTH-20, b);
    conteLab.text = mod.thecomment;
    int columnLength = 2;
    for (int n = 0; n < mod.imageList.count; n ++)
    {
        UIImageView *img = [[UIImageView alloc] init];
        img.tag = 40+n;
        [cell addSubview:img];
        int x = (n %4)*((SCREEN_WIDTH - 1)/4 + columnLength) + columnLength;
        img.frame = CGRectMake(x, 50 + b + 10, (SCREEN_WIDTH - 2)/4 - 6, (SCREEN_WIDTH - 2)/4 - 6);
        [img sd_setImageWithURL:[NSURL URLWithString:mod.imageList[n]]];

        
    }
 
 
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentidModel *mod = dataArr[indexPath.row];

//    NSString * aaaa = @"大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是";
    CGSize size = CGSizeMake(SCREEN_WIDTH-20, 10000);
    float b = [[GlobalCenter sharedInstance] TextHeightSize:size Font:15 Text:mod.thecomment];
    if (mod.imageList.count >0) {
        return b+60 + (SCREEN_WIDTH - 2)/4 - 6;

    }
    else
    {
        return b+60;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([EVALUATE isEqualToString:key] )
    {
        NSDictionary *successDic = [notify userInfo][EVALUATE];
//        NSLog(@"数据:%@",successDic);

        NSArray *sourceArray = successDic[@"comments"];
        
        [sourceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
            CommentidModel *mod =[[CommentidModel alloc]init];
            [mod setValuesForKeysWithDictionary:obj];
            [dataArr addObject:mod];
             NSMutableArray *arr = [NSMutableArray array];
             NSArray *imageList = obj[@"imageList"];
             [imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                 NSString *img = obj1[@"imageUrl"];
                 [arr addObject:img];
             }];
             mod.imageList = arr;
         }];
    }
    [table reloadData];
    
    
}
- (void)failure:(NSNotification *)notify
{
    
}
-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)ratingChanged:(float)newRating
{
    
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
