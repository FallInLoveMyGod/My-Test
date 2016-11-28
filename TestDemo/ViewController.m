//
//  ViewController.m
//  TestDemo
//
//  Created by 51jk on 16/11/21.
//  Copyright © 2016年 51jk. All rights reserved.
//

#import "ViewController.h"
#import "LegalVerify.h"
#import "AFHttpSessionManager.h"
#import "NextViewController.h"
#import "AFNetManager.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoV;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWD;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (nonatomic ,strong)dispatch_source_t timer;
@property (nonatomic ,assign)BOOL timerStatus;
// 服务器回参
@property (nonatomic ,strong)NSString *server;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timerStatus = NO;
   
}
- (IBAction)getVerfigyCode:(id)sender {
    
    if (![LegalVerify checkTel:self.userName.text]) {
        [self initialAlertControllerWithTitle:nil message:@"手机号码输入有误"];
        return ;
    }
    // 判断是否是会员
    NSDictionary *isMvpPara = @{@"phone":self.userName.text};
    [AFNetManager POST:kIsMemeberURL parameters:isMvpPara success:^(id result) {
        NSLog(@"== %@, = %@",result[@"result"][@"msg"],result);
        if ([result[@"status"] intValue] == 1) {
            // 获取验证码
            NSString *user = self.userName.text;
            NSDictionary *para = @{@"phone":user,@"type":@"2"};

            [AFNetManager POST:kVerifyCodeURL parameters:para success:^(id result) {
                NSLog(@"%@,%@",result[@"errorMessage"],result);
                
                if ([result[@"status"] intValue] == 1)
                {
                    self.server = [NSString stringWithFormat:@"%d",[result[@"status"] intValue]];
                    [self getTimerData];
                }
                else {
                    [self initialAlertControllerWithTitle:nil message:result[@"errorMessage"]];
                }
                
            } failure:^(id result) {
                NSLog(@" error == %@",result);
                [self initialAlertControllerWithTitle:nil message:@"链接服务器失败"];
            }];
        } else
        {
            [self initialAlertControllerWithTitle:nil message:result[@"result"][@"msg"]];
        }
        
    } failure:^(id result) {
        NSLog(@" error == %@",result);
        [self initialAlertControllerWithTitle:nil message:result];
    }];

    
}
- (void)getTimerData {
    self.timerStatus = YES;         // 定时器开启状态
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(self.timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(self.timer);
            self.timerStatus = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.verifyBtn.userInteractionEnabled = YES;
                self.verifyBtn.backgroundColor = [UIColor orangeColor];
            });
        }else{
            
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.verifyBtn setTitle:[NSString stringWithFormat:@"(%@)",strTime] forState:UIControlStateNormal];
                self.verifyBtn.userInteractionEnabled = NO;
                self.verifyBtn.backgroundColor = [UIColor grayColor];
            });
            timeout--;
        }
    });
    dispatch_resume(self.timer);
}

- (IBAction)login:(id)sender {
    if (![LegalVerify checkTel:self.userName.text]) {
        [self initialAlertControllerWithTitle:nil message:@"手机号码输入有误"];
        return ;
    } else {
        // 当定时器还未关闭时，关闭定时器
        if (self.timerStatus == 1) {
            dispatch_source_cancel(self.timer);
            [self.verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            self.verifyBtn.userInteractionEnabled = YES;
            self.verifyBtn.backgroundColor = [UIColor orangeColor];
            
        }
        // 登陆
        NSDictionary *para = @{@"phone":self.userName.text,@"password":self.passWD.text,@"code":self.passWD.text};
        [AFNetManager POST:kLoginURL parameters:para success:^(id result) {
            NSLog(@"resultLogin == %@,%@",result[@"result"][@"msg"],result);
            if ([result[@"status"] intValue] == 1) {
            [[NSUserDefaults standardUserDefaults] setValue:self.userName.text forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setValue:self.passWD.text forKey:@"password"];
            NextViewController *nextVC = [[NextViewController alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        } else {
            [self initialAlertControllerWithTitle:@"登陆失败" message:nil];
        }
            
        } failure:^(id result) {
            NSLog(@"result == %@ --",result);
            [self initialAlertControllerWithTitle:nil message:result];
        }];

    }
}
- (IBAction)procotolBtn:(id)sender {
    
}

// 提示框

- (void)initialAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:nil completion:^{
        [self performSelector:@selector(dismissAlert) withObject:nil afterDelay:1.5];
    }];

}
- (void)dismissAlert {
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
