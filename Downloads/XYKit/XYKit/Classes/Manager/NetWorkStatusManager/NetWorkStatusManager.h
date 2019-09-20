//
//  NetWorkStatusManager.h
//  BaseObjSet
//
//  Created by 元潇 on 2019/2/13.
//  Copyright © 2019 元潇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkStatusManager : NSObject


+ (instancetype) shareInstanced;

/**
 实时监听网络变化
 
 @param handle 返回变化后的网络状态
 */
- (void)addNetWorkStatusObserver:(void(^)(NSString *netWorkStatusStr, PPNetworkStatusType status))handle;

@end

NS_ASSUME_NONNULL_END
