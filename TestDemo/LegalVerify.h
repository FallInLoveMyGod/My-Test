//
//  LegalVerify.h
//  TestDemo
//
//  Created by 51jk on 16/11/21.
//  Copyright © 2016年 51jk. All rights reserved.
//


#import <Foundation/Foundation.h>
/*
 *    判断字符串是否Legal
 */

@interface LegalVerify : NSObject



// 判断电话号码的合法性
+ (BOOL)checkTel:(NSString *)str;


@end
