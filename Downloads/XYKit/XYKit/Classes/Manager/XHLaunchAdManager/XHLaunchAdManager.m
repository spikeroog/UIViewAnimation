//
//  XHLaunchAdManager.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/24.
//  Copyright © 2018 元潇. All rights reserved.
//

// 广告停留时间
#define kAdDelay 5.0f

#import "XHLaunchAdManager.h"

@interface XHLaunchAdManager ()
<XHLaunchAdDelegate>

@end

@implementation XHLaunchAdManager

+ (instancetype)sharedInstanced {
    static XHLaunchAdManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XHLaunchAdManager alloc] init];
    });
    return manager;
}

#pragma mark - 图片广告
/**
 图片广告

 @param imageUrl 图片Name或者图片Url
 @param openUrl 跳转网址
 */
- (void)configImageAdWithImageUrl:(NSString *)imageUrl
                      openUrl:(NSString *)openUrl {
    // 设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    // 使用默认配置
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
    imageAdconfiguration.duration = kAdDelay;
    // 广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = imageUrl;
    // 广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = openUrl;
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

#pragma mark - 视频广告

/**
 视频广告

 @param videoUrl 视频Name或Url
 @param openUrl 跳转链接
 */
- (void)configVideoAdWithVideoUrl:(NSString *)videoUrl
                           openUrl:(NSString *)openUrl {
    // 设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    // 使用默认配置
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration defaultConfiguration];
    // 广告视频URLString/或本地视频名(请带上后缀)
    videoAdconfiguration.videoNameOrURLString = videoUrl;
    videoAdconfiguration.duration = kAdDelay;
    // 广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    videoAdconfiguration.openModel = openUrl;
    videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
}

#pragma mark - XHLaunchAd delegate - 倒计时回调
/**
 *  倒计时回调
 *
 *  @param launchAd XHLaunchAd
 *  @param duration 倒计时时间
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration {
    
}

#pragma mark - XHLaunchAd delegate - 其他
/**
 广告点击事件回调
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint {
    
    DLog(@"广告点击事件");
    
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if(openModel == nil) return;
    
    XYBaseWebViewController *webVC = [[XYBaseWebViewController alloc] init];
    NSString *urlString = @"https://github.com/spikeroog";
    [webVC localHtmlWithUrl:urlString];
    // 此处不要直接取keyWindow
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    [rootVC.rt_navigationController pushViewController:webVC animated:YES];
}

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData {
    
    DLog(@"图片下载完成/或本地图片读取完成回调");
}

/**
 *  视频本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  视频保存在本地的path
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL {
    
    DLog(@"video下载/加载完成 path = %@",pathURL.absoluteString);
}

/**
 *  视频下载进度回调
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current {
    
    DLog(@"总大小=%lld,已下载大小=%lld,下载进度=%f",total,current,progress);
}

/**
 *  广告显示完成
 */
- (void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd {
    
    DLog(@"广告显示完成");
}



@end
