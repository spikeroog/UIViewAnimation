//
//  AppDelegate.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/11/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+CrashObserve.h"
#import "AppDelegate+BaiduMapSet.h"
#import "AppDelegate+JPush.h"
#import "AppDelegate+GlobalSet.h"
#import "AppDelegate+PageGuide.h"
#import "AppDelegate+FLEX.h"
#import "AppDelegate+IQKeyboardManager.h"
#import "AppDelegate+DataBaseIteration.h"
#import "AppDelegate+LaunchAd.h"
#import "AppDelegate+UM.h"
#import "AppDelegate+GouMai.h"
#import "AppDelegate+NetWorkStatusObserver.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 动态监听/动态修复 闪退
    [self listenCrashInfomation];
    
    // 配置百度地图
    [self configBaiduMap];
    
    // 配置极光推送
    [self configJPush:launchOptions];
    
    // 配置引导页
    [self configPageGuide];
    
    // 配置启动页广告
    [self configLaunchAd];
    
    // 数据库迭代(当app从AppStore更新时)
    [self dataBaseIteration];
    
    // 配置IQKeyboardManager
    [self configIQKeyboardManager];
    
    // 配置一些全局默认参数
    [self configGlobalset];
    
    // 监听网络状态
    [self netWorkStatusObserver];

    // 显示FLEX
    //    [self showFLEX];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
#if defined(DEBUG) || defined(_DEBUG)
    // 显示flex
    [[FLEXManager sharedManager] showExplorer];
#endif
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {
 
}


@end
