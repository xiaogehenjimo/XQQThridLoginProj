//
//  XQQThridLoginTool.m
//  XQQThridLogin
//
//  Created by XQQ on 2017/1/3.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import "XQQThridLoginTool.h"


@interface XQQThridLoginTool ()<TencentSessionDelegate>

@property (nonatomic, strong)  TencentOAuth  * tencentOAuth;
/** 登录完成的block */
@property (nonatomic, copy)   QQLoginBlock    completeBlock;
/** 获取个人信息回调block */
@property(nonatomic, strong)  getQQInfoBlock  getInfoBlock;

@end


@implementation XQQThridLoginTool

+ (instancetype)sharedTool{
    static XQQThridLoginTool * tool = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool = [[XQQThridLoginTool alloc]init];
    });
    return tool;
}

/*进行QQ登录*/
- (void)proceedQQLoginWithAppId:(NSString*)AppId
                  completeBlock:(QQLoginBlock)completeBlock{
    if (completeBlock) {
        _completeBlock = completeBlock;
    }
    _tencentOAuth=[[TencentOAuth alloc]initWithAppId:AppId andDelegate:self];
    NSArray * permissions= [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo",@"add_t",nil];
    [_tencentOAuth authorize:permissions inSafari:NO];
}

/*获取QQ个人信息*/
- (void)getQQPersionalInfo:(getQQInfoBlock)complete{
    if (complete) {
        _getInfoBlock = complete;
    }
    [_tencentOAuth getUserInfo];
}


/*获取用户数据回调*/
-(void)getUserInfoResponse:(APIResponse *)response
{
     NSDictionary * infoDict = response.jsonResponse;
    if (self.getInfoBlock) {
        if (infoDict) {
            self.getInfoBlock(infoDict);
        }
    }
}

#pragma mark -- TencentSessionDelegate

/*登陆完成调用*/
- (void)tencentDidLogin{
    
    BOOL isAccessToken = _tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length];
    NSString * disStr = isAccessToken ? @"成功" : @"登录不成功";
    if (_completeBlock) {
       _completeBlock(isAccessToken,_tencentOAuth,disStr);
    }
}

/*非网络错误导致登录失败*/
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    NSString * disStr = cancelled ? @"用户取消登录" : @"登录失败";
    if (_completeBlock) {
        _completeBlock(NO,_tencentOAuth,disStr);
    }
}

/*网络错误导致登录失败*/
-(void)tencentDidNotNetWork{
    if (_completeBlock) {
        _completeBlock(NO,_tencentOAuth,@"网络原因登录失败");
    }
}

@end
