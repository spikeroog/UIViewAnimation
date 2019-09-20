//
//  AppDelegate+BaiduMapSet.h
//  BaseObjSet
//
//  Created by 元潇 on 2019/8/12.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (BaiduMapSet)
<BMKLocationAuthDelegate,BMKGeneralDelegate>
@property (nonatomic, strong) BMKMapManager *mapManager; //主引擎类
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, assign) NSInteger mark;
@property (nonatomic, copy) NSString *brief;

- (void)configBaiduMap;

@end

NS_ASSUME_NONNULL_END
