//
//  HttpCenter.m
//  ForNowIosSupper
//
//  Created by fornowIOS on 15/6/3.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import "HttpCenter.h"

@implementation HttpCenter

//初始化
- (id)init
{
    if (self = [super init])
    {
        manager = [AFHTTPRequestOperationManager manager];
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //响应格式
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/javascript", @"text/html", nil];//
        
        //超时时间

        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//        manager.requestSerializer.timeoutInterval = 10;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager setAccessibilityLanguage:@"zh-Hans"];
    }
    return self;
}

//Json get请求
- (void)get:(NSString *)urlStr
 parameters:(NSDictionary *)parDic
    success:(successResult)successBlock
    failure:(failureResult)failureBlock
{
    [manager GET:urlStr
      parameters:parDic
         success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
//        NSDictionary *dicJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        successBlock(responseObject);
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Error: %@", error);
        NSLog ( @"operation: %@" , operation. responseString );
        if (error.code == -1001 || error.code == -1003 ||error.code == 3840)
        {
            NSLog(@"%ld",(long)error.code);

            failureBlock(@"网络连接异常！");
        }
        else
        {
            failureBlock([error localizedDescription]);
        }
    }];
}

//Json post请求
- (void)post:(NSString *)urlStr
  parameters:(id)parDic
     success:(successResult)successBlock
     failure:(failureResult)failureBlock
{
    [manager POST:urlStr
       parameters:parDic
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
//        NSDictionary *dicJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        successBlock(responseObject);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (error.code == -1001 || error.code == -1003 ||error.code == 3840)
        {
            failureBlock(@"网络连接异常！");
        }
        else
        {

            failureBlock([error localizedDescription]);
        }
    }];
}
//上传图片
- (void)postImg:(NSString *)urlStr
     parameters:(UIImage *)infoImg
         number:(NSString *)number
        success:(successResult)successBlock
        failure:(failureResult)failureBlock
{
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         NSData *imageData = [NSData data];
         
         //判断图片是不是png格式的文件
         if (UIImagePNGRepresentation(infoImg)) {
             //返回为png图像。
             imageData = UIImagePNGRepresentation(infoImg);
         }else {
             //返回为JPEG图像。
             imageData = UIImageJPEGRepresentation(infoImg, 1.0);
         }
         // 上传图片，以文件流的格式
         [formData appendPartWithFileData:imageData name:@"myfiles"
                                 fileName:number
                                 mimeType:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         successBlock(responseObject);
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         if (error.code == -1001 || error.code == -1003 ||error.code == 3840)
         {
             NSLog(@"什么啊%ld  operation:%@",(long)error.code,operation.responseString);
             failureBlock(@"网络连接异常！");
         }
         else
         {
             
             failureBlock([error localizedDescription]);
         }
         
     }];
    
}

//上传多张图片
- (void)postImgsArrWithUrl:(NSString *)urlStr
     imageArr:(NSMutableArray *)infoImgArr
        success:(successResult)successBlock
        failure:(failureResult)failureBlock
{

    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         NSData *imageData = [NSData data];
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str = [formatter stringFromDate:[NSDate date]];
         NSString *fileName;
         if (infoImgArr.count > 0) {
             NSObject *firstObj = [infoImgArr objectAtIndex:0];
             if ([firstObj isKindOfClass:[UIImage class]])
             {    // 图片
                 for(NSInteger i=0; i<infoImgArr.count; i++)
                 {
                     UIImage *eachImg = [infoImgArr objectAtIndex:i];
                     if (UIImagePNGRepresentation(eachImg))
                     {
                        //返回为png图像。
                        imageData = UIImagePNGRepresentation(eachImg);
                        fileName = [NSString stringWithFormat:@"%@.png", str];
                         
                     }
                     else
                     {
                            //返回为JPEG图像。
                            imageData = UIImageJPEGRepresentation(eachImg, 1.0);
                            fileName = [NSString stringWithFormat:@"%@.jpg", str];
                         
                     }
                     [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"img%ld", i+1] fileName:fileName mimeType:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
                 }
             }
     }
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }];
}


//XML post请求
- (void)postXml:(NSURL *)url
     parameters:(NSString *)soapMessage
        success:(successResult)successBlock
        failure:(failureResult)failureBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml; charset=utf-8"
   forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength
   forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        successBlock(responseObject);
    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock([error localizedDescription]);
    }];
    [operation start];
}


//取消请求
- (void)cancel
{
    if (manager)
    {
        [manager.operationQueue cancelAllOperations];
    }
}

@end
