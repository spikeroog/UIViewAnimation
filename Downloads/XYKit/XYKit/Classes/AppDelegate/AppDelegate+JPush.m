//
//  AppDelegate+JPush.m
//  XYKit
//
//  Created by 元潇 on 2019/8/22.
//  Copyright © 2019年 元潇. All rights reserved.
//
#import "AppDelegate+JPush.h"

#define JPushKeyDev @"ab6c5dbd42c0fec79e338287"
#define JPushKeyDis @"92df06ff90e7d089d5ee6043"


@implementation AppDelegate (JPush)

- (void)configJPush:(NSDictionary *)launchOptions {
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    NSString *jpushKey = JPushKeyDis;
    BOOL isProduction = YES;
    
#if defined(DEBUG) || defined(_DEBUG)
    jpushKey = JPushKeyDev;
    isProduction = NO;
#endif
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:jpushKey
                          channel:@"App Store"
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
}

#pragma mark - app角标统计

- (void)receiveNotification {
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
}

- (void)resetBadgeNumber {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

#pragma mark - JPushRegisterDelegate

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)) {
    if (@available(iOS 10.0, *)) {
        if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            // 从通知界面直接进入应用
        } else {
            // 从通知设置界面进入应用
        }
    } else {
        // Fallback on earlier versions
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)) {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    
    [self receiveNotification];
}


// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)) {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();  // 系统要求执行这个方法
    
#pragma clang diagnostic push
    // 忽略废弃方法的警告
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:userInfo[@"title"] message:[NSString stringWithFormat:@"%@", userInfo[@"content"]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
#pragma clang diagnostic pop
   
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
#pragma clang diagnostic push
    // 忽略废弃方法的警告
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:[NSString stringWithFormat:@"%@", userInfo[@"aps"][@"alert"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
#pragma clang diagnostic pop
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}


@end
