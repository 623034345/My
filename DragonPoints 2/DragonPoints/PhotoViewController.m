//
//  PhotoViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "PhotoViewController.h"
@interface PhotoViewController ()<MWPhotoBrowserDelegate>

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   //    [self.picView sd_setImageWithURL:[NSURL URLWithString:[_photoArr objectAtIndex:0]]];
//    self.photos = [NSMutableArray array];
//
//    [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg"]]];
    for (int a = 0; a < self.photoArr.count; a ++) {
        [MWPhoto photoWithURL:[NSURL URLWithString:[self.photoArr objectAtIndex:a]]];

    }

    //创建MWPhotoBrowser ，要使用initWithDelegate方法，要遵循MWPhotoBrowserDelegate协议
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    //设置当前要显示的图片
    [browser setCurrentPhotoIndex:0];
    
    //push到MWPhotoBrowser
    [self.navigationController pushViewController:browser animated:YES];
    
}
//返回图片个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return self.photoArr.count;
}

//返回图片模型
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    //创建图片模型
    MWPhoto *photo = [MWPhoto photoWithURL:[self.photoArr objectAtIndex:index]];
    
    return photo;
    
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
