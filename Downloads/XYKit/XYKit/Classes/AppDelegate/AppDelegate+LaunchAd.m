//
//  AppDelegate+LaunchAd.m
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/24.
//  Copyright © 2018 元潇. All rights reserved.
//

#import "AppDelegate+LaunchAd.h"

@implementation AppDelegate (LaunchAd)
// 2.5 4.5
- (void)configLaunchAd {
    // app第一次安装时候不显示广告页
    if (![UtilityTools isApplicationFirstInstallLoad]) {
        NSString *imageurl = @"https://resource-upload-server.oss-cn-beijing.aliyuncs.com/launch_image_1.gif?Expires=1546054110&OSSAccessKeyId=TMP.AQGPOPXIWol2PIJJor-DrTBFLkF7Lmg3dj0RcRCeEqODOh-QTiONyGJ-HbNvAAAwLAIUOwFJ6rhPEczaq2h5xZdDLaBAJu8CFBwpzjbPQXsLf3E3oK9c3Q2C2BDQ&Signature=ZqKCR8fE50XObaOSqtpmS%2Bd3SQs%3D";
        NSString *imageopenurl = @"http://www.it7090.com";
        [[XHLaunchAdManager sharedInstanced] configImageAdWithImageUrl:imageurl openUrl:imageopenurl];

//        NSString *videourl = @"https://resource-upload-server.oss-cn-beijing.aliyuncs.com/spikeroog/launch_video_1.mp4?Expires=1545806642&OSSAccessKeyId=TMP.AQFAGguxN05ZHGn5Y5ZnrRlYuUBNEoJ8-0Q1GFnhpfAHvUXBMzZlNxU3MTAOADAtAhQnxCan0g6-gzpJfDGxX8DYbcQjrgIVAIvUH8v4-o9xqoNYVkqAZSGnwuyL&Signature=BbYF8j2IUQ%2BDaPrfdGBDRQuuk4E%3D";
//        NSString *videoopenurl = @"http://www.it7090.com";
//        [[XHLaunchAdManager sharedInstanced] configVideoAdWithVideoUrl:videourl openUrl:videoopenurl];
    }
}

@end
