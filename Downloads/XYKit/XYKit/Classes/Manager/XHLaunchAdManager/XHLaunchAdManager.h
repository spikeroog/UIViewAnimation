//
//  XHLaunchAdManager.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/24.
//  Copyright © 2018 元潇. All rights reserved.
//
/*
 Usage: 需要在plist文件中加入
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
 </dict>
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHLaunchAdManager : NSObject

+ (instancetype)sharedInstanced;

/**
 图片广告
 
 @param imageUrl 图片Name或者图片Url
 @param openUrl 跳转网址
 */
- (void)configImageAdWithImageUrl:(NSString *)imageUrl
                          openUrl:(NSString *)openUrl;

/**
 视频广告
 
 @param videoUrl 视频Name或Url
 @param openUrl 跳转链接
 */
- (void)configVideoAdWithVideoUrl:(NSString *)videoUrl
                          openUrl:(NSString *)openUrl;

@end

NS_ASSUME_NONNULL_END
