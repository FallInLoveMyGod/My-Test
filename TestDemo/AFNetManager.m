//
//  AFNetManager.m
//  TestDemo
//
//  Created by 51jk on 16/11/22.
//  Copyright © 2016年 51jk. All rights reserved.
//

#import "AFNetManager.h"

@implementation AFNetManager


+ (void)POST:(NSString *)postUrl parameters:(NSDictionary *)parameters success:(Block)successd failure:(Block)failured {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:postUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSString *status = [responseObject objectForKey:@"status"];
        successd(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failured(error);
    }];
}


@end
