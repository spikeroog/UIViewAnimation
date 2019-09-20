//
//  XHPKitManager.h
//  BaseObjSet
//
//  Created by 元潇 on 2019/7/14.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHPKitManager : NSObject

/**
 x宝zhifu
 
 @param orderSign x宝订单签名
 @param completion zf结果
 */
+ (void)pForxBao:(NSString *)orderSign
          completion:(void(^)(BOOL completion))completion;

/**
 x信zhifu
 
 @param req 发起x信zf的消息模型
 @param completion zf结果
 */
+ (void)pForxXin:(XHPWxReq *)req
         completion:(void(^)(BOOL completion))completion;


@end

NS_ASSUME_NONNULL_END
