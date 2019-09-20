//
//  AppDelegate+NetWorkStatusObserver.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/13.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "AppDelegate+NetWorkStatusObserver.h"
#import "NetWorkStatusManager.h"

@implementation AppDelegate (NetWorkStatusObserver)

/**
 实时监听网络状态
 */
- (void)netWorkStatusObserver {
    [[NetWorkStatusManager shareInstanced] addNetWorkStatusObserver:^(NSString * _Nonnull netWorkStatusStr, PPNetworkStatusType status) {
        
    }];
}

@end
