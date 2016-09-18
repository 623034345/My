//
//  HttpCenter.h
//  ForNowIosSupper
//
//  Created by fornowIOS on 15/6/3.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^successResult)(id successObj);
typedef void (^failureResult)(NSString *failureStr);

/*
 *AFNetworking封装
 */
@interface HttpCenter : NSObject
{
    AFHTTPRequestOperationManager *manager;
}

- (void)get:(NSString *)urlStr
 parameters:(NSDictionary *)parDic
    success:(successResult)successBlock
    failure:(failureResult)failureBlock;
- (void)post:(NSString *)urlStr
  parameters:(id)parDic
     success:(successResult)successBlock
     failure:(failureResult)failureBlock;
- (void)postXml:(NSURL *)url
     parameters:(NSString *)soapMessage
        success:(successResult)successBlock
        failure:(failureResult)failureBlock;

- (void)postImgsArrWithUrl:(NSString *)urlStr
                  imageArr:(NSMutableArray *)infoImgArr
                   success:(successResult)successBlock
                   failure:(failureResult)failureBlock;
- (void)postImg:(NSString *)urlStr
     parameters:(UIImage *)infoImg
         number:(NSString *)number
        success:(successResult)successBlock
        failure:(failureResult)failureBlock;
- (void)cancel;



@end
