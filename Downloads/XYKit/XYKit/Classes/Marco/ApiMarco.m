//
//  ApiMarco.m
//  XYKit
//
//  Created by 元潇 on 2019/8/23.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "ApiMarco.h"

/*测试环境*/
#define kServiceDevUrl118 @""
#define kServiceDevUrl140 @""
#define kServiceDevUrl196 @""
/*正式环境*/
#define kServiceDisUrl @""

@implementation ApiMarco

/**
 动态识别内网外网url，不用在手动注释了

 @param ServiceDevUrlType 测试环境网址类型
 @return url
 */
+ (NSString *)identifyEnvironment:(ServiceDevUrlType)ServiceDevUrlType {
    
    NSString *disUrl = kServiceDisUrl; // 默认正式环境
    
#if defined(DEBUG) || defined(_DEBUG)
    // 如果是测试环境，识别对应的测试URL
    switch (ServiceDevUrlType) { // 如有需要可以继续加
        case ServiceDevUrlType118:
            disUrl = kServiceDevUrl118;
            break;
        case ServiceDevUrlType140:
            disUrl = kServiceDevUrl140;
            break;
        case ServiceDevUrlType196:
            disUrl = kServiceDevUrl196;
            break;
        default:
            break;
    }
#endif
    
    return disUrl;
}

@end
