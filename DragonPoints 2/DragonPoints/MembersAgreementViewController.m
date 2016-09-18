//
//  MembersAgreementViewController.m
//  DragonPoints
//
//  Created by shangce on 16/9/1.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "MembersAgreementViewController.h"

@interface MembersAgreementViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * contentStr;

}
@end

@implementation MembersAgreementViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏TabBar
    [self.tabBarController.tabBar setHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;

    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (_typeOn) {
        case 1:
        {
            self.navigationItem.title = @"创客级会员权益";
            contentStr = @"  通过免费注册并下载安装掌创天下手机APP，或关注掌创天下微信公众号免费注册成为会员，或通过好友分享的链接或二维码免费注册成为会员，则系统自动默认为掌创天下创客级会员，开启并享受属于自己的电商掌创江湖权益;\n1.享受在掌创江湖现金消费，免费获赠龙点币权益。\n2.享受全国范围内，掌盟店家所提供的龙点币免费兑换商品或服务。\n3.打造属于自己的掌盟系统，并享受系统掌门10%的，在掌创江湖现金消费的商品或服务广告值收益。\n4.享受所推荐掌盟店家会员消费订单的广告值3%收益。\n5.享受所推荐商品在掌创江湖销售总金额的0.3%收益。\n6.享受公益互助平台所赋予的互助和养老权益。\n7.享受公司所赋予的消费分红权益。";
        }
            break;
        case 2:
        {
            self.navigationItem.title = @"创盟级会员权益";
            contentStr = @"  创客可通过升级成为创盟级会员，以获得更高的权益。\n1.点击升级，选择支付91.9元，升级为创盟会员，获赠100个龙点币。\n2.享受在掌创江湖现金消费，免费获赠龙点币权益。\n3.享受全国范围内，掌盟店家所提供的龙点币免费兑换商品或服务。\n4.打造属于自己的掌盟系统，并享受系统掌门15%和弟子5%的，在掌创江湖现金消费的商品或服务广告值收益。\n5.享受所推荐掌盟店家会员消费订单的广告值5%收益。\n6.享受所推荐商品在掌创江湖销售总金额的0.5%收益。\n7.享受公益互助平台所赋予的互助和养老权益。\n8.享受公司所赋予的消费分红权益。";

        }
            break;
        case 3:
        {
            self.navigationItem.title = @"盟主级会员权益";
            contentStr = @"  创客、创盟可通过升级成为盟主级会员，以获得更高的权益。\n1.点击升级，选择支付919元，升级为盟主会员，获赠1000个龙点币。\n2.享受在掌创江湖现金消费，免费获赠龙点币权益。\n3.享受全国范围内，掌盟店家所提供的龙点币免费兑换商品或服务。\n4.打造属于自己的掌盟系统，并享受系统掌门25%和弟子10%及玩家5%的，在掌创江湖现金消费的商品或服务广告值收益。\n5.享受所推荐掌盟店家会员消费订单的广告值10%收益。\n6.享受所推荐商品在掌创江湖销售总金额的1%收益。\n7.享受所推荐省级分公司其区域内所有掌盟店家，会员消费订单的0.1%广告值收益。\n8.享受所推荐市级分公司其区域内所有掌盟店家，会员消费订单的0.5%广告值收益。\n9.享受所推荐县区级运营中心其区域内所有掌盟店家，会员消费订单的1%广告值收益。\n10.享受所推荐乡镇级服务中心其区域内所有掌盟店家，会员消费订单的2%广告值收益。";

        }
            break;
            
        default:
            break;
    }
    self.view.backgroundColor = UIWHITE;

    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self addBackBtnWithImageNormal:@"back" fuction:@selector(back)];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        CGSize size = CGSizeMake(SCREEN_WIDTH - 10, 10000);
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(10, 5, SCREEN_WIDTH - 10, [[GlobalCenter sharedInstance] TextHeightSize:size Font:17 Text:contentStr]);
        lab.text = contentStr;
        lab.font = [UIFont systemFontOfSize:17];
        lab.numberOfLines = 0;
        [cell addSubview:lab];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(SCREEN_WIDTH - 10, 10000);
    float height = [[GlobalCenter sharedInstance] TextHeightSize:size Font:17 Text:contentStr] + 50;
    if (height <SCREEN_HEIGHT - 64) {
        return SCREEN_HEIGHT - 64;
    }
    return  height;
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
