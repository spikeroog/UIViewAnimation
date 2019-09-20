//
//  AppDelegate+UM.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/24.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "AppDelegate.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (UM)
<UNUserNotificationCenterDelegate>

@end

NS_ASSUME_NONNULL_END
