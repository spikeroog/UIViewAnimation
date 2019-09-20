//
//  AppDelegate+GouMai.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/7/14.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "AppDelegate+GouMai.h"

@implementation AppDelegate (GouMai)

// x宝
- (void)configZfbbGouMaiParam {
    
}

// wxx
- (void)configWxxGouMaiParam {
    
}

#pragma mark - AppDelete Cycle

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
/** iOS9及以后 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[XHPKit defaultManager] handleOpenURL:url];
    if (!result) { // 这里处理其他SDK(例如QQ登录,微博登录等)
        
    }
    return result;
}
#endif

/** iOS9以下 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[XHPKit defaultManager] handleOpenURL:url];
    if (!result) { // 这里处理其他SDK(例如QQ登录,微博登录等)
        
    }
    return result;
}

@end
