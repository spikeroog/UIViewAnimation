//
//  AppDelegate+JPush.h
//  XYKit
//
//  Created by 元潇 on 2019/8/22.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "AppDelegate.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (JPush)
<JPUSHRegisterDelegate>

- (void)configJPush:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
