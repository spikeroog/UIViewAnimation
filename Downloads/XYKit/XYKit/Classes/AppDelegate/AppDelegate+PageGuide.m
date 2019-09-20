//
//  AppDelegate+PageGuide.m
//  XYKit
//
//  Created by 元潇 on 2019/9/11.
//  Copyright © 2019年 元潇. All rights reserved.
//

#import "AppDelegate+PageGuide.h"

@implementation AppDelegate (PageGuide)

// 引导页配置(实现在引导页隐藏电池栏，引导页消失后显示电池栏)
- (void)configPageGuide {
    // .jpg图片需要在后面加上@"1.jpg"
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if (![kUserDefaults boolForKey:GuidancePage]) {
        
        [kUserDefaults setBool:YES forKey:GuidancePage];
        [kUserDefaults synchronize];
        
        XYBaseGuideViewController *guideVC = [[XYBaseGuideViewController alloc] init];
        // gif
        [guideVC buildWithImageArray:@[@"guideImage6.gif",
                                       @"guideImage7.gif",
                                       @"guideImage8.gif"]];
        _WeakSelf
        // 结束引导页的回调
        guideVC.guideBlock = ^{
            // 显示电池栏
            [UIApplication sharedApplication].statusBarHidden = NO;
            // 设置rootViewController
            weakSelf.window.rootViewController = [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:[[OBJBaseTabBarController alloc] init]];
        };
        
        self.window.rootViewController = guideVC;
        
    } else {
        // 显示电池栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        // 设置rootViewController
        self.window.rootViewController = [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:[[OBJBaseTabBarController alloc] init]];
    }
    
    [self.window makeKeyAndVisible];
}

@end
