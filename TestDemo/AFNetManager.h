//
//  AFNetManager.h
//  TestDemo
//
//  Created by 51jk on 16/11/22.
//  Copyright © 2016年 51jk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <UIKit/UIKit.h>

@interface AFNetManager : NSObject
typedef void (^Block)(id result);

#pragma mark ------- 测试接口－－－－－－－－
#define kVerifyCodeURL @"http://04.api.test.51jk.com/uas/sendCode?site_id=100001&access_token=3D38A660-2176-4C03-C50A-06945E1919B5"

#define kLoginURL @"http://04.api.test.51jk.com/uas/login?site_id=100001&access_token=3D38A660-2176-4C03-C50A-06945E1919B5"

#define kIsMemeberURL @"http://04.api.test.51jk.com/uas/isMember?site_id=100001&access_token=3D38A660-2176-4C03-C50A-06945E1919B5"

+ (void)POST:(NSString *)postUrl parameters:(NSDictionary *)parameters success:(Block)successd failure:(Block)failured;


@end
