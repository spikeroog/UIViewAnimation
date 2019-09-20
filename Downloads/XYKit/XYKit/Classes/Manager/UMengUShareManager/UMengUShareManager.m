//
//  UMengUShareManager.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/24.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "UMengUShareManager.h"
#import "UMengUShareMarco.h"
#import "AppDelegate.h"

@implementation UMengUShareManager

+ (void)UMAnalyticStart {
    // 友盟统计
    UMConfigInstance.appKey = LMJThirdSDKUMConfigInstanceAppKey;
    //    UMConfigInstance.ChannelId:@"Web" 中的Web 替换为您应用的推广渠道。channelId为nil或@""时，默认会被当作@"App Store"渠道。
    UMConfigInstance.channelId = LMJThirdSDKUMConfigInstanceChannelId;
    
    [MobClick setAppVersion:XcodeAppVersion];
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    /** 设置是否开启background模式, 默认YES. */
    //    [MobClick setBackgroundTaskEnabled:YES];
    
#ifdef DEBUG
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setLogEnabled:YES];
#endif
}


+ (void)UMSocialStart {
    // 友盟分享
    
    // 设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:LMJThirdSDKUMSocialAppkey];
    
    // 获取友盟social版本号
    DLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    // 设置x信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:LMJThirdSDKWeChatAppKey appSecret:LMJThirdSDKWeChatAppSecret redirectURL:LMJThirdSDKWeChatRedirectURL];
    
    
    // 设置分享到QQ互联的appKey和appSecret
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:LMJThirdSDKQQAppKey  appSecret:LMJThirdSDKQQAppSecret redirectURL:LMJThirdSDKQQRedirectURL];
    
    // 设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:LMJThirdSDKSinaAppKey  appSecret:LMJThirdSDKSinaAppSecret redirectURL:LMJThirdSDKSinaRedirectURL];
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession), @(UMSocialPlatformType_WechatTimeLine), @(UMSocialPlatformType_Qzone)]];
    
    // 如果不想显示平台下的某些类型，可用以下接口设置
    //    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_AlipaySession),@(UMSocialPlatformType_Email),@(UMSocialPlatformType_Sms), @(UMSocialPlatformType_WechatFavorite), @(UMSocialPlatformType_TencentWb)]];
#ifdef DEBUG
    // 打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
#endif
}

+ (void)UMPushStart:(NSDictionary *)launchOptions {
    // UM推送
    // 初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
    [UMessage startWithAppkey:LMJThirdSDKUMessageStartWithAppkey launchOptions:launchOptions];
    
    // 注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    // iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    center.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UNAuthorizationOptions types10 = UNAuthorizationOptionBadge |   UNAuthorizationOptionAlert | UNAuthorizationOptionSound;
    
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
            DLog(@"用户允许");
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
            DLog(@"用户拒绝");
        }
    }];
    
#ifdef DEBUG
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
#endif
    
}


#pragma mark - 分享

+ (void)shareTitle:(NSString *)title subTitle:(NSString *)subTitle thumbImage:(NSString *)thumbImage shareURL:(NSString *)shareURL {
    // 显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType shareTitle:title subTitle:subTitle thumbImage:thumbImage shareURL:shareURL];
    }];
}

// 网页分享自定义
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType shareTitle:(NSString *)title subTitle:(NSString *)subTitle thumbImage:(NSString *)thumbImage shareURL:(NSString *)shareURL {
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:subTitle thumImage:thumbImage];
    
    // 设置网页地址
    shareObject.webpageUrl = shareURL;
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    
    // 调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                // 分享结果消息
                DLog(@"response message is %@",resp.message);
                // 第三方原始返回的数据
                DLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                DLog(@"response data is %@",data);
            }
            // 分享成功的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:NNKeyShared object:shareURL];
        }
        [self alertWithError:error];
    }];
}


// 网页分享
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
    // 设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    // 调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                // 分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                // 第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        
        [self alertWithError:error];
        
    }];
}

// 分享文本
+ (void)shareTextToPlatformType:(UMSocialPlatformType)platformType {
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    // 设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    // 调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}


// 分享图片
+ (void)shareImageToPlatformType:(UMSocialPlatformType)platformType {
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    // 如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    [shareObject setShareImage:@"https://mobile.umeng.com/images/pic/home/social/img-1.png"];
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    // 调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}

// 分享音乐
+ (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType {
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 创建音乐内容对象
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    // 设置音乐网页播放地址
    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
    //            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    // 调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}


// 分享视频
+ (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType {
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    // 设置视频网页播放地址
    shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
    //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    // 调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}



#pragma mark - alert
+ (void)alertWithError:(NSError *)error {
    [UtilityTools showAlertWithTitle:nil message:nil sureMessage:@"分享成功" cancelMessage:@"分享失败" thirdMessage:nil style:UIAlertControllerStyleAlert target:self sureHandler:^{
        
    } cancelHandler:^{
        
    } thirdHandler:^{
        
    }];
}



#pragma mark - 第三方登录
+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType completion:(void(^)(UMSocialUserInfoResponse *result, NSError *error))completion {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        DLog(@" uid: %@", resp.uid);
        DLog(@" openid: %@", resp.openid);
        DLog(@" accessToken: %@", resp.accessToken);
        DLog(@" refreshToken: %@", resp.refreshToken);
        DLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        DLog(@" name: %@", resp.name);
        DLog(@" iconurl: %@", resp.iconurl);
        DLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        DLog(@" originalResponse: %@", resp.originalResponse);
        
        completion(resp, error);
        
    }];
}

#pragma mark - 统计
+ (void)beginLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick beginLogPageView:NSStringFromClass(pageView)];
}

+ (void)endLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick endLogPageView:NSStringFromClass(pageView)];
}

+ (void)beginLogPageViewName:(NSString *)pageViewName {
    [MobClick beginLogPageView:pageViewName];
}

+ (void)endLogPageViewName:(NSString *)pageViewName {
    [MobClick endLogPageView:pageViewName];
}

@end
