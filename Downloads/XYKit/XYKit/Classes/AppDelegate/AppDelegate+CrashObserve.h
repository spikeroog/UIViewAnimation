//
//  AppDelegate+CrashObserve.h
//  FJAquaticProject
//
//  Created by 元潇 on 2019/8/4.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "AppDelegate.h"
#import "JJException.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (CrashObserve)<JJExceptionHandle>

/**
 该方法建议放在didFinishLaunchingWithOptions第一行，以免在多线程出现异常的情况
 */
- (void)listenCrashInfomation;

@end

NS_ASSUME_NONNULL_END
