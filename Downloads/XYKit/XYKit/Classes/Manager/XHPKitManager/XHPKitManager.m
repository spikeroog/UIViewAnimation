//
//  XHPKitManager.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/7/14.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "XHPKitManager.h"

@implementation XHPKitManager

/**
 x宝zhifu
 
 @param orderSign x宝订单签名
 @param completion zf结果
 */
+ (void)pForxBao:(NSString *)orderSign
      completion:(void(^)(BOOL completion))completion {
    [[XHPKit defaultManager] alipOrder:orderSign fromScheme:@"XHPKitExample" completed:^(NSDictionary *resultDict) {
        DLog(@"zf结果:\n%@",resultDict);
        NSInteger status = [resultDict[@"resultStatus"] integerValue];
        if (status == 9000) { // zf成功
            completion(YES);
        } else {
            completion(NO);
        }
    }];

}

/**
 x信zhifu
 
 @param req 发起x信zf的消息模型
 @param completion zf结果
 */
+ (void)pForxXin:(XHPWxReq *)req
      completion:(void(^)(BOOL completion))completion {
    // x信zf参数,下面7个参数,由后台签名订单后生成,并返回给客服端(与官方SDK一致)
    // 注意:请将下面参数设置为你自己真实订单签名后服务器返回参数,便可进行实际zf
    //    req.openID = @""; // x信开放平台审核通过的应用APPID
    //    req.partnerId = @""; // 商户号
    //    req.prepayId = @""; // 交易会话ID
    //    req.nonceStr = @""; // 随机串，防重发
    //    req.timeStamp = 1518156229; // 时间戳，防重发
    //    req.package = @""; // 扩展字段,暂填写固定值Sign=WXPay
    //    req.sign = @""; // 签名
    // 传入订单模型,拉起x信zf
    [[XHPKit defaultManager] wxpOrder:req completed:^(NSDictionary *resultDict) {
        DLog(@"zf结果:\n%@",resultDict);
        NSInteger code = [resultDict[@"errCode"] integerValue];
        if (code == 0) { // zf成功
            completion(YES);
        } else {
            completion(NO);
        }
    }];
}


@end
