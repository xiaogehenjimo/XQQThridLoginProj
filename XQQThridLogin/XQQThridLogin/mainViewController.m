//
//  mainViewController.m
//  XQQThridLogin
//
//  Created by XQQ on 2017/1/3.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import "mainViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "XQQThridLoginTool.h"

@interface mainViewController ()
/** QQ登录 */
@property(nonatomic, strong)  UIButton  *  loginBtn;
/** 微信登录 */
@property(nonatomic, strong)  UIButton  *  weiChatBtn;

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

/*微信登录*/
- (void)weiChat:(UIButton*)button{
    
}

/*QQ登录*/
- (void)QQLogin:(UIButton*)button{
    XQQThridLoginTool * tool = [XQQThridLoginTool sharedTool];
    [tool proceedQQLoginWithAppId:@"1105850149" completeBlock:^(BOOL isSuccess, TencentOAuth *tencentOAuth, NSString *errorDis) {
        NSLog(@"是否登录成功:%d 信息:%@",isSuccess,errorDis);
        if (isSuccess) {
            [tool getQQPersionalInfo:^(NSDictionary *infoDict) {
                NSLog(@"获取到的个人信息是:%@",infoDict);
            }];
        }
    }];
}


- (void)initUI{
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 44)];
    _loginBtn.backgroundColor = [UIColor yellowColor];
    [_loginBtn setTitle:@"QQ" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_loginBtn addTarget:self action:@selector(QQLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _weiChatBtn = [[UIButton alloc]initWithFrame:CGRectMake(_loginBtn.frame.origin.x, CGRectGetMaxY(_loginBtn.frame) + 20, 100, 44)];
    _weiChatBtn.backgroundColor = [UIColor yellowColor];
    [_weiChatBtn setTitle:@"微信" forState:UIControlStateNormal];
    [_weiChatBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_weiChatBtn addTarget:self action:@selector(weiChat:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weiChatBtn];
}

@end
