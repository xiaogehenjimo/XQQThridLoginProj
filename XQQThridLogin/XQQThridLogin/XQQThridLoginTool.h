//
//  XQQThridLoginTool.h
//  XQQThridLogin
//
//  Created by XQQ on 2017/1/3.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>

/*进行QQ登录的回调*/
typedef void(^QQLoginBlock)(BOOL isSuccess,TencentOAuth * tencentOAuth,NSString*errorDis);
/*获取个人信息的回调*/
typedef void(^getQQInfoBlock)(NSDictionary * infoDict);


@interface XQQThridLoginTool : NSObject


+ (instancetype)sharedTool;

/*进行QQ登录*/
- (void)proceedQQLoginWithAppId:(NSString*)AppId
                  completeBlock:(QQLoginBlock)completeBlock;

/*获取QQ个人信息*/
- (void)getQQPersionalInfo:(getQQInfoBlock)complete;

@end
