//
//  AppDelegate+CrashObserve.m
//  FJAquaticProject
//
//  Created by 元潇 on 2019/8/4.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "AppDelegate+CrashObserve.h"

@implementation AppDelegate (CrashObserve)

/**
 该方法建议放在didFinishLaunchingWithOptions第一行，以免在多线程出现异常的情况
 */
- (void)listenCrashInfomation {
    [JJException registerExceptionHandle:self];

    [JJException configExceptionCategory:JJExceptionGuardAll];
    [JJException startGuardException];
}


/**
 崩溃消息和来自当前线程的额外信息

 @param exceptionMessage 崩溃消息
 @param info 额外的Info,key和value
 */
- (void)handleCrashException:(nonnull NSString *)exceptionMessage
                   extraInfo:(nullable NSDictionary *)info {
    
}

@end
