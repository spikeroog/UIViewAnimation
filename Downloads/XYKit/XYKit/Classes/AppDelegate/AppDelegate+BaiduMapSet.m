//
//  AppDelegate+BaiduMapSet.m
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/12.
//  Copyright © 2019年 元潇. All rights reserved.
//  注意：getter setter 方法里面千万不要出现self.xx
/*
 eg:- (void)setMark:(NSInteger)mark {
objc_setAssociatedObject(self, &markKey, @(mark), OBJC_ASSOCIATION_ASSIGN);
}
 mark直接使用传过来的值mark即可，不要使用self.mark
 */

#import "AppDelegate+BaiduMapSet.h"

#define BaiduMapAk @"onTk4xdFCTbASN5OxBrGErgh7naYlXlC"

// 扩展属性 对应的地址值, 保证 set/get 方法内使用的 地址完全一样。
static const void *mapManagerKey = &mapManagerKey;
static const void *managerKey = &managerKey;
static const void *markKey = &markKey;
static const void *briefKey = &briefKey;


@implementation AppDelegate (BaiduMapSet)

#pragma mark - runtime给分类添加属性
- (void)setMapManager:(BMKMapManager *)mapManager {
    objc_setAssociatedObject(self, &mapManagerKey, mapManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BMKMapManager *)mapManager {
    return objc_getAssociatedObject(self, &mapManagerKey);
}

- (void)setManager:(CLLocationManager *)manager {
    objc_setAssociatedObject(self, &managerKey, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CLLocationManager *)manager {
    return objc_getAssociatedObject(self, &managerKey);
}

- (void)setMark:(NSInteger)mark {
    objc_setAssociatedObject(self, &markKey, @(mark), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)mark {
    return [objc_getAssociatedObject(self, &markKey) integerValue];
}

- (void)setBrief:(NSString *)brief {
    objc_setAssociatedObject(self, &briefKey, brief, OBJC_ASSOCIATION_COPY);
}

- (NSString *)brief {
    return objc_getAssociatedObject(self, &briefKey);
}


#pragma mark - 

- (void)configBaiduMap {

    self.manager = [CLLocationManager new];
    [self.manager requestAlwaysAuthorization];
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:BaiduMapAk authDelegate:self];
    /**
     百度地图SDK所有API均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
     默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
     如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
     */
    self.mapManager = [[BMKMapManager alloc] init];
    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL]) {
        DLog(@"经纬度类型设置成功");
    } else {
        DLog(@"经纬度类型设置失败");
    }
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [self.mapManager start:BaiduMapAk  generalDelegate:self];
    if (!ret) {
        DLog(@"百度地图启动失败");
    } else {
        DLog(@"百度地图启动成功");
    }
}

#pragma mark - 百度地图
/**
 *@param iError 错误号 : 为0时验证通过，具体参加BMKLocationAuthErrorCode
 */
- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError {
    DLog(@"------------%@",@(iError));
    if (0 == iError) {
        DLog(@"Location成功");
    } else {
        DLog(@"Location失败：%ld", (long)iError);
        
    }
}

/**
 联网结果回调
 
 @param iError 联网结果错误码信息，0代表联网成功
 */
- (void)onGetNetworkState:(int)iError {
    if (0 == iError) {
        DLog(@"联网成功");
    } else {
        DLog(@"联网失败：%d", iError);
    }
}

/**
 鉴权结果回调
 
 @param iError 鉴权结果错误码信息，0代表鉴权成功
 */
- (void)onGetPermissionState:(int)iError {
    if (0 == iError) {
        DLog(@"授权成功");
    } else {
        DLog(@"授权失败：%d", iError);
    }
}


@end
