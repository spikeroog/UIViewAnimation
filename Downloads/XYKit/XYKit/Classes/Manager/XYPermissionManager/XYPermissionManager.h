//
//  XYPermissionManager.h
//  XYKit
//
//  Created by 元潇 on 2019/9/2.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import <Foundation/Foundation.h>

/** info.plist中加入
 <key>NSAppleMusicUsageDescription</key>
 <string>App需要您的同意,才能访问媒体资料库</string>
 <key>NSBluetoothPeripheralUsageDescription</key>
 <string>App需要您的同意,才能访问蓝牙</string>
 <key>NSCalendarsUsageDescription</key>
 <string>App需要您的同意,才能访问日历</string>
 <key>NSCameraUsageDescription</key>
 <string>App需要您的同意,才能访问相机</string>
 <key>NSContactsUsageDescription</key>
 <string>App需要您的同意,才能访问通讯录</string>
 <key>NSHealthShareUsageDescription</key>
 <string>App需要您的同意,才能访问健康分享</string>
 <key>NSHealthUpdateUsageDescription</key>
 <string>App需要您的同意,才能访问健康更新 </string>
 <key>NSLocationAlwaysUsageDescription</key>
 <string>App需要您的同意,才能始终访问位置</string>
 <key>NSLocationUsageDescription</key>
 <string>App需要您的同意,才能访问位置</string>
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>App需要您的同意,才能在使用期间访问位置</string>
 <key>NSMicrophoneUsageDescription</key>
 <string>App需要您的同意,才能访问麦克风</string>
 <key>NSMotionUsageDescription</key>
 <string>App需要您的同意,才能访问运动与健身</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>App需要您的同意,才能访问相册</string>
 <key>NSRemindersUsageDescription</key>
 <string>App需要您的同意,才能访问提醒事项</string>
 */

// 权限类型
typedef enum : NSUInteger {
    PermissionTypeCamera,           // 相机
    PermissionTypeMic,              // 麦克风
    PermissionTypePhoto,            // 相册
    PermissionTypeLocationWhen,     // 地理位置
    PermissionTypeCalendar,         // 日历
    PermissionTypeContacts,         // 联系人
    PermissionTypeBlue,             // 蓝牙
    PermissionTypeRemaine,          // 提醒
    PermissionTypeHealth,           // 健康
    PermissionTypeMediaLibrary,     // 多媒体
    PermissionTypeNotification      // 通知推送
} PermissionType;

typedef void (^callBack) (BOOL granted, id  data);

NS_ASSUME_NONNULL_BEGIN

@interface XYPermissionManager : NSObject

/** 提示 strong修饰 **/
@property (nonatomic, strong) NSString *tip;

+ (instancetype)shareInstance;

/**
 获取权限
 
 @param type 类型
 @param showAlert 是否显示 没有权限时，跳转设置的alert
 @param block 回调
 */
- (void)permissonType:(PermissionType)type
            showAlert:(BOOL)showAlert
           withHandle:(callBack)block;

@end

NS_ASSUME_NONNULL_END
