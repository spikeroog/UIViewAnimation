//
//  AppTipsDefines.h
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/21.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 引导页
UIKIT_EXTERN  NSString * const GuidancePage;
// 判断app是否第一次安装时启动
UIKIT_EXTERN  NSString * const FirstInstallStart;
// 判断app是否第一次安装时启动或者app更新后第一次启动
UIKIT_EXTERN  NSString * const FirstInstallOrUpdateStart;
// 网络状态发生改变
UIKIT_EXTERN  NSString * const NetWorkStatusChanged;


@interface AppTipsDefines : NSObject
@end

NS_ASSUME_NONNULL_END
