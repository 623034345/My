//
//  ScanQRcode.m
//  QRcode_GHdemo
//
//  Created by xiangwang on 16/6/28.
//  Copyright © 2016年 Hope. All rights reserved.
//

#import "ScanQRcode.h"
#define GH_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define GH_HEIGHT   [[UIScreen mainScreen] bounds].size.height
@interface ScanQRcode ()

@end

@implementation ScanQRcode

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"扫描二维码";
    
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    [scanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    scanButton.frame = CGRectMake(100, 430, GH_WIDTH-200, 50);
    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(20, 80, GH_WIDTH-40, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，系统会自动识别。";
    [self.view addSubview:labIntroudction];
    
    _device = [ AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    _input = [ AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    _output = [[ AVCaptureMetadataOutput alloc]init];
    [ _output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [[ AVCaptureSession alloc]init];
    [ _session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([ _session canAddInput:self.input])
    {
        [ _session addInput:self.input];
    }
    if ([ _session canAddOutput:self.output])
    {
        [ _session addOutput:self.output];
    }
    
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    [ _output setRectOfInterest : CGRectMake (( 124 )/ GH_HEIGHT ,(( GH_WIDTH - 220 )/ 2 )/ GH_WIDTH , 220 / GH_HEIGHT , 220 / GH_WIDTH )];
    
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.layer.bounds;
    //    _preview.tor
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    
    //扫描框
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((GH_WIDTH-(GH_WIDTH-GH_WIDTH*0.5f))/2,GH_HEIGHT*0.2f,GH_WIDTH- GH_WIDTH*0.5f,GH_WIDTH-GH_WIDTH*0.5f)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    upOrdown = NO;
    num =0;
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((GH_WIDTH-(GH_WIDTH-GH_WIDTH*0.5f))/2,GH_HEIGHT*0.2f,GH_WIDTH- GH_WIDTH*0.5f,1)];
    
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    [ _session startRunning ];
}
#pragma mark -
#pragma mark - 上下动画
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake((GH_WIDTH-(GH_WIDTH-GH_WIDTH*0.5f))/2, GH_HEIGHT*0.2f+2*num, imageView.frame.size.width, 2);
        if (2*num > GH_WIDTH-GH_WIDTH*0.5f-5) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake((GH_WIDTH-(GH_WIDTH-GH_WIDTH*0.5f))/2, GH_HEIGHT*0.2f+2*num, imageView.frame.size.width, 2);
        if (num == 2) {
            upOrdown = NO;
        }
    }
    
}
#pragma mark -
#pragma mark - 取消按钮
-(void)backAction
{
    _line.hidden = NO;
    [ _session startRunning ];
    
}
#pragma mark -
#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] > 0 )
    {
        // 停止扫描
        [ _session stopRunning ];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        _line.hidden = YES;//隐藏动画效果
        NSLog(@"扫描结果=%@",stringValue);
    }
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
