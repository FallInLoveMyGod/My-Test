//
//  LegalVerify.m
//  TestDemo
//
//  Created by 51jk on 16/11/21.
//  Copyright © 2016年 51jk. All rights reserved.
//

#import "LegalVerify.h"

@implementation LegalVerify

+ (BOOL)checkTel:(NSString *)str{
    NSString *regex = @"^[1][3-8]+\\d{9}";//手机号码变化大，所以没有做更精确
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return  [pred evaluateWithObject:str];
    //  测试git
    NSLog(@"aaaaaaaa ====== test");
}

@end
