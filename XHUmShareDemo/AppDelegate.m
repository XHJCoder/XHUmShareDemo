//
//  AppDelegate.m
//  XHUmShareDemo
//
//  Created by huahua on 16/4/12.
//  Copyright © 2016年 jxh. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [UMSocialData setAppKey:UMAppKey];
    [UMSocialWechatHandler setWXAppId:WeChatAppId appSecret:WeChatAppSecret url:@"http://www.jianshu.com/users/238e769238c2/latest_articles"];
    [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAppKey url:@"http://www.jianshu.com/users/238e769238c2/latest_articles"];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}


@end
