//
//  ApiMarco.h
//  XYKit
//
//  Created by 元潇 on 2019/8/23.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import <Foundation/Foundation.h>

// 测试环境的type 映射表
typedef NS_ENUM(NSInteger, ServiceDevUrlType) {
    ServiceDevUrlType118 = 0,
    ServiceDevUrlType140,
    ServiceDevUrlType196
};

NS_ASSUME_NONNULL_BEGIN

/*当前测试环境，更换测试环境后在这里手动修改对应的枚举，无需注释代码*/
#define kServiceBaseUrl [self identifyEnvironment:ServiceDevUrlType118]



/*brief:api+xxx+Url格式*/
/*登录接口*/
#define apiLoginUrl [NSString stringWithFormat:@"%@%@", kServiceBaseUrl, @"login"]










@interface ApiMarco : NSObject
/**
 动态识别内网外网url，不用在手动注释了
 
 @param ServiceDevUrlType 测试环境网址类型
 @return url
 */
+ (NSString *)identifyEnvironment:(ServiceDevUrlType)ServiceDevUrlType;
@end

NS_ASSUME_NONNULL_END
