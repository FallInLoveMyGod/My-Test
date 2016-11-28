//
//  NextViewController.m
//  TestDemo
//
//  Created by 51jk on 16/11/22.
//  Copyright © 2016年 51jk. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController
- (void)viewWillAppear:(BOOL)animated {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 移除做按钮
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]init];
    barBtn.title=@"";
    self.navigationItem.leftBarButtonItem = barBtn;
    self.title = @"测试";
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
